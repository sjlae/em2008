<?php
require_once('Login/Login.php');
require_once('Page.php');

class LoggedIn extends Login{
	public static function isRegistered(Page $page) {
	$registered = $_SESSION['eingeloggt'];
	$userid = $_SESSION['userid'];
		if($registered || $userid) {
			$page->getView();
		} else {
			$login = new Login();
			$login->getView(); 
		}
	}
	public static function isAdmin(Page $page) {
		$registered = $_SESSION['eingeloggt'];
		if($registered) {
			$abfrage = "SELECT * FROM user where userid='".$_SESSION['userid']."'";
	
			$ergebnis = mysqli_query(Db::getConnection(), $abfrage);
			
			while($row = mysqli_fetch_assoc($ergebnis))
			{
				if($row['admin'] == '1'){
					$page->getView();
				}
				else{
					$home = new Home();
					$home->getView();
				}
			}
		}
		else{
			$login = new Login();
			$login->getView(); 
		}	
	}
}
?>