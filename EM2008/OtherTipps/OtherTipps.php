<?php
require_once("Page.php");

class OtherTipps extends HTMLPage implements Page {

	private $players = array();
	private $realid = '';
	private $action = '';

	private $vorrunde = array();

	public function __construct() {
		$this->action = isset($_GET['action']) ? $_GET['action'] : '';
		$id = isset($_GET['id']) ? $_GET['id'] : '';

		$this->getData();
		
		$this->getPlayers();

		if($this->action == 'getTipps')
		$this->getUserTipps($id);


	}
	
private function getUserResult($vorrundeteamsid) {
		
		$anzahlUserTipps = "SELECT vorrundefsid FROM UserVorrunde where userfsid=$this->realid";
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
	
	private function getData() {
		$abfrage = "SELECT * FROM VorrundeTeams";

		$ergebnis = mysql_query($abfrage);

		$i = 0;

		while($row = mysql_fetch_assoc($ergebnis))
		{
			$this->vorrunde[$i]['id'] = $row['vorrundeteamsid'];
			$this->vorrunde[$i]['start'] = date('d.m.Y H:i', strtotime($row['start']));
			$this->vorrunde[$i]['disabled'] = "disabled";
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

	private function getUserTipps($id) {
		$this->realid = $id-5;
	}

	private function getPlayers() {
		$abfrage = "Select * from user group by nachname asc";

		$ergebnis = mysql_query($abfrage);

		while($row = mysql_fetch_assoc($ergebnis))
		{
			$this->players[$row['userid']]['id'] = $row['userid'] + 5;
			$this->players[$row['userid']]['vorname'] = $row['vorname'];
			$this->players[$row['userid']]['nachname'] = $row['nachname'];
		}
	}
	public function getHTML() {
		if($this->action == "getTipps")
		include('layout/userTipps.tpl');
		else
		include('layout/overviewUsers.tpl');
			
	}
}
?>