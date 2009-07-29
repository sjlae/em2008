<?php
require_once('Page.php');
require_once('Home/Home.php');
require_once('Datenbank/db.php');



class Login extends HTMLPage implements Page{

	private $errors = array();

	private $email = '';
	private $passwort = '';

	private $link = '';

	public function __construct() {
		$this->link = Db::getConnection();
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
				
			$abfrage = sprintf("SELECT * FROM user where email='%s' and passwort='%s'",  htmlentities(mysql_real_escape_string($this->email, $this->link), ENT_COMPAT, 'UTF-8'), htmlentities(mysql_real_escape_string($this->passwort, $this->link), ENT_COMPAT, 'UTF-8'));

			$ergebnis = mysql_query($abfrage, $this->link);
				
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