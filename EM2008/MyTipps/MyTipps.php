<?php
require_once("Page.php");

class MyTipps extends HTMLPage implements Page {
public function getHTML() {
		include('layout/myTipps.tpl');
	}
}
?>