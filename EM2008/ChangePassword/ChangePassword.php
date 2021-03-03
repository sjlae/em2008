<?php
require_once("Page.php");
require_once('Datenbank/db.php');

class ChangePassword extends HTMLPage implements Page {

	private $link = '';

	private $oldPassword = '';
	private $newPassword1 = '';
	private $newPassword2 = '';
	private $reminder = '';
	private $userid = '';
	private $action = '';
	
	public function __construct() {
		$this->link = Db::getConnection();
	}

	public function init() {
		$this->action = isset($_GET['action']) ? $_GET['action'] : '';
		$this->userid = $_SESSION['userid'];
		
		if($this->action == "change") {
			return $this->savePassword();
		}
		
		else if($this->action == "reminder") {
			return $this->saveReminder();
		}
		
		return true;
	}
	
	private function savePassword(){
		$this->oldPassword = $_POST['oldPassword'];
		$this->newPassword1 = $_POST['newPassword1'];
		$this->newPassword2 = $_POST['newPassword2'];
		$numberOfErrors = 0;
		
		if($this->oldPassword == '' || $this->newPassword1 == '' || $this->newPassword2 == ''){
			$this->errors[] = "Bitte alle drei Felder ausf&uuml;llen";
			$numberOfErrors++;	
		}
		
		$query = mysqli_query($this->link, "SELECT passwort FROM user where userid='$this->userid'");
		$result = mysqli_fetch_assoc($query);
		
		if(md5($this->oldPassword) != $result['passwort']){
			$this->errors[] = "Das alte Passwort ist falsch.";
			$numberOfErrors++;	
		}
		
		if($this->newPassword1 != $this->newPassword2){
			$this->errors[] = "Die beiden Werte f&uuml;r das neue Passwort sind nicht identisch.";
			$numberOfErrors++;	
		}
		
		if($numberOfErrors == 0){
			$newpwd = md5($this->newPassword1);
			$abfrage = "Update user set passwort='$newpwd' where userid='$this->userid'";
			mysqli_query($this->link, $abfrage);
			$_SESSION['infos'][] = "Das Passwort wurde erfolgreich ge&auml;ndert.";
			$this->oldPassword = '';
			$this->newPassword1 = '';
			$this->newPassword2 = '';
		}
		
		return true;
	}
	
	private function saveReminder(){
		$this->reminder = $_POST['reminder'] == 'on' ? '1' : '0';
		$abfrage = "Update user set reminder='$this->reminder' where userid='$this->userid'";
		mysqli_query($this->link, $abfrage);
		$_SESSION['infos'][] = "Die Reminder-Einstellungen wurden erfolgreich gespeichert.";
		
		return true;
	}
	
	public function getHTML() {
		$abfrage = "Select reminder FROM user where userid = $this->userid";
		$ergebnis = mysqli_query($this->link, $abfrage);
		$result = mysqli_fetch_row($ergebnis);
		$this->reminder = $result[0];

		include('layout/changepassword.tpl');
	}
}
?>