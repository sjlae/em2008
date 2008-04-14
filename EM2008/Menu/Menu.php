<?php

class Menu {
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