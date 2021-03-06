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
		if($this->email == '' || $this->passwort == '')
		$this->errors[] = "Bitte beide Felder ausf&uuml;llen und keine Sonderzeichen verwenden";
			
		if(count($this->errors) == 0) {

			$this->passwort = md5($this->passwort);
				
			$abfrage = sprintf("SELECT * FROM user where email='%s' and passwort='%s'",  htmlentities($this->email, ENT_QUOTES, 'UTF-8'), htmlentities($this->passwort, ENT_QUOTES, 'UTF-8'));

			$ergebnis = mysql_query($abfrage, $this->link);
				
			$ok = false;
			while($row = mysql_fetch_assoc($ergebnis))
			{
				$ok = true;
				$_SESSION['eingeloggt'] = true;
				$_SESSION['userid'] = $row['userid'];
				$_SESSION['infos'][] = "Du hast erfolgreich eingeloggt";

				$zeitspanne = 300; //Sekunden
				$ip = $_SERVER['REMOTE_ADDR'];
				$userid = isset($_SESSION['userid']) ? $_SESSION['userid'] : '0';
				$ip_full = $ip.'_'.$userid;
				
				//Zeitpunkt erneuern
				mysql_query("UPDATE useronline SET ip = '".$ip_full."', zeit = '".(time()+$zeitspanne)."', userfsid = $userid WHERE ip='".$ip."'");
								
				// open file
				$fd = fopen("log.txt", "a");
				// write string
				$str = "[" . date("Y/m/d H:i:s", mktime()) . ' '. $row['vorname'] . ' '. $row['nachname'] . ' hat eingeloggt'; 
				fwrite($fd, $str. "\n");
				// close file
				fclose($fd);
				
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