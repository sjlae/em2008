<?php
require_once('Login/Login.php');

class LoggedIn extends Login {
	public function isRegistered() {
		return $_SESSION['eingeloggt'];
	}
}
?>