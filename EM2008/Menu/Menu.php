<?php
class Menu {
	public function getMenu() {
		$registered = $this->isRegistered();
		
		if($registered) {
			return 'Menu/layout/registered.tpl';
		}
		else {
			return 'Menu/layout/notRegistered.tpl';
		}
		
	}
	
	private function isRegistered() {
		return false;
	}
}
?>