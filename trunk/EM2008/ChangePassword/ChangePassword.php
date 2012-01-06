<?php
require_once("Page.php");
require_once('Datenbank/db.php');

class ChangePassword extends HTMLPage implements Page {

	private $link = '';

	private $oldPassword = '';
	private $newPassword1 = '';
	private $newPassword2 = '';
	
	public function __construct() {
		$this->link = Db::getConnection();
	}

	public function init() {
		$action = isset($_GET['action']) ? $_GET['action'] : '';

		if($action == "change") {
			return $this->savePassword();
		}
		return true;
	}
	
	private function savePassword(){
		$this->oldPassword = $_POST['oldPassword'];
		$this->newPassword1 = $_POST['newPassword1'];
		$this->newPassword2 = $_POST['newPassword2'];
		$userid = $_SESSION['userid'];
		$numberOfErrors = 0;
		
		if($this->oldPassword == '' || $this->newPassword1 == '' || $this->newPassword2 == ''){
			$this->errors[] = "Bitte alle drei Felder ausf&uuml;llen";
			$numberOfErrors++;	
		}
		
		$query = mysql_query("SELECT passwort FROM user where userid='$userid'");
		$result = mysql_fetch_assoc($query);
		
		if(md5($this->oldPassword) != $result['passwort']){
			$this->errors[] = "Das alte Passwort ist falsch.";
			$numberOfErrors++;	
		}
		
		if($this->newPassword1 != $this->newPassword2){
			$this->errors[] = "Die beiden Wert f&uuml;r das neue Passwort sind nicht identisch.";
			$numberOfErrors++;	
		}
		
		if($numberOfErrors == 0){
			$newpwd = md5($this->newPassword1);
			$abfrage = "Update user set passwort='$newpwd' where userid='$userid'";
			mysql_query($abfrage);
			$_SESSION['infos'][] = "Das Passwort wurde erfolgreich ge&auml;ndert.";
			$this->oldPassword = '';
			$this->newPassword1 = '';
			$this->newPassword2 = '';
		}
		
		return true;
	}
	
	public function getHTML() {
		include('layout/changepassword.tpl');
	}
}
?>