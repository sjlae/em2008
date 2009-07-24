<?php
require_once("Page.php");
require_once('Datenbank/db.php');

class Guestbook extends HTMLPage implements Page {
	
	private $entries = array();
	private $text = '';
	
	public function __construct() {
		$this->link = Db::getConnection();
		
		$action = isset($_GET['action']) ? $_GET['action'] : '';
		
		if($action == "newEntry"){
			$this->saveNewEntry();	
		}
		
		$this->getData();
	}

	private function getData() {
		$abfrage = "Select * from guestbook order by timestamp DESC LIMIT 20";
		$ergebnis = mysql_query($abfrage);
		
		for($i = 1; $row = mysql_fetch_assoc($ergebnis); $i++)
		{
			$this->entries[$i]['name'] = $row['user'];
			$this->entries[$i]['timestamp'] = date('d.m.Y H:i', strtotime($row['timestamp']));
			$this->entries[$i]['text'] = $row['text'];
		}
	}
	
	private function saveNewEntry() {
		$this->text = $_POST['text'];
				
		if($this->text != null){
			if(strlen($this->text) > 255){
				$this->errors[] = "Dein G&auml;stebucheintrag darf nicht mehr als 255 Zeichen enthalten!";
			}
			else{
				$userid = $_SESSION['userid'];
				
				$abfrage = "Select nachname, vorname from user where userid='$userid'";
				$ergebnis = mysql_query($abfrage);
				$row = mysql_fetch_assoc($ergebnis);
							
				$abfrage = "Insert into guestbook (user, text) values ('".$row['vorname']." ".$row['nachname']."', '".$this->text."')";
				$ergebnis = mysql_query($abfrage);
				
				$this->text = '';
			}	
		}
	}
	
	public function getHTML() {
		include('layout/guestbook.tpl');
	}
}
?>