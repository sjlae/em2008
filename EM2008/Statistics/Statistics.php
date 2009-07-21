<?php
require_once("Page.php");
require_once('Datenbank/db.php');

class Statistics extends HTMLPage implements Page {

	private $link = '';
	private $vorrunde = array();
	
	public function __construct() {
		$this->link = Db::getConnection();
		$this->getData();
	}

	private function getData() {
		$abfrage = "SELECT * FROM vorrundeteams";

		$ergebnis = mysql_query($abfrage);

		$i = 0;

		while($row = mysql_fetch_assoc($ergebnis))
		{
			$this->vorrunde[$i]['id'] = $row['vorrundeteamsid'];
			$this->vorrunde[$i]['start'] = date('d.m.Y H:i', strtotime($row['start']));
			$this->vorrunde[$i]['team1'] = $this->getTeam($row['team1fsid']);
			$this->vorrunde[$i]['team2'] = $this->getTeam($row['team2fsid']);
			$this->vorrunde[$i]['total_1'] = $this->getTotal_1($row['vorrundeteamsid']);
			$this->vorrunde[$i]['total_X'] = $this->getTotal_X($row['vorrundeteamsid']);
			$this->vorrunde[$i]['total_2'] = $this->getTotal_2($row['vorrundeteamsid']);
			$i++;
		}
	}
	
	private function getTeam($id) {
		if($id != ''){
			$abfrage = "SELECT * FROM teams where teamid=".$id;

			$ergebnis = mysql_query($abfrage);
			while($row = mysql_fetch_assoc($ergebnis))
			{
				return $row['land'];
			}
		}
	}
	
	private function getTotal_1($id){
		$abfrage = "SELECT result1, result2 FROM vorrunde where vorrundeteamsfsid=".$id;
		$ergebnis = mysql_query($abfrage);
		
		$counter = 0;
		
		while($row = mysql_fetch_assoc($ergebnis))
		{
			if($this->isValid($row['result1'], $row['result2'])){
				if($row['result1'] > $row['result2']){
					$counter++;
				}
			}
		}
		
		return $counter;
	}
	
	private function getTotal_X($id){
		$abfrage = "SELECT result1, result2 FROM vorrunde where vorrundeteamsfsid=".$id;
		$ergebnis = mysql_query($abfrage);
		
		$counter = 0;
		
		while($row = mysql_fetch_assoc($ergebnis))
		{
			if($this->isValid($row['result1'], $row['result2'])){
				if($row['result1'] == $row['result2']){
					$counter++;
				}
			}
		}
		
		return $counter;
	}
	
	private function getTotal_2($id){
		$abfrage = "SELECT result1, result2 FROM vorrunde where vorrundeteamsfsid=".$id;
		$ergebnis = mysql_query($abfrage);
		
		$counter = 0;
		
		while($row = mysql_fetch_assoc($ergebnis))
		{
			if($this->isValid($row['result1'], $row['result2'])){
				if($row['result1'] < $row['result2']){
					$counter++;
				}
			}
		}
		
		return $counter;
	}
	
	private function isValid($result1, $result2){
		if($result1 != '' && $result2 != '' && $result1 >=0 && $result2 >=0 && is_numeric($result1) && is_numeric($result2)){
			return true;
		}
		else{
			return false;
		}
	}
	
	public function getHTML() {
		include('layout/statistics.tpl');
	}
}
?>