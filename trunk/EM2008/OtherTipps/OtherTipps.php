<?php
require_once("Page.php");

class OtherTipps extends HTMLPage implements Page {

	private $players = array();
	private $realid = '';
	private $action = '';

	private $countries = array();
	private $vorrunde = array();
	private $userAchtelfinal = array();
	private $userViertelfinal = array();
	private $userHalbfinal = array();
	private $userFinal = array();
	private $userSieger = '';
	private $realhauptrunde = array();
	private $sort;

	private $link = '';

	public function __construct() {
		$this->link = Db::getConnection();

		$this->action = isset($_GET['action']) ? $_GET['action'] : '';
		$id = isset($_GET['id']) ? $_GET['id'] : '';

		if($this->action == 'getTipps') {
			$this->getUserTipps($id);
			$this->getData();
			$this->getUserHauptrundeTipps();
			$this->realhauptrunde = $this->getRealHauptrunde();
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
			for($i=1;$i<=16;$i++) {
				$this->userAchtelfinal[$i] = $row['achtelfinal'.$i];
			}
			
			for($i=1;$i<=8;$i++) {
				$this->userViertelfinal[$i] = $row['viertelfinal'.$i];
			}
			
			for($i=1;$i<=4;$i++) {
				$this->userHalbfinal[$i] = $row['halbfinal'.$i];
			}

			for($i=1;$i<=2;$i++) {
				$this->userFinal[$i] = $row['final'.$i];
			}

			$this->userSieger = $row['sieger'];
		}
	}
	
	// $round --> 1 = Achtelfinal, 2 = Viertelfinal, 3 = Halbfinal, 4 = Final, 5 = Sieger
public function getStyle($id, $round){
		if($id != ''){
			$achtel_min = 0;
			$achtel_max = 16;
			$viertel_min = 16;
			$halb_min = 24;
			$final_min = 28;
			$sieger = 30;
			
			if($round == 1 && $this->realhauptrunde[$achtel_min] != ''){
				if(array_search($this->getTeam($id), array_slice($this->realhauptrunde, $achtel_min, $achtel_max)) !== false){ 
					return "background-color: #00FF00";
				}
				else if($this->realhauptrunde[$achtel_max-1] != ''){
					return "background-color: #FF6633";
				}
			}
			if($round == 2 && $this->realhauptrunde[$viertel_min] != ''){
				if(array_search($this->getTeam($id), array_slice($this->realhauptrunde, $viertel_min, 8)) !== false){ 
					return "background-color: #00FF00";
				}
				else if($this->realhauptrunde[$viertel_min+7] != ''){
					return "background-color: #FF6633";
				}
			}
			if($round == 3 && $this->realhauptrunde[$halb_min] != ''){
				if(array_search($this->getTeam($id), array_slice($this->realhauptrunde, $halb_min, 4)) !== false){ 
					return "background-color: #00FF00";
				}
				else if($this->realhauptrunde[$halb_min+3] != ''){
					return "background-color: #FF6633";
				}
			}
			if($round == 4 && $this->realhauptrunde[$final_min] != ''){
				if(array_search($this->getTeam($id), array_slice($this->realhauptrunde, $final_min, 2)) !== false){ 
					return "background-color: #00FF00";
				}
				else if($this->realhauptrunde[$final_min+1] != ''){
					return "background-color: #FF6633";
				}
			}
			if($round == 5 && $this->realhauptrunde[$sieger] != ''){
				if(array_search($this->getTeam($id), array_slice($this->realhauptrunde, $sieger, 1)) !== false){ 
					return "background-color: #00FF00";
				}
				else if($this->realhauptrunde[$sieger] != ''){
					return "background-color: #FF6633";
				}
			}
		}
	}

	private function getRealHauptrunde() {
		$abfrage = "Select * from realhauptrunde";
		$realhauptrunde = array();

		$ergebnis = mysql_query($abfrage);
		while($row = mysql_fetch_assoc($ergebnis))
		{
			$realhauptrunde[] = $this->getTeam($row['achtelfinal1']);
			$realhauptrunde[] = $this->getTeam($row['achtelfinal2']);
			$realhauptrunde[] = $this->getTeam($row['achtelfinal3']);
			$realhauptrunde[] = $this->getTeam($row['achtelfinal4']);
			$realhauptrunde[] = $this->getTeam($row['achtelfinal5']);
			$realhauptrunde[] = $this->getTeam($row['achtelfinal6']);
			$realhauptrunde[] = $this->getTeam($row['achtelfinal7']);
			$realhauptrunde[] = $this->getTeam($row['achtelfinal8']);
			$realhauptrunde[] = $this->getTeam($row['achtelfinal9']);
			$realhauptrunde[] = $this->getTeam($row['achtelfinal10']);
			$realhauptrunde[] = $this->getTeam($row['achtelfinal11']);
			$realhauptrunde[] = $this->getTeam($row['achtelfinal12']);
			$realhauptrunde[] = $this->getTeam($row['achtelfinal13']);
			$realhauptrunde[] = $this->getTeam($row['achtelfinal14']);
			$realhauptrunde[] = $this->getTeam($row['achtelfinal15']);
			$realhauptrunde[] = $this->getTeam($row['achtelfinal16']);
			
			$realhauptrunde[] = $this->getTeam($row['viertelfinal1']);
			$realhauptrunde[] = $this->getTeam($row['viertelfinal2']);
			$realhauptrunde[] = $this->getTeam($row['viertelfinal3']);
			$realhauptrunde[] = $this->getTeam($row['viertelfinal4']);
			$realhauptrunde[] = $this->getTeam($row['viertelfinal5']);
			$realhauptrunde[] = $this->getTeam($row['viertelfinal6']);
			$realhauptrunde[] = $this->getTeam($row['viertelfinal7']);
			$realhauptrunde[] = $this->getTeam($row['viertelfinal8']);
				
			$realhauptrunde[] = $this->getTeam($row['halbfinal1']);
			$realhauptrunde[] = $this->getTeam($row['halbfinal2']);
			$realhauptrunde[] = $this->getTeam($row['halbfinal3']);
			$realhauptrunde[] = $this->getTeam($row['halbfinal4']);
				
			$realhauptrunde[] = $this->getTeam($row['final1']);
			$realhauptrunde[] = $this->getTeam($row['final2']);
				
			$realhauptrunde[] = $this->getTeam($row['sieger']);
		}

		return $realhauptrunde;
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