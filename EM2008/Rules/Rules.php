<?php
require_once("Page.php");

class Rules extends HTMLPage implements Page {
	public function getHTML() {
		// TODO EM/WM Unterst�tzung
		include('layout/rules_WM.tpl');
	}
}
?>