<?php
require_once("Page.php");

class Register implements Page {
public function getView() {
		include('layout/register.tpl');
	}
}
?>