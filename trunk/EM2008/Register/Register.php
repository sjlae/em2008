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

	private $link = '';

	public function __construct() {
		$this->link = Db::getConnection();
	}

	public function register() {

		$this->nachname = $_POST['nachname'];
		$this->vorname = $_POST['vorname'];
		$this->email = $_POST['email'];
		$this->passwort1 = $_POST['passwort1'];
		$this->passwort2 = $_POST['passwort2'];
		$where = $_POST['where'];

		if($this->vorname == '' || strlen($this->vorname) > 10)
		$this->errors[] = "Bitte das Feld 'Vorname' ausf&uuml;llen und nicht mehr als 10 Zeichen verwenden";
		if($this->nachname == '' || strlen($this->nachname) > 15)
		$this->errors[] = "Bitte das Feld 'Name' ausf&uuml;llen und nicht mehr als 15 Zeichen verwenden";
		if($this->email == '')
		$this->errors[] = "Bitte das Feld 'Email' ausf&uuml;llen";
		if($this->passwort1 == '') {
			$this->errors[] = "Bitte das Feld 'Passwort' ausf&uuml;llen";
			if($this->passwort2 == '')
			$this->errors[] = "Bitte das Feld 'Passwort wiederholen' ausf&uuml;llen";
		}else if($this->passwort1 != $this->passwort2) {
			$this->errors[] = "Bitte zwei Mal das gleiche Passwort w&auml;hlen";
		}
		if($this->checkExistingEmail($this->email)) {
			$this->errors[] = "Diese Email ist schon vorhanden";
		}

		if(count($this->errors) == 0) {
			
			$pwd = md5($this->passwort1);

			$query = sprintf("Insert into user(nachname, vorname, email, passwort, rank_now, rank_last, woherfsid) values('%s', '%s', '%s', '%s', '%s',' %s', '%s')", htmlentities(mysql_real_escape_string($this->nachname, $this->link)), htmlentities(mysql_real_escape_string($this->vorname, $this->link)), htmlentities(mysql_real_escape_string($this->email, $this->link)), htmlentities(mysql_real_escape_string($pwd, $this->link)), '1', '1', htmlentities(mysql_real_escape_string($where, $this->link)));
				
			mysql_query($query,$this->link);

		 if (mysql_affected_rows($this->link) > 0) {
		 	$_SESSION['infos'][] = "Sie wurden erfolgreich registriert";

		 	header('location:	index.php?go=login');
		 	return false;
		 }
		}

		return true;
	}

	public function checkExistingEmail($email) {
		$abfrage = sprintf("SELECT * FROM user where email='%s'", htmlentities(mysql_real_escape_string($email, $this->link)));

		$result = mysql_query($abfrage);

		while($row = mysql_fetch_assoc($result))
		{
			return true;
		}
		return false;
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
		$abfrage = "SELECT * FROM woher";

		$ergebnis = mysql_query($abfrage);

		while($row = mysql_fetch_assoc($ergebnis))
		{
			$wheres[] = $row['bezeichnung'];
		}
		include('layout/register.tpl');
	}
}
?>