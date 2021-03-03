<?php
require_once("Page.php");
require_once('Datenbank/db.php');
require_once('Constants.php');

class Statistics extends HTMLPage implements Page {

	private $link = '';
	private $vorrunde = array();
	private $teams = array();
	private $phases = array();
	private $achtelfinal = array();
	private $winner = array();
	private $best = array();
	private $worst = array();
	private $switzerland = array();
	private $lastwinner = array();
	
	public function __construct() {
		$this->link = Db::getConnection();
		$this->getData();
	}

	private function getData() {
		$abfrage_groups = "SELECT * FROM vorrundeteams order by start asc";
		$ergebnis_groups = mysqli_query($this->link, $abfrage_groups);

		$i = 0;

		while($row = mysqli_fetch_assoc($ergebnis_groups))
		{
			$this->vorrunde[$i]['id'] = $row['vorrundeteamsid'];
			$this->vorrunde[$i]['start'] = date('d.m.Y H:i', strtotime($row['start']));
			$this->vorrunde[$i]['team1'] = is_numeric($row['team1fsid']) ? $this->getTeam($row['team1fsid']) : $row['team1fsid'];
			$this->vorrunde[$i]['team2'] = is_numeric($row['team2fsid']) ? $this->getTeam($row['team2fsid']) : $row['team2fsid'];
			$this->vorrunde[$i]['total_1'] = $this->getTotal_1($row['vorrundeteamsid']);
			$this->vorrunde[$i]['total_X'] = $this->getTotal_X($row['vorrundeteamsid']);
			$this->vorrunde[$i]['total_2'] = $this->getTotal_2($row['vorrundeteamsid']);
			$this->vorrunde[$i]['userResult'] = $this->getUserResult($row['vorrundeteamsid']);
			$i++;
		}
						
		$abfrage_finals = "SELECT * FROM teams order by land ASC";
		$ergebnis_finals = mysqli_query($this->link, $abfrage_finals);

		$i = 0;

		while($row = mysqli_fetch_assoc($ergebnis_finals))
		{
			$this->teams[$i]['id'] = $row['teamid'];
			$this->teams[$i]['team'] = $row['land'];
			$i++;
		}
		
		$abfrage_weiteretipps = "SELECT * FROM userweiteretipps";
		$ergebnis_weiteretipps = mysqli_query($this->link, $abfrage_weiteretipps);
	
		while($row = mysqli_fetch_assoc($ergebnis_weiteretipps))
		{
			$counter_achtel = 1;
			while($counter_achtel <= 16){
				$this->achtelfinal[$row['achtelfinal'.$counter_achtel]] = $this->achtelfinal[$row['achtelfinal'.$counter_achtel]] != '' ? $this->achtelfinal[$row['achtelfinal'.$counter_achtel]] + 1 : 1;
				$counter_achtel++;
			}
			
			$this->winner[$row['winner']] = $this->winner[$row['winner']] != '' ? $this->winner[$row['winner']] + 1 : 1;
			$this->best[$row['best']] = $this->best[$row['best']] != '' ? $this->best[$row['best']] + 1 : 1;
			$this->worst[$row['worst']] = $this->worst[$row['worst']] != '' ? $this->worst[$row['worst']] + 1 : 1;
			$this->switzerland[$row['switzerland']] = $this->switzerland[$row['switzerland']] != '' ? $this->switzerland[$row['switzerland']] + 1 : 1;
			$this->lastwinner[$row['lastwinner']] = $this->lastwinner[$row['lastwinner']] != '' ? $this->lastwinner[$row['lastwinner']] + 1 : 1;
		}
	}
	
	private function getTeam($id) {
		if($id != ''){
			$abfrage = "SELECT * FROM teams where teamid=".$id;

			$ergebnis = mysqli_query($this->link, $abfrage);
			while($row = mysqli_fetch_assoc($ergebnis))
			{
				return $row['land'];
			}
		}
	}
	
	private function getTotal_1($id){
		$abfrage = "SELECT result1, result2 FROM vorrunde where vorrundeteamsfsid=".$id;
		$ergebnis = mysqli_query($this->link, $abfrage);
		
		$counter = 0;
		
		while($row = mysqli_fetch_assoc($ergebnis))
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
		$ergebnis = mysqli_query($this->link, $abfrage);
		
		$counter = 0;
		
		while($row = mysqli_fetch_assoc($ergebnis))
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
		$ergebnis = mysqli_query($this->link, $abfrage);
		
		$counter = 0;
		
		while($row = mysqli_fetch_assoc($ergebnis))
		{
			if($this->isValid($row['result1'], $row['result2'])){
				if($row['result1'] < $row['result2']){
					$counter++;
				}
			}
		}
		
		return $counter;
	}
	
	private function getUserResult($id){
		$userid = $_SESSION['userid'];
		$ergebnis = mysqli_query($this->link, "SELECT vorrunde.result1, vorrunde.result2 from vorrunde, uservorrunde where (vorrunde.vorrundeteamsfsid = '$id' and uservorrunde.userfsid = '$userid' and uservorrunde.vorrundefsid = vorrunde.vorrundeid);");
		
		$result = mysqli_fetch_assoc($ergebnis);
		
		if(!is_numeric($result['result1']) || !is_numeric($result['result2'])){
			return '0';
		}
		
		else if($result['result1'] > $result['result2']){
			return '1';
		}
		else if ($result['result1'] == $result['result2']){
			return 'X';	
		}
		else if ($result['result1'] < $result['result2']){
			return '2';	
		}
		
		else{
			return '0';
		}
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
		$this->phases = Constants::getPhases();
		include('layout/statistics.tpl');
	}
}
?>