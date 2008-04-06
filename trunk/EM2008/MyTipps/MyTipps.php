<?php
require_once("Page.php");

class MyTipps implements Page {
public function getView() {
		include('layout/myTipps.tpl');
	}
}
?>