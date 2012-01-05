<?php
require_once("Page.php");
require_once('Datenbank/db.php');

class Password extends HTMLPage implements Page {

	private $link = '';

	private $errors = array();
	private $email = '';
	
	public function __construct() {
		$this->link = Db::getConnection();
	}

	public function init() {
		$action = isset($_GET['action']) ? $_GET['action'] : '';

		if($action == "new") {
			return $this->newPassword();
		}
		return true;
	}
	
	public function newPassword() {
		$this->email = $_POST['email'];
		
		if(!$this->checkExistingEmail($this->email)) {
			$this->errors[] = "Es existiert kein registrierter Spieler mit dieser E-Mail Adresse.";
		}
		else{
			$newpwd = $this->genRandomString();
			$pwd = md5($newpwd);

			$abfrage = "Update user set passwort='$pwd' where email='$this->email'";
			mysql_query($abfrage);
			
			if(!Constants::isLocal()){
		 		$sender = "silvan.staeheli@gmx.ch";
				$empfaenger = $this->email;
				$betreff = "Neues Passwort auf tippy.ch";
				$mailtext = "Hallo<br><br>
				Hier ist dein neu generiertes Passwort, mit welchem du ab sofort bei tippy einloggen kannst:<br><br>
				<b>$newpwd</b><br><br>
				Bitte beachte, dass die Gross-/Kleinschreibung relevant ist. Sobald du dich eingeloggt hast, kannst du 
				das Passwort unter dem Men&uuml;punkt 'Passwort &auml;ndern' wieder wechseln.<br><br>
				Sportliche Gr&uuml;sse<br>
				Silvan St&auml;heli";
				mail($empfaenger, $betreff, $mailtext, "From: $sender\n" . "Content-Type: text/html; charset=iso-8859-1\n"); 
		 	}
		 	$_SESSION['infos'][] = "Du hast soeben auf die angegebene E-Mail Adresse das neue Passwort erhalten.";

		 	header('location:	index.php?go=login');
		 	return false;
		}
		return true;
	}

	private function genRandomString() {
	    $length = 10;
	    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
	    $string = '';    
	
	    for ($p = 0; $p < $length; $p++) {
	        $string .= $characters[mt_rand(0, strlen($characters))];
	    }
	
	    return $string;
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
	
	public function getHTML() {
		include('layout/password.tpl');
	}
}
?>