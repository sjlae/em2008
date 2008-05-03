<?php
require_once("Page.php");
require_once('Datenbank/db.php');

class Ranking extends HTMLPage implements Page {
	
	private $link = '';

	public function __construct() {
		$this->link = Db::getConnection();
	}

	public function getHTML() {
		$abfrage = "SELECT vorname, nachname, punkte, bezahlt FROM user ORDER BY punkte DESC";

		$ergebnis = mysql_query($abfrage);

		$counter = 0;

		while($row = mysql_fetch_assoc($ergebnis))
		{
			$rankingArray[$counter]['vorname'] = $row['vorname'];
			$rankingArray[$counter]['nachname'] = $row['nachname'];
			$rankingArray[$counter]['punkte'] = $row['punkte'];
			$rankingArray[$counter]['bezahlt'] = $row['bezahlt'];
				
			$counter++;
		}
		include('layout/ranking.tpl');
	}




}
?>