<?php
require_once("Page.php");
require_once('Datenbank/db.php');

class Register implements Page {
	public function __construct() {
		$action = $_GET['action'];
		$go = $_GET['go'];
		if($action == "register") {
			$this->register();
		}
		if($go == 'register') {
			$this->getView();
		}
	}

	public function register() {
		$nachname = $_POST['nachname'];
		$vorname = $_POST['vorname'];
		$email = $_POST['email'];
		$passwort1 = $_POST['passwort1'];
		$passwort2 = $_POST['passwort2'];
		$where = $_POST['where'];
		
		if($nachname == '')
			$_SESSION['errors'][] = "Bitte das Feld 'Name' ausf&uuml;llen";
		if($vorname == '')
			$_SESSION['errors'][] = "Bitte das Feld 'Vorname' ausf&uuml;llen";
		if($email == '')
			$_SESSION['errors'][] = "Bitte das Feld 'Email' ausf&uuml;llen";
		if($passwort1 == '') {
			$_SESSION['errors'][] = "Bitte das Feld 'Passwort' ausf&uuml;llen";
			if($passwort2 == '')
				$_SESSION['errors'][] = "Bitte das Feld 'Passwort wiederholen' ausf&uuml;llen";
		}else if($passwort1 != $passwort2) {
			$_SESSION['errors'][] = "Bitte zwei Mal das gleiche Passwort w&auml;hlen";
		}
		
		if(count($_SESSION['errors']) == 0) {
			$pwd = md5($passwort1);
			
			$query = "Insert into User(nachname, vorname, email, passwort, woherfsid) values('".$nachname."', '".$vorname."', '".$email."', '".$pwd."', '".$where."')";
			
			mysql_query($query);
			
			$_SESSION['infos'][] = "Sie wurden erfolgreich registriert";
		}
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