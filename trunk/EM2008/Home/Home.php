<?php

include_once('Page.php');

class Home extends HTMLPage implements Page{
	public function __construct() {
	}
	
	public function getHTML() {
		include('layout/home.tpl');
	}
}

?>