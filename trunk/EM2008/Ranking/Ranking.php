<?php
require_once("Page.php");
require_once('Datenbank/db.php');

class Ranking extends HTMLPage implements Page {
	
	private $link = '';
	
	public function __construct() {
		$this->link = Db::getConnection();
	}

	public function getHTML() {
		$count = "SELECT COUNT(*) FROM user";
		$countPlayers = mysql_query($count);
		
		$countNotPayed = "SELECT COUNT(*) FROM user WHERE bezahlt = 0";
		$countPlayersNotPayed = mysql_query($countNotPayed);
		
		$abfrage = "SELECT userid, vorname, nachname, punkte, bezahlt, rank_last, rank_now FROM user ORDER BY punkte DESC, nachname";

		$ergebnis = mysql_query($abfrage);
		
		if($ergebnis != null){
			$counter = 0;
			while($row = mysql_fetch_assoc($ergebnis))
			{
				$rankingArray[$counter]['userid'] = $row['userid'];
				$rankingArray[$counter]['vorname'] = $row['vorname'];
				$rankingArray[$counter]['nachname'] = $row['nachname'];
				$rankingArray[$counter]['punkte'] = $row['punkte'];
				$rankingArray[$counter]['bezahlt'] = $row['bezahlt'];
				$rankingArray[$counter]['last'] = $row['rank_last'];
				$rankingArray[$counter]['now'] = $row['rank_now'];

				if($_SESSION['eingeloggt']){
					if($_SESSION['userid'] == $rankingArray[$counter]['userid']){
						$currentPlace = $rankingArray[$counter]['now'];
					}
				}
				
				$counter++;
			}
		}
		include('layout/ranking.tpl');
	}




}
?>