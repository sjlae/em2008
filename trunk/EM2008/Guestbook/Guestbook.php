<?php
require_once("Page.php");
require_once('Datenbank/db.php');

class Guestbook extends HTMLPage implements Page {
	
	private $entries = array();
	private $text = '';
	private $link = '';
	
	public function __construct() {
		$this->link = Db::getConnection();
		
		$action = isset($_GET['action']) ? $_GET['action'] : '';
		
		if($action == "newEntry"){
			$this->saveNewEntry();	
		}
		
		$this->getData();
	}

	private function getData() {
		$abfrage_guest = "Select * from guestbook order by timestamp DESC LIMIT 20";
		$ergebnis_guest = mysql_query($abfrage_guest);
		
		if(!empty($ergebnis_guest)){
			for($i = 1; $row = mysql_fetch_assoc($ergebnis_guest); $i++)
			{	
				$userid = $row['userfsid'];
				$abfrage = "Select nachname, vorname from user where userid = $userid";
				$ergebnis = mysql_query($abfrage);
				$row_user = mysql_fetch_assoc($ergebnis);
				
				$this->entries[$i]['name'] = $row_user['vorname'] . " " . $row_user['nachname'];
				$this->entries[$i]['timestamp'] = date('d.m.Y H:i', strtotime($row['timestamp']));
				$this->entries[$i]['text'] = $row['text'];
			}
		}
	}
	
	private function saveNewEntry() {
		$this->text = htmlentities(mysql_real_escape_string(trim($_POST['text']), $this->link));
				
		if($this->text != null){
			if(strlen($this->text) > 255){
				$this->errors[] = "Dein G&auml;stebucheintrag darf nicht mehr als 255 Zeichen enthalten!";
			}
			else{
				$userid = $_SESSION['userid'];
						
				$abfrage = "Insert into guestbook (userfsid, text) values ('$userid', '".$this->text."')";
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