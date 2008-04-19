<?php
require_once("Page.php");
require_once('Datenbank/db.php');

class Register extends HTMLPage implements Page {
	
	private $errors = array();
			
	private $nachname = '';
	private $vorname = '';
	private $email = '';
	private $passwort1 = '';
	private $passwort2 = '';
	private $where = '';
	
	public function __construct() {
		
	}

	public function register() {
				
		$this->nachname = $_POST['nachname'];
		$this->vorname = $_POST['vorname'];
		$this->email = $_POST['email'];
		$this->passwort1 = $_POST['passwort1'];
		$this->passwort2 = $_POST['passwort2'];
		$$where = $_POST['where'];
		
		if($this->nachname == '') {
			$this->errors[] = "Bitte das Feld 'Name' ausf&uuml;llen";
		}
		if($this->vorname == '')
			$this->errors[] = "Bitte das Feld 'Vorname' ausf&uuml;llen";
		if($this->email == '')
			$this->errors[] = "Bitte das Feld 'Email' ausf&uuml;llen";
		if($this->passwort1 == '') {
			$this->errors[] = "Bitte das Feld 'Passwort' ausf&uuml;llen";
			if($this->passwort2 == '')
				$this->errors[] = "Bitte das Feld 'Passwort wiederholen' ausf&uuml;llen";
		}else if($this->passwort1 != $this->passwort2) {
			$this->errors[] = "Bitte zwei Mal das gleiche Passwort w&auml;hlen";
		}
		
		if(count($this->errors) == 0) {
			$pwd = md5($this->passwort1);
			
			$query = "Insert into User(nachname, vorname, email, passwort, woherfsid) values('".$this->nachname."', '".$this->vorname."', '".$this->email."', '".$this->passwort1."', '".$this->where."')";
			
			mysql_query($query);
			
			$_SESSION['infos'][] = "Sie wurden erfolgreich registriert";
			
			header('location:	index.php?go=login');
			return false;
		}
		
		return true;
	}
	
	/**
	 * @override
	 */
	public function init() {
		$action = isset($_GET['action']) ? $_GET['action'] : '';
		
		if($action == "register") {
			return $this->register();
		}
		
		return true;
	}

	public function getHTML() {
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