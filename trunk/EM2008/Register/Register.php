<?php
require_once("Page.php");
require_once('Datenbank/db.php');

class Register implements Page {
	public function __construct() {
		$action = $_GET['action'];
		$go = $_GET['go'];
		if($action == "register") {
			$this->regsiter();
		}
		if($go == 'register') {
			$this->getView();
		}
	}

	public function register() {
		$nachname = $_POST['nachname'];
		$vorname = $POST_['vorname'];
		$email = $_POST['email'];
		$passwort1 = $_POST['passwort1'];
		$passwort2 = $_POST['passwort2'];
		
		if($nachname == '');
			$_SESSION['errors'][] = "Bitte das Feld 'Name' ausf&uuml;llen";
		if($nachname == '');
			$_SESSION['errors'][] = "Bitte das Feld 'Vorname' ausf&uuml;llen";
		if($nachname == '');
			$_SESSION['errors'][] = "Bitte das Feld 'Email' ausf&uuml;llen";
		if($nachname == '');
			$_SESSION['errors'][] = "Bitte das Feld 'Passwort' ausf&uuml;llen";
		if($nachname == '');
			$_SESSION['errors'][] = "Bitte das Feld 'Name' ausf&uuml;llen";
	}

	public function getView() {
			$abfrage = "SELECT * FROM Woher";

			$ergebnis = mysql_query($abfrage);
			
			while($row = mysql_fetch_assoc($ergebnis))
			{
				$wheres[] = $row['bezeichnung'];
			}
			include('layout/register.tpl');
	}
}
?>