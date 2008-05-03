<?php
require_once('Datenbank/db.php');

class Menu {

	private $link = '';

	public function __construct() {
		$this->link = Db::getConnection();
	}

	public function getMenu() {
		$registered = $_SESSION['eingeloggt'];
		if($registered) {
			return 'Menu/layout/registered.tpl';
		}
		else {
			return 'Menu/layout/notRegistered.tpl';
		}
	}
}
?>