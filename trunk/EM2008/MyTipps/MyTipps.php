<?php
require_once("Page.php");
require_once('Datenbank/db.php');

class MyTipps extends HTMLPage implements Page {

	private $vorrunde = array();
	private $countries = array();
	
	public function __construct() {
	$action = isset($_GET['action']) ? $_GET['action'] : '';
		
		if($action == "setTipps") {
			$this->setTipps();
		}
	}
	
	private function setTipps() {
		//set user vorrunde tipps
		
		//set hauptrunde tipps
	}
	
	private function getTeam($id) {
		$abfrage = "SELECT * FROM Teams where teamid=".$id;

		$ergebnis = mysql_query($abfrage);
		while($row = mysql_fetch_assoc($ergebnis))
		{
			return $row['land'];
		}
	}

	private function getUserResult($vorrundeteamsid) {
		$userid = $_SESSION['userid'];

		$abfrage = "SELECT result1, result2 FROM UserVorrunde, Vorrunde where vorrundefsid=".$vorrundeteamsid." and userfsid=".$userid;

		$ergebnis = mysql_query($abfrage);
		while($row = mysql_fetch_assoc($ergebnis))
		{
			$results[] = $row['result1'];
			$results[] = $row['result2'];
		}

		return $results;

	}
	/*
	 * todo depeding on time
	 */
	private function isDisabled() {
		return "enabled";
	}
	private function getData() {
		$abfrage = "SELECT * FROM VorrundeTeams";

		$ergebnis = mysql_query($abfrage);

		$i = 0;

		while($row = mysql_fetch_assoc($ergebnis))
		{
			$this->vorrunde[$i]['id'] = $row['vorrundeteamsid'];
			$this->vorrunde[$i]['start'] = date('d.m.Y h:m', strtotime($row['start']));
			$this->vorrunde[$i]['disabled'] = $this->isDisabled();
			$this->vorrunde[$i]['team1'] = $this->getTeam($row['team1fsid']);
			$this->vorrunde[$i]['team2'] = $this->getTeam($row['team2fsid']);
			$results = $this->getUserResult($row['vorrundeteamsid']);
			$this->vorrunde[$i]['result1'] = $results[0];
			$this->vorrunde[$i]['result2'] = $results[1];
			$this->vorrunde[$i]['realresult1'] = $row['realresult1'];
			$this->vorrunde[$i]['realresult2'] = $row['realresult2'];
				
			$i++;
		}
	}
	private function getCountries() {
		$abfrage = "SELECT * FROM Teams";

		$ergebnis = mysql_query($abfrage);
		
		while($row = mysql_fetch_assoc($ergebnis))
		{
			$this->countries[] = $row['land'];
		}
	}
	public function getHTML() {
		$this->getData();
		$this->getCountries();
		include('layout/myTipps.tpl');
	}
}
?>