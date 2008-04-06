<?php
require_once("Page.php");

class OtherTipps implements Page {
public function getView() {
		include('layout/otherTipps.tpl');
	}
}
?>