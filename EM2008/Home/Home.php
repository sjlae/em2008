<?php

include_once('Page.php');

class Home implements Page{
	public function __construct() {
	}
	
	public function getView() {
		include('layout/home.tpl');
	}
}

?>