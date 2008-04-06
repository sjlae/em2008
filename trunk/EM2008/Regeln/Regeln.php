<?php
require_once("Page.php");

class Regeln implements Page {
public function getView() {
		include('layout/regeln.tpl');
	}
}
?>