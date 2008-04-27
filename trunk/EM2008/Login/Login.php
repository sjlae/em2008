<?php
require_once('Page.php');
require_once('Home/Home.php');
require_once('Datenbank/db.php');

class Login extends HTMLPage implements Page{
	
	private $errors = array();
	
	private $email = '';
	private $passwort = '';
	
	public function __construct() {
	}

	public function checkLogin(Page $page) {
		$registered = $_SESSION['eingeloggt'];
		if($registered == 'yes') {
			$page->getView();
		} else {
			$this->getView();
		}
	}

	private function login() {
		$this->email = $_POST['email'];
		$this->passwort = $_POST['passwort'];
		if($this->email == '')
			$this->errors[] = "Bitte das Feld 'Email' ausf&uuml;llen";
		if($this->passwort == '')
			$this->errors[] = "Bitte das Feld 'Passwort' ausf&uuml;llen";
			
		if(count($this->errors) == 0) {


			$this->passwort = md5($this->passwort);

			$abfrage = "SELECT * FROM user where email='".$this->email."' and passwort='".$this->passwort."'";

			$ergebnis = mysql_query($abfrage);
			
			$ok = false;
			while($row = mysql_fetch_assoc($ergebnis))
			{
				$ok = true;
				$_SESSION['eingeloggt'] = true;
				$_SESSION['userid'] = $row['userid'];
				$_SESSION['infos'][] = "Sie haben erfolgreich eingeloggt";
				
			
				header('location:index.php');
				return false;
			}
			if($ok == false) {
				$this->errors[] = "Email und Passwort stimmen nicht &uuml;berein";
			}
		}
		
		return true;
	}
	
	public function init() {
		$action = isset($_GET['action']) ? $_GET['action'] : '';
		
		if($action == "login") {
			return $this->login();
		}
		
		return true;
	}
	
	public function getHTML() {
		include('layout/login.tpl');
	}
}
?>