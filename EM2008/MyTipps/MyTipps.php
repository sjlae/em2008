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
		for($i=1;$i<=24;$i++) {
			$result1 = $_POST['result1'.$i];
			$result2 = $_POST['result2'.$i];
			if($result1 != '' || $result2 != '') {
				if($this->isExisting($i)) {
					$this->updateTipp($i, $result1, $result2);
				} else {
					$this->addTipp($i, $result1, $result2);
				}
			}
		}
		//set hauptrunde tipps
		//viertelfinale
		//Existingcheck
		//in usertabelle schauen ob fsid gesetzt ist, dann ein flag machen
		$isExisting = $this->isExistingHauptrunde();
	
		for($i=1;$i<=8;$i++) {
			$team = $_POST['viertelfinal'.$i];
			if(isset($team) && $team != '') {

				//$this->addHauptrundeTipp();
			} else {
				//Do nothing
			}
		}
	}

	private function isExistingHauptrunde() {
		$userid = $_SESSION['userid'];

		$abfrage = "SELECT hauptrundefsid FROM User where userid=".$userid;

		$ergebnis = mysql_query($abfrage);
		while($row = mysql_fetch_assoc($ergebnis))
		{
			if($row['hauptrundefsid'] == 0)
				return false;
			else 
				return true;
		}
		return false;
	}

	private function addTipp($i, $result1, $result2) {
		if(isDisabled == 'enalbled') {
				
		} else {
			//Too late
		}
	}

	private function updateTipp($i, $result1, $result2) {
		if(isDisabled == 'enalbled') {
				
		} else {
			//Too late
		}
	}

	private function isExisting($vorrundeteamsid) {
		$userid = $_SESSION['userid'];

		$abfrage = "SELECT * FROM UserVorrunde where vorrundefsid=".$vorrundeteamsid." and userfsid=".$userid;

		$ergebnis = mysql_query($abfrage);
		while($row = mysql_fetch_assoc($ergebnis))
		{
			return true;
		}

		return false;
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

		$anzahlUserTipps = "SELECT vorrundefsid FROM UserVorrunde where userfsid=$userid";
		$resultUserTipps = mysql_query($anzahlUserTipps);
		
		while($row = mysql_fetch_assoc($resultUserTipps))
		{
			$vorrundeid = $row['vorrundefsid'];
			
			$tippedMatch = "SELECT * FROM Vorrunde where vorrundeid=$vorrundeid";
			$resultTippedMatch = mysql_query($tippedMatch);
			
			while($row = mysql_fetch_assoc($resultTippedMatch))
			{
				if($vorrundeteamsid == $row['vorrundeteamsfsid']){
					$results[] = $row['result1'];
					$results[] = $row['result2'];
					
					return $results;
				}
			}
		}
	}
	/*
	 * todo depeding on time
	 */
	private function isDisabled($start) {
		if(mktime() > strtotime($start))
		return "disabled";
		return "enabled";
	}
	private function getData() {
		$abfrage = "SELECT * FROM VorrundeTeams";

		$ergebnis = mysql_query($abfrage);

		$i = 0;

		while($row = mysql_fetch_assoc($ergebnis))
		{
			$this->vorrunde[$i]['id'] = $row['vorrundeteamsid'];
			$this->vorrunde[$i]['start'] = date('d.m.Y H:i', strtotime($row['start']));
			$this->vorrunde[$i]['disabled'] = $this->isDisabled($row['start']);
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
		$abfrage = "SELECT * FROM Teams order by land asc";

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