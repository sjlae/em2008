<?php
require_once("Page.php");
require_once('Datenbank/db.php');
require_once('Constants.php');

class Statistics extends HTMLPage implements Page {

	private $link = '';
	private $vorrunde = array();
	private $hauptrunde = array();
	
	private $achtelfinal = array();
	private $viertelfinal = array();
	private $halbfinal = array();
	private $final = array();
	private $sieger = array();
	
	public function __construct() {
		$this->link = Db::getConnection();
		$this->getData();
	}

	private function getData() {
		$abfrage_groups = "SELECT * FROM vorrundeteams order by start asc";
		$ergebnis_groups = mysql_query($abfrage_groups);

		$i = 0;

		while($row = mysql_fetch_assoc($ergebnis_groups))
		{
			$this->vorrunde[$i]['id'] = $row['vorrundeteamsid'];
			$this->vorrunde[$i]['start'] = date('d.m.Y H:i', strtotime($row['start']));
			$this->vorrunde[$i]['team1'] = is_numeric($row['team1fsid']) ? $this->getTeam($row['team1fsid']) : $row['team1fsid'];
			$this->vorrunde[$i]['team2'] = is_numeric($row['team2fsid']) ? $this->getTeam($row['team2fsid']) : $row['team2fsid'];
			$this->vorrunde[$i]['total_1'] = $this->getTotal_1($row['vorrundeteamsid']);
			$this->vorrunde[$i]['total_X'] = $this->getTotal_X($row['vorrundeteamsid']);
			$this->vorrunde[$i]['total_2'] = $this->getTotal_2($row['vorrundeteamsid']);
			$i++;
		}
		
		$abfrage_finals = "SELECT * FROM teams order by land ASC";
		$ergebnis_finals = mysql_query($abfrage_finals);

		$i = 0;

		while($row = mysql_fetch_assoc($ergebnis_finals))
		{
			$this->hauptrunde[$i]['id'] = $row['teamid'];
			$this->hauptrunde[$i]['team'] = $row['land'];
			$i++;
		}
		
		$abfrage_hauptrunde = "SELECT * FROM hauptrunde";
		$ergebnis_hauptrunde = mysql_query($abfrage_hauptrunde);
	
		$test = 0;
		
		while($row = mysql_fetch_assoc($ergebnis_hauptrunde))
		{
			if(Constants::$isWM){
				$counter_achtel = 1;
				while($counter_achtel <= 16){
					$this->achtelfinal[$row['achtelfinal'.$counter_achtel]] = $this->achtelfinal[$row['achtelfinal'.$counter_achtel]] != '' ? $this->achtelfinal[$row['achtelfinal'.$counter_achtel]] + 1 : 1;
					$counter_achtel++;
				}
			}
			
			$counter_viertel = 1;
			while($counter_viertel <= 8){
				$this->viertelfinal[$row['viertelfinal'.$counter_viertel]] = $this->viertelfinal[$row['viertelfinal'.$counter_viertel]] != '' ? $this->viertelfinal[$row['viertelfinal'.$counter_viertel]] + 1 : 1;
				$counter_viertel++;
			}
			
			$counter_halb = 1;
			while($counter_halb <= 4){
				$this->halbfinal[$row['halbfinal'.$counter_halb]] = $this->halbfinal[$row['halbfinal'.$counter_halb]] != '' ? $this->halbfinal[$row['halbfinal'.$counter_halb]] + 1 : 1;
				$counter_halb++;
			}
			
			$counter_final = 1;
			while($counter_final <= 2){
				$this->final[$row['final'.$counter_final]] = $this->final[$row['final'.$counter_final]] != '' ? $this->final[$row['final'.$counter_final]] + 1 : 1;
				$counter_final++;
			}
						
			$this->sieger[$row['sieger']] = $this->sieger[$row['sieger']] != '' ? $this->sieger[$row['sieger']] + 1 : 1;
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