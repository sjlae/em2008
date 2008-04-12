<?php

class Menu {
	public function getMenu() {
		$registered = $_SESSION['eingeloggt'];
		echo $_SESSION['eingeloggt'];
		if($registered == 'yes') {
			return 'Menu/layout/registered.tpl';
		}
		else {
			return 'Menu/layout/notRegistered.tpl';
		}
		
	}
}
?>