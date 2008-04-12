<?php
require_once('Page.php');
require_once('Home/Home.php');
require_once('Datenbank/db.php');

class Login implements Page{

	public function __construct() {
		$action = $_GET['action'];
		$go = $_GET['go'];
		if($action == "login") {
			$this->login();
		}
		if($go == 'login') {
			$this->getView();
		}
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
		$email = $_POST['email'];
		$passwort = $_POST['passwort'];

		if($email == '')
			$_SESSION['errors'][] = "Bitte das Feld 'Email' ausf&uuml;llen";
		if($passwort == '')
			$_SESSION['errors'][] = "Bitte das Feld 'Passwort' ausf&uuml;llen";
			
		if(count($_SESSION['errors']) == 0) {

			$passwort = md5($passwort);

			@mysql_connect("localhost", "root", "") OR die(mysql_error());
			mysql_select_db("em2008") OR die(mysql_error());

			$abfrage = "SELECT * FROM User where email='".$email."' and passwort='".$passwort."'";

			$ergebnis = mysql_query($abfrage);
			
			$ok = false;
			
			while($row = mysql_fetch_assoc($ergebnis))
			{
				$ok = true;
				$_SESSION['eingeloggt'] = 'yes';
				$_SESSION['infos'][] = "Sie haben erfolgreich eingeloggt";
			}
			if($ok == false) {
				$_SESSION['errors'][] = "Email und Passwort stimmen nicht &uuml;berein";
			}
		}
	}

	public function getView() {
		include('layout/login.tpl');
	}
}
?>