<?php
require_once("Page.php");

class Rules implements Page {
public function getView() {
		include('layout/rules.tpl');
	}
}
?>