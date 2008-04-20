<?php
require_once('Login/Login.php');
require_once('Page.php');

class LoggedIn extends Login{
	public static function isRegistered(Page $page) {
	$registered = $_SESSION['eingeloggt'];
		if($registered) {
			$page->getView();
		} else {
			$login = new Login();
			$login->getView(); 
		}
	}
}
?>