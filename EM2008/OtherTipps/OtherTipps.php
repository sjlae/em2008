<?php
require_once("Page.php");

class OtherTipps extends HTMLPage implements Page {
public function getHTML() {
		include('layout/otherTipps.tpl');
	}
}
?>