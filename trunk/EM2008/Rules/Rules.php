<?php
require_once("Page.php");

class Rules extends HTMLPage implements Page {
	public function getHTML() {
		// TODO EM/WM Unterstützung
		include('layout/rules_WM.tpl');
	}
}
?>