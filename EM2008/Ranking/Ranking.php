<?php
require_once("Page.php");

class Ranking extends HTMLPage implements Page {
public function getHTML() {
		include('layout/ranking.tpl');
	}
}
?>