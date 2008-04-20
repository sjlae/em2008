<?php
require_once('Page.php');
require_once('Home/Home.php');
require_once('Datenbank/db.php');

class Admin extends HTMLPage implements Page{
	
	private $nnb = array();
	
	public function __construct() {
		$action = isset($_GET['action']) ? $_GET['action'] : '';
		
		if($action == 'nnb') {
			$this->setPayFlag();
		}
	}
	
	private function setPayFlag() {
		$stop = false;
		
		for($i=0; $stop != true; $i++) {
			if(isset($_POST['user'+$i])) {
				$userChecked = $_POST['user'+$i];	
			}
		}
	}
	
	private function getNNB() {
		$abfrage = "SELECT * FROM user where bezahlt=0";

		$ergebnis = mysql_query($abfrage);
		$counter = 0;
		
		while($row = mysql_fetch_assoc($ergebnis))
		{
			$this->nnb[$counter]['userid'] = $row['userid'];
			$this->nnb[$counter]['nachname'] = $row['nachname'];
			$this->nnb[$counter]['vorname'] = $row['vorname'];
			$this->nnb[$counter]['email'] = $row['email'];
			
			$counter++;
		}
	}
	
	public function getHTML() {
		$this->getNNB();
		require_once('layout/admin.tpl');
	}
}
?>