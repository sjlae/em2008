<?php
require_once("Page.php");
require_once('Datenbank/db.php');
require_once('Constants.php');

class MyTipps extends HTMLPage implements Page {

	private $vorrunde = array();
	private $countries = array();
	private $phases = array();
	private $isExistingUserWeitereTipps = '';
	private $realweiteretipps = array();

	private $errors = array();

	private $userAchtelfinal = array();
	private $winner = '';
	private $best = '';
	private $worst = '';
	private $switzerland = '';
	private $lastwinner = '';

	private $link = '';
	
	public function __construct() {
		if($_SESSION['eingeloggt'] || $_SESSION['userid']){
			$this->link = Db::getConnection();
	
			$action = isset($_GET['action']) ? $_GET['action'] : '';
	
			$this->realweiteretipps = $this->getRealWeitereTipps();
			$this->getData();
	
			if($action == "setTipps") {
				$this->setTipps();
			}
	
			$this->getData();
	
			$this->isExistingUserWeitereTipps = $this->isExistingUserWeitereTipps();
	
			if($this->isExistingUserWeitereTipps) {
				$this->getUserWeitereTipps();
			}
		}
	}
	
	private function getRealWeitereTipps() {
		$abfrage = "Select * from realweiteretipps";
		$realWeitereTipps = array();

		$ergebnis = mysqli_query($this->link, $abfrage);
		while($row = mysqli_fetch_assoc($ergebnis))
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

	private function getUserWeitereTipps() {
		$userid = $_SESSION['userid'];

		$abfrage = "Select * from userweiteretipps where userfsid=".$userid;

		$ergebnis = mysqli_query($this->link, $abfrage);
		while($row = mysqli_fetch_assoc($ergebnis))
		{
			for($i=1;$i<=16;$i++) {
				$this->userAchtelfinal[$i] = isset($row['achtelfinal'.$i]) ? $row['achtelfinal'.$i] : '';
			}

			$this->winner = isset($row['winner']) ? $row['winner'] : '';
			$this->best = isset($row['best']) ? $row['best'] : '';
			$this->worst = isset($row['worst']) ? $row['worst'] : '';
			$this->switzerland = isset($row['switzerland']) ? $row['switzerland'] : '';
			$this->lastwinner = isset($row['lastwinner']) ? $row['lastwinner'] : '';
		}
	}

	private function setTipps() {
		$result = mysqli_query($this->link, "Select COUNT(start) as Number from vorrundeteams");
		$countGames = mysqli_fetch_assoc($result);
		$showWarningMessage = true;
		for($i=1;$i<=$countGames['Number'];$i++) {
			$result1 = $_POST['result1'.$i];
			$result2 = $_POST['result2'.$i];
            $highrisk = isset($_POST['games_highrisk'.$i]) ? '1' : '0';
            
			if($_SERVER['REQUEST_METHOD'] !== 'POST' || (($result1 != '' && !preg_match('/^\d{1,2}$/', $result1)) || ($result2 != '' && !preg_match('/^\d{1,2}$/', $result2)))){
				if($showWarningMessage){
					$this->errors[] = "Aufgrund komischen Werten, wurden nicht all deine Tipps gespeichert.";
					$showWarningMessage = false;
				}
			}
			
			else if($this->isDisabled($this->vorrunde[$i-1]['start']) == 'enabled' || ($this->isDisabled($this->vorrunde[$i-1]['start']) == 'disabled' && ($result1 != '' || $result2 != ''))) {
				if($this->isExisting($i)) {
					if($this->isExisting($i)) {
						$this->updateTipp($i, $result1, $result2, $highrisk);
					} else {
						$this->addTipp($i, $result1, $result2, $highrisk);
					}
				} else {
					if($result1 != '' || $result2 != '') {
						if($this->isExisting($i)) {
							$this->updateTipp($i, $result1, $result2, $highrisk);
						} else {
							$this->addTipp($i, $result1, $result2, $highrisk);
						}
					}
				}
			}
		}

		if($this->hasEqualTeams()){
			return false;
		}

		//set Weitere Tipps
		$userweiteretipps = array();

		$isStillEnabled = false;

		for($i=1;$i<=16;$i++) {
			$teamid = $_POST['achtelfinal'.$i];
			$userweiteretipps[] = $teamid;
			if(!$isStillEnabled && $teamid != ''){
				$isStillEnabled = true;
			}
		}
		
		$areTippsOk = true;
		
		foreach($userweiteretipps as $tipp){
			if($tipp != '' && !preg_match('/^\d{1,2}$/', $tipp)){
				$this->errors[] = "Wie auch immer du das angestellt hast, aber da lief nicht alles mit legalen Mitteln!";
				$areTippsOk = false;
				break;
			}
		}

		$userweiteretipps[] = isset($_POST['winner']) ? $_POST['winner'] : '';
		$userweiteretipps[] = isset($_POST['best']) ? $_POST['best'] : '';
		$userweiteretipps[] = isset($_POST['worst']) ? $_POST['worst'] : '';
		$userweiteretipps[] = isset($_POST['switzerland']) ? $_POST['switzerland'] : '';
		$userweiteretipps[] = isset($_POST['lastwinner']) ? $_POST['lastwinner'] : '';
		
		if($areTippsOk){
			//timecheck??
			$this->isExistingUserWeitereTipps = $this->isExistingUserWeitereTipps();
			if($this->isDisabledWeitereTipps()=="enabled") {
				if($this->isExistingUserWeitereTipps) {
					$this->updateUserWeitereTipps($userweiteretipps);
				} else {
					$this->addUserWeitereTipps($userweiteretipps);
				}
			} else if($isStillEnabled) {
				$this->errors[] = "Die Zeit ist abgelaufen, um 'Weitere Tipps' zu erfassen.";
			}
			
			$_SESSION['infos'][] = "Deine Tipps wurden erfolgreich erfasst.";

			if(is_numeric(array_search('', $userweiteretipps, false)) && $isStillEnabled){
				$_SESSION['infos'][] = "Du hast noch nicht s&auml;mtliche 'Weitere Tipps' erfasst!";
			}
		}
	}

	private function isDisabledWeitereTipps() {
		$abfrage = "SELECT start FROM vorrundeteams where vorrundeteamsid=1";

		$ergebnis = mysqli_query($this->link, $abfrage);
		$startTime = mysqli_fetch_row($ergebnis);
		if(time() > strtotime($startTime[0])){
			return "disabled";
		}
		else{
			return "enabled";
		}
	}

	private function updateUserWeitereTipps($userWeitereTipps) {
		$abfrage = sprintf("Update userweiteretipps set achtelfinal1 = '%s', achtelfinal2 = '%s', achtelfinal3 = '%s', achtelfinal4 = '%s', achtelfinal5 = '%s', achtelfinal6 = '%s', achtelfinal7 = '%s', achtelfinal8 = '%s', achtelfinal9 = '%s', achtelfinal10 = '%s', achtelfinal11 = '%s', achtelfinal12 = '%s', achtelfinal13 = '%s', achtelfinal14 = '%s', achtelfinal15 = '%s', achtelfinal16 = '%s', winner = '%s', best = '%s', worst = '%s', switzerland = '%s', lastwinner = '%s' where userfsid=".$_SESSION['userid'], htmlentities($userWeitereTipps[0], ENT_QUOTES, 'UTF-8'),htmlentities($userWeitereTipps[1], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[2], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[3], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[4], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[5], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[6], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[7], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[8], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[9], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[10], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[11], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[12], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[13], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[14], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[15], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[16], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[17], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[18], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[19], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[20]));
		
		$ergebnis = mysqli_query($this->link, $abfrage, $this->link);
	}

	private function addUserWeitereTipps($userWeitereTipps) {
		$abfrage = sprintf("Insert into userweiteretipps values(%d, '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')",$_SESSION['userid'], htmlentities($userWeitereTipps[0], ENT_QUOTES, 'UTF-8'),htmlentities($userWeitereTipps[1], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[2], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[3], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[4], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[5], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[6], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[7], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[8], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[9], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[10], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[11], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[12], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[13], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[14], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[15], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[16], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[17], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[18], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[19], ENT_QUOTES, 'UTF-8'), htmlentities($userWeitereTipps[20]));
		
		$ergebnis = mysqli_query($this->link, $abfrage, $this->link);
	}

	private function isExistingUserWeitereTipps() {
		$userid = $_SESSION['userid'];

		$abfrage = "SELECT userfsid FROM userweiteretipps where userfsid=".$userid;

		$ergebnis = mysqli_query($this->link, $abfrage);
		while($row = mysqli_fetch_assoc($ergebnis))
		{
			if($row['userfsid'] == '')
			return false;
			else
			return true;
		}
		return false;
	}

	private function addTipp($i, $result1, $result2, $highrisk) {
		if($this->isDisabled($this->vorrunde[$i-1]['start']) == 'enabled') {
			$abfrage = sprintf("Insert into vorrunde value('', '".$result1."', '".$result2."', '".$highrisk."','".$i."')", htmlentities($result1, ENT_QUOTES, 'UTF-8'),  htmlentities($result2, ENT_QUOTES, 'UTF-8'),  htmlentities($highrisk, ENT_QUOTES, 'UTF-8'),htmlentities($i, ENT_QUOTES, 'UTF-8'));
			mysqli_query($this->link, $abfrage);

			$vorrundeid = mysql_insert_id();

			$abfrage = "Insert into uservorrunde value(".$_SESSION['userid'].", ".$vorrundeid.")";
			mysqli_query($this->link, $abfrage);
		} else {
			$this->errors[] = "Die Zeit ist abgelaufen, um Resultattipps zu erfassen.";
		}
	}

	private function updateTipp($i, $result1, $result2, $highrisk) {
		if($this->isDisabled($this->vorrunde[$i-1]['start']) == 'enabled') {

			$userid = $_SESSION['userid'];

			$anzahlUserTipps = "SELECT vorrundefsid FROM uservorrunde where userfsid=$userid";
			$resultUserTipps = mysqli_query($this->link, $anzahlUserTipps);

			while($row = mysqli_fetch_assoc($resultUserTipps))
			{
				$vorrundeid = $row['vorrundefsid'];

				$tippedMatch = sprintf("Update vorrunde set result1 = '%s', result2 = '%s', highrisk = '%s' where vorrundeid=$vorrundeid and vorrundeteamsfsid=%d", htmlentities($result1, ENT_QUOTES, 'UTF-8'), htmlentities($result2, ENT_QUOTES, 'UTF-8'), htmlentities($highrisk, ENT_QUOTES, 'UTF-8'),htmlentities($i, ENT_QUOTES, 'UTF-8'));

				$resultTippedMatch = mysqli_query($this->link, $tippedMatch);

			}

		} else {
			$this->errors[] = "Die Zeit ist abgelaufen, um Resultattipps zu erfassen.";
		}
	}

	private function isExisting($vorrundeteamsid) {
		$userid = $_SESSION['userid'];

		$abfrage = "select * from uservorrunde, vorrunde where vorrundeteamsfsid=".$vorrundeteamsid." and userfsid=".$userid." and vorrundefsid=vorrundeid";

		$ergebnis = mysqli_query($this->link, $abfrage);
		while($row = mysqli_fetch_assoc($ergebnis))
		{
			return true;
		}

		return false;
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

	private function getUserResult($vorrundeteamsid) {
		$userid = $_SESSION['userid'];

		$anzahlUserTipps = "SELECT vorrundefsid FROM uservorrunde where userfsid=$userid";
		$resultUserTipps = mysqli_query($this->link, $anzahlUserTipps);

		while($row = mysqli_fetch_assoc($resultUserTipps))
		{
			$vorrundeid = $row['vorrundefsid'];

			$tippedMatch = "SELECT * FROM vorrunde where vorrundeid=$vorrundeid";
			$resultTippedMatch = mysqli_query($this->link, $tippedMatch);

			while($row = mysqli_fetch_assoc($resultTippedMatch))
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

	private function isDisabled($start) {
		if(time() > strtotime($start))
		return "disabled";

		return "enabled";
	}
	
	private function getData() {
		$abfrage = "SELECT * FROM vorrundeteams order by start asc";

		$ergebnis = mysqli_query($this->link, $abfrage);

		$i = 0;

		while($row = mysqli_fetch_assoc($ergebnis))
		{
			$this->vorrunde[$i]['id'] = $row['vorrundeteamsid'];
			$this->vorrunde[$i]['start'] = date('d.m.Y H:i', strtotime($row['start']));
			$this->vorrunde[$i]['disabled'] = $this->isDisabled($row['start']);
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
	
	private function getCountries() {
		$abfrage = "SELECT * FROM teams order by land asc";

		$ergebnis = mysqli_query($this->link, $abfrage);

		$i=0;
		while($row = mysqli_fetch_assoc($ergebnis))
		{
			$this->countries[$i]['id'] = $row['teamid'];
			$this->countries[$i]['land'] = $row['land'];
			$this->countries[$i]['gruppe'] = $row['gruppe'];
			$i++;
		}
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

	private function hasEqualTeams(){
		if($this->isDisabledWeitereTipps() == "disabled"){
			return false;
		}

		$achtelfinalArray[0] = $_POST["achtelfinal1"];
		$achtelfinalArray[1] = $_POST["achtelfinal2"];
		$achtelfinalArray[2] = $_POST["achtelfinal3"];
		$achtelfinalArray[3] = $_POST["achtelfinal4"];
		$achtelfinalArray[4] = $_POST["achtelfinal5"];
		$achtelfinalArray[5] = $_POST["achtelfinal6"];
		$achtelfinalArray[6] = $_POST["achtelfinal7"];
		$achtelfinalArray[7] = $_POST["achtelfinal8"];
		$achtelfinalArray[8] = $_POST["achtelfinal9"];
		$achtelfinalArray[9] = $_POST["achtelfinal10"];
		$achtelfinalArray[10] = $_POST["achtelfinal11"];
		$achtelfinalArray[11] = $_POST["achtelfinal12"];
		$achtelfinalArray[12] = $_POST["achtelfinal13"];
		$achtelfinalArray[13] = $_POST["achtelfinal14"];
		$achtelfinalArray[14] = $_POST["achtelfinal15"];
		$achtelfinalArray[15] = $_POST["achtelfinal16"];
		
		$resultAchtelFinalArray = array_count_values($achtelfinalArray);
			
		if(count($resultAchtelFinalArray) <= (16 - ($resultAchtelFinalArray[''] == 0 ? 1 : $resultAchtelFinalArray['']))){
			$this->errors[] = "Es d&uuml;rfen nicht mehrfach die gleichen Teams bei der Frage 'Wer &uuml;bersteht die Gruppenphase' selektiert werden!";
			return true;
		}
	}

	public function getHTML() {
		$this->getCountries();
		$this->phases = Constants::getPhases();
		include('layout/myTipps.tpl');
	}
}
?>