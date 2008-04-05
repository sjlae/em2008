<?php
include_once('Page.php');

class Login implements Page{
	
	public function __construct() {
	
	}
	
	public function checkLogin(Page $page) {
		$registered = true;
		if($registered) {
			$page->getView();
		} else {
			$this->getView();
		}
	}
	
	public function getView() {
		include('layout/login.tpl');
	}
}
?>