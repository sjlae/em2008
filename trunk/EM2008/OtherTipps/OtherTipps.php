<?php
require_once("Page.php");

class OtherTipps extends HTMLPage implements Page {

	private $players = array();
	private $realid = '';
	private $action = '';

	private $countries = array();
	private $vorrunde = array();
	private $userViertelfinal = array();
	private $userHalbfinal = array();
	private $userFinal = array();
	private $userEuropameister= '';

	public function __construct() {
		$this->action = isset($_GET['action']) ? $_GET['action'] : '';
		$id = isset($_GET['id']) ? $_GET['id'] : '';

		if($this->action == 'getTipps') {
			$this->getUserTipps($id);
			$this->getData();
			$this->getUserHauptrundeTipps();
		}
		$this->getPlayers();



	}

	private function getUserResult($vorrundeteamsid) {

		$anzahlUserTipps = "SELECT vorrundefsid FROM uservorrunde where userfsid=".$this->realid;

		$resultUserTipps = mysql_query($anzahlUserTipps);

		while($row = mysql_fetch_assoc($resultUserTipps))
		{
			$vorrundeid = $row['vorrundefsid'];

			$tippedMatch = "SELECT * FROM vorrunde where vorrundeid=$vorrundeid";
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

	private function getData() {
		$abfrage = "SELECT * FROM vorrundeteams";

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
		$abfrage = "Select * from user order by nachname asc";

		$ergebnis = mysql_query($abfrage);

		while($row = mysql_fetch_assoc($ergebnis))
		{
			$this->players[$row['userid']]['id'] = $row['userid'] + 5;
			$this->players[$row['userid']]['vorname'] = $row['vorname'];
			$this->players[$row['userid']]['nachname'] = $row['nachname'];
		}
	}

	private function isDisabledHauptrunde() {
		return "disabled";
	}

	private function getCountries() {
		$abfrage = "SELECT * FROM teams order by land asc";

		$ergebnis = mysql_query($abfrage);

		$i=0;
		while($row = mysql_fetch_assoc($ergebnis))
		{
			$this->countries[$i]['id'] = $row['teamid'];
			$this->countries[$i]['land'] = $row['land'];
			$i++;
		}
	}

	private function getUserHauptrundeTipps() {
		$userid = $this->realid;

		$abfrage = "Select * from hauptrunde where userfsid=".$userid;

		$ergebnis = mysql_query($abfrage);
		while($row = mysql_fetch_assoc($ergebnis))
		{
			for($i=1;$i<=8;$i++) {
				$this->userViertelfinal[$i] = $row['viertelfinal'.$i];
			}
			//halbfinal
			for($i=1;$i<=4;$i++) {
				$this->userHalbfinal[$i] = $row['halbfinal'.$i];
			}

			//Final
			for($i=1;$i<=2;$i++) {
				$this->userFinal[$i] = $row['final'.$i];
			}


			//Europameister
			$this->userEuropameister = $row['europameister'];
		}
	}


	public function getHTML() {
		if($this->action == "getTipps") {
			$this->getCountries();
			include('layout/userTipps.tpl');
		}
		else
		include('layout/overviewUsers.tpl');
			
	}
}
?>