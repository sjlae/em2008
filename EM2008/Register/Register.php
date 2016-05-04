<?php
require_once("Page.php");
require_once('Datenbank/db.php');

class Register extends HTMLPage implements Page {

	private $errors = array();

	private $wheres = array();
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
		
		if (!preg_match('/^[a-zA-Z0-9][a-zA-Z0-9\._\-&!?=#]*@/', $this->email)) {
		  // $email ist ungültig, weil der lokale Teil nicht gültig ist
		  $this->errors[] = "Deine eingegebene Email ist ung&uuml;ltig";
		}
		else {
		  	// Alles ausser der Domain aus der Email löschen
		  	$domain = preg_replace('/^[a-zA-Z0-9][a-zA-Z0-9\._\-&!?=#]*@/', '', $this->email);
		  	// Prüfen, ob die Domain registriert ist (funktioniert NICHT unter windows)!
			if (!Constants::isLocal() && !checkdnsrr($domain)) {
		  		$this->errors[] = "Deine eingegebene Email ist ung&uuml;ltig";
		  	}
		}	
		
		if(!preg_match('/^\d$/', $where)){
			$this->errors[] = "Wie auch immer du das angestellt hast, aber da lief nicht alles mit legalen Mitteln!";
		}
		
		if(count($this->errors) == 0) {
			
			$pwd = md5($this->passwort1);

			$query = sprintf("Insert into user(nachname, vorname, email, passwort, rank_now, rank_last, woherfsid) values('%s', '%s', '%s', '%s', '%s',' %s', '%s')", htmlentities($this->nachname, ENT_QUOTES, 'UTF-8'), htmlentities($this->vorname, ENT_QUOTES, 'UTF-8'), htmlentities($this->email, ENT_QUOTES, 'UTF-8'), htmlentities($pwd, ENT_QUOTES, 'UTF-8'), '1', '1', htmlentities($where, ENT_QUOTES, 'UTF-8'));
				
			mysql_query($query,$this->link);

		 if (mysql_affected_rows($this->link) > 0) {
		 	if(!Constants::isLocal()){
		 		$sender = "info@tippy.ch";
				$empfaenger = $this->email;
				$betreff = "Erfolgreiche Registrierung bei tippy";
				$mailtext = "Hallo $this->vorname<br><br>
				Super, hast du dich bei tippy.ch angemeldet. Ab sofort kannst du deine Tipps erfassen, im G&auml;stebuch Kommentare schreiben, 
				die Statistiken betrachten oder Tipps der Konkurrenten ansehen. Ich rate dir jedoch (falls noch nicht geschehen), zuerst die 
				Spielregeln zu lesen, denn es gibt noch viel mehr Funktionen bei tippy.ch!<br><br>
				Damit du auch tats&auml;chlich am Tippspiel teilnehmen kannst, ben&ouml;tige ich von dir noch <b>Fr. 20.00 </b> ! Am liebsten wäre
				es mir, wenn du mir das Geld direkt auf mein Bankkonto &uuml;berweisen k&ouml;nntest oder mir via Paymit schickst:<br><br>
				IBAN: CH75 0021 4214 4048 4640 T<br>
				ADRESSE: Silvan St&auml;heli, Tannenrauchstrasse 102, 8038 Z&uuml;rich<br><br>
				Handy-Nummer: 079 605 73 21<br><br>
				<b>WICHTIG:</b> Bitte unbedingt deinen Namen (wie du ihn bei Tippy erfasst hast) als Kommentar hinzuf&uuml;gen, damit ich erkenne, 
				von wem die Fr. 20.00 stammen !<br><br>
				Dann bleibt mir nichts mehr anderes &uuml;brig als dir viel Gl&uuml;ck und Spass bei tippy zu w&uuml;nschen.<br><br>
				Sportliche Gr&uuml;sse<br>
				Silvan St&auml;heli";
				mail($empfaenger, $betreff, $mailtext, "From: $sender\n" . "Content-Type: text/html; charset=iso-8859-1\n"); 
		 	}
		 	
		 	$_SESSION['infos'][] = "Du wurdest erfolgreich registriert und hast soeben eine E-Mail erhalten";

		 	header('location:	index.php?go=login');
		 	return false;
		 }
		}

		return true;
	}

	public function checkExistingEmail($email) {
		$abfrage = sprintf("SELECT * FROM user where email='%s'", htmlentities($email, ENT_QUOTES, 'UTF-8'));

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
			$this->wheres[] =$row['bezeichnung'];
		}
		include('layout/register.tpl');
	}
}
?>