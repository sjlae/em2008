<?php
require_once('Datenbank/db.php');

class Menu {

	private $link = '';
	
	public function __construct() {
		$this->link = Db::getConnection();
	}

	public function getMenu() {
		$this->userOnline();
		
		$registered = $_SESSION['eingeloggt'];
		if($registered) {
			return 'Menu/layout/registered.tpl';
		}
		else {
			return 'Menu/layout/notRegistered.tpl';
		}
	}
	
	private function userOnline(){
		$this->link = Db::getConnection();
		
		$zeitspanne = 300; //Sekunden
		$ip = $_SERVER['REMOTE_ADDR'];
		$userid = isset($_SESSION['userid']) ? $_SESSION['userid'] : '0';
		if(isset($_SESSION['userid'])){
			$ip = $ip.'_'.$userid;
		}
		//veraltete Einträge löschen
		mysql_query("DELETE FROM useronline WHERE zeit < ".time()."");
		
		//Zeitpunkt erneuern
		mysql_query("UPDATE useronline SET zeit = '".(time()+$zeitspanne)."', userfsid = $userid WHERE ip='".$ip."'");
		
		// ist der Besucher noch nicht eigetragen, so wird ein neuer Eintrag erzeugt.
		$query = "SELECT ip from useronline WHERE ip='".$ip."'";
		$daten = mysql_query($query);
		
		if(mysql_num_rows($daten) == 0) {
			mysql_query("INSERT INTO useronline (ip,zeit,userfsid) VALUES ('$ip ','".(time()+$zeitspanne)."','$userid')");
		}
		
		// die Zahl der Online-User ermitteln.
		$result = mysql_query("SELECT count(*) FROM useronline");
		
		// namen der eingeloggten users ermitteln
		$query_online_names = "SELECT userfsid from useronline";
		$daten_online_names = mysql_query($query_online_names);
		
		$names = '';
		$first = true;
		
		while($row = mysql_fetch_assoc($daten_online_names))
		{
			$userid = $row['userfsid'];
			
			if($userid != 0){
				$actual_name = "SELECT nachname, vorname from user WHERE userid = $userid";
				$actual_name_result = mysql_query($actual_name);
				
				$row_user_name = mysql_fetch_assoc($actual_name_result);
				
				if($first){
					$names = "<b>davon eingeloggt:</b><br>";
					$first = false;
				}
				
				$names = $names . $row_user_name['vorname'] . " " . $row_user_name['nachname'] . "<br>";
			}	
		}
		if($names != ''){
			$_SESSION['users_names'] = $names;
		}
		$_SESSION['users'] = "&nbsp;" .mysql_result($result,0)." User online";
	}
}
?>