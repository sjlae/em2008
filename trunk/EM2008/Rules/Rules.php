<?php
require_once("Page.php");
require_once("Constants.php");

class Rules extends HTMLPage implements Page {
	public function getHTML() {
		if(Constants::$isWM){
			include('layout/rules_WM.tpl');
		}
		else{
			include('layout/rules_EM.tpl');
		}
	}
}
?>