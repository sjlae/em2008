<?php
require_once("Page.php");

class Ranking implements Page {
public function getView() {
		include('layout/ranking.tpl');
	}
}
?>