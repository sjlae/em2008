<?php
require_once("Page.php");

class Rules extends HTMLPage implements Page {
	public function getHTML() {
		include('layout/rules.tpl');
	}
}
?>