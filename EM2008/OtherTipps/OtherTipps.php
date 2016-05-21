<?php
require_once("Page.php");

class OtherTipps extends HTMLPage implements Page {

	private $players = array();
	private $realid = '';
	private $action = '';
	private $phases = array();
	private $countries = array();
	private $vorrunde = array();
	private $userAchtelfinal = array();
	private $winner = '';
	private $best = '';
	private $worst = '';
	private $switzerland = '';
	private $lastwinner = '';
	private $realweiteretipps = array();
	private $sort;
	
	private $link = '';

	public function __construct() {
		$this->link = Db::getConnection();

		$this->action = isset($_GET['action']) ? $_GET['action'] : '';
		$id = isset($_GET['id']) ? $_GET['id'] : '';

		if($this->action == 'getTipps') {
			$this->getUserTipps($id);
			$this->getData();
			$this->getUserWeitereTipps();
			$this->realweiteretipps = $this->getRealWeitereTipps();
		}
		$this->getPlayers();
	}
	
	public function getGroupTeams($group){
		$groupArray = array();
		$i=0;
		foreach($this->countries as $country):
		if($country['gruppe'] == $group){
			$groupArray[$i]['id'] = $country['id'];
			$groupArray[$i]['land'] = $country['land'];
			$groupArray[$i]['gruppe'] = $country['gruppe'];
			$i++;
		}
		endforeach;
		return $groupArray;
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
					$results[] = $row['highrisk'];

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
		$abfrage = "SELECT * FROM vorrundeteams order by start asc";

		$ergebnis = mysql_query($abfrage);

		$i = 0;

		while($row = mysql_fetch_assoc($ergebnis))
		{
			$this->vorrunde[$i]['id'] = $row['vorrundeteamsid'];
			$this->vorrunde[$i]['start'] = date('d.m.Y H:i', strtotime($row['start']));
			$this->vorrunde[$i]['disabled'] = "disabled";
			$this->vorrunde[$i]['team1'] = is_numeric($row['team1fsid']) ? $this->getTeam($row['team1fsid']) : $row['team1fsid'];
			$this->vorrunde[$i]['team2'] = is_numeric($row['team2fsid']) ? $this->getTeam($row['team2fsid']) : $row['team2fsid'];
			$results = $this->getUserResult($row['vorrundeteamsid']);
			$this->vorrunde[$i]['result1'] = $results[0];
			$this->vorrunde[$i]['result2'] = $results[1];
			$this->vorrunde[$i]['highrisk'] = $results[2];
			$this->vorrunde[$i]['realresult1'] = $row['realresult1'];
			$this->vorrunde[$i]['realresult2'] = $row['realresult2'];

			$i++;
		}
	}

	private function getUserTipps($id) {
		$this->realid = $id-5;
	}

	private function getPlayers() {
		$abfrage;
		$this->sort = $_POST['sort'];
		if($this->action == 'sort' && $this->sort == 'Rang') {
			$abfrage = "Select * from user order by rank_now asc, nachname asc";
		}
		else{
			$abfrage = "Select * from user order by nachname asc";
		}
		
		$ergebnis = mysql_query($abfrage);

		while($row = mysql_fetch_assoc($ergebnis))
		{
			$this->players[$row['userid']]['id'] = $row['userid'] + 5;
			$this->players[$row['userid']]['rank_now'] = $row['rank_now'];
			$this->players[$row['userid']]['vorname'] = $row['vorname'];
			$this->players[$row['userid']]['nachname'] = $row['nachname'];
		}
	}

	private function getUserWeitereTipps() {
		$userid = $this->realid;

		$abfrage = "Select * from userweiteretipps where userfsid=".$userid;

		$ergebnis = mysql_query($abfrage);
		while($row = mysql_fetch_assoc($ergebnis))
		{
			for($i=1;$i<=16;$i++) {
				$this->userAchtelfinal[$i] = $row['achtelfinal'.$i];
			}
			
			// Sieger
			$this->winner = $row['winner'];
				
			// Bestes Team Vorrunde
			$this->best = $row['best'];
				
			// Schlechtestes Team Vorrunde
			$this->worst = $row['worst'];
				
			// Wie weit kommt die Schweiz
			$this->switzerland = $row['switzerland'];
				
			// Wie weit kommt der Titelverteidiger
			$this->lastwinner =$row['lastwinner'];
		}
	}
	
	public function getStyle($id, $round){
		if($id != ''){
			$achtel_min = 0;
			$achtel_max = 16;
			
			if($round == 1 && $this->realweiteretipps[$achtel_min] != ''){
				if(array_search($id, array_slice($this->realweiteretipps, $achtel_min, $achtel_max)) !== false){ 
					return "background-color: #00FF00";
				}
				else if($this->realweiteretipps[$achtel_max-1] != ''){
					return "background-color: #FF6633";
				}
			}
			else{
				if($this->realweiteretipps[$round] != ''){
					if($this->realweiteretipps[$round] == $id){
						return "background-color: #00FF00";
					}
					else{
						return "background-color: #FF6633";
					}
				}
			}
		}
	}

	private function getRealWeitereTipps() {
		$abfrage = "Select * from realweiteretipps";
		$realWeitereTipps = array();

		$ergebnis = mysql_query($abfrage);
		while($row = mysql_fetch_assoc($ergebnis))
		{
			// Achtelfinalisten
			$realWeitereTipps[] = $row['achtelfinal1'];
			$realWeitereTipps[] = $row['achtelfinal2'];
			$realWeitereTipps[] = $row['achtelfinal3'];
			$realWeitereTipps[] = $row['achtelfinal4'];
			$realWeitereTipps[] = $row['achtelfinal5'];
			$realWeitereTipps[] = $row['achtelfinal6'];
			$realWeitereTipps[] = $row['achtelfinal7'];
			$realWeitereTipps[] = $row['achtelfinal8'];
			$realWeitereTipps[] = $row['achtelfinal9'];
			$realWeitereTipps[] = $row['achtelfinal10'];
			$realWeitereTipps[] = $row['achtelfinal11'];
			$realWeitereTipps[] = $row['achtelfinal12'];
			$realWeitereTipps[] = $row['achtelfinal13'];
			$realWeitereTipps[] = $row['achtelfinal14'];
			$realWeitereTipps[] = $row['achtelfinal15'];
			$realWeitereTipps[] = $row['achtelfinal16'];
			
			// Sieger
			$realWeitereTipps[] = $row['winner'];
			
			// Bestes Team Vorrunde
			$realWeitereTipps[] = $row['best'];
			
			// Schlechtestes Team Vorrunde
			$realWeitereTipps[] = $row['worst'];
			
			// Wie weit kommt die Schweiz
			$realWeitereTipps[] = $row['switzerland'];
			
			// Wie weit kommt der Titelverteidiger
			$realWeitereTipps[] =$row['lastwinner'];
		}

		return $realWeitereTipps;
	}

	private function getCountries() {
		$abfrage = "SELECT * FROM teams order by land asc";
	
		$ergebnis = mysql_query($abfrage);
	
		$i=0;
		while($row = mysql_fetch_assoc($ergebnis))
		{
			$this->countries[$i]['id'] = $row['teamid'];
			$this->countries[$i]['land'] = $row['land'];
			$this->countries[$i]['gruppe'] = $row['gruppe'];
			$i++;
		}
	}
	
	public function getHTML() {
		if($this->action == "getTipps") {
			$this->getCountries();
			$this->phases = Constants::getPhases();
			include('layout/userTipps.tpl');
		}
		else
		include('layout/overviewUsers.tpl');
			
	}
}
?>