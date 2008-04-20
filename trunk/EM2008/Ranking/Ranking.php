<?php
require_once("Page.php");
require_once('Datenbank/db.php');

class Ranking extends HTMLPage implements Page {
		
	public function getHTML() {
		$abfrage = "SELECT vorname, nachname, punkte, bezahlt FROM User ORDER BY User.punkte DESC";

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
	
	public function __construct() {
	}
	
}
?>