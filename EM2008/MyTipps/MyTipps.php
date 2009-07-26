<?php
require_once("Page.php");
require_once('Datenbank/db.php');
require_once('Constants.php');

class MyTipps extends HTMLPage implements Page {

	private $vorrunde = array();
	private $countries = array();
	private $hauptrundefsid = '';
	private $realhauptrunde = array();

	private $errors = array();

	private $userAchtelfinal = array();
	private $userViertelfinal = array();
	private $userHalbfinal = array();
	private $userFinal = array();
	private $userSieger= '';


	private $link = '';

	public function __construct() {
		$this->link = Db::getConnection();

		$action = isset($_GET['action']) ? $_GET['action'] : '';

		$this->realhauptrunde = $this->getRealHauptrunde();
		$this->getData();

		if($action == "setTipps") {
			$this->setTipps();
		}

		$this->getData();

		$this->hauptrundefsid = $this->isExistingHauptrunde();

		if($this->hauptrundefsid) {
			$this->getUserHauptrundeTipps();
		}
	}

	private function getRealHauptrunde() {
		$abfrage = "Select * from realhauptrunde";
		$realhauptrunde = array();

		$ergebnis = mysql_query($abfrage);
		while($row = mysql_fetch_assoc($ergebnis))
		{
			if(Constants::$isWM){
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
			}
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

	private function getUserHauptrundeTipps() {
		$userid = $_SESSION['userid'];

		$abfrage = "Select * from hauptrunde where userfsid=".$userid;

		$ergebnis = mysql_query($abfrage);
		while($row = mysql_fetch_assoc($ergebnis))
		{
			if(Constants::$isWM){
				for($i=1;$i<=16;$i++) {
					$this->userAchtelfinal[$i] = $row['achtelfinal'.$i];
				}
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

	private function setTipps() {
		$result = mysql_query("Select COUNT(start) as Number from vorrundeteams");
		$countGames = mysql_fetch_assoc($result);
		for($i=1;$i<=$countGames['Number'];$i++) {
			$result1 = $_POST['result1'.$i];
			$result2 = $_POST['result2'.$i];
			if($this->isDisabled($this->vorrunde[$i-1]['start']) == 'enabled' || ($this->isDisabled($this->vorrunde[$i-1]['start']) == 'disabled' && ($result1 != '' || $result2 != ''))) {
				if($this->isExisting($i)) {
					if($this->isExisting($i)) {
						$this->updateTipp($i, $result1, $result2);
					} else {
						$this->addTipp($i, $result1, $result2);
					}
				} else {
					if($result1 != '' || $result2 != '') {
						if($this->isExisting($i)) {
							$this->updateTipp($i, $result1, $result2);
						} else {
							$this->addTipp($i, $result1, $result2);
						}
					}
				}
			}
		}

		if($this->hasEqualTeams()){
			return false;
		}

		//set hauptrunde tipps
		//Existingcheck

		$hauptrundetipps = array();

		$isStillEnabled = false;

		if(Constants::$isWM){
			for($i=1;$i<=16;$i++) {
				$teamid = $_POST['achtelfinal'.$i];
				$hauptrundetipps[] = $teamid;
				if(!$isStillEnabled && $teamid != ''){
					$isStillEnabled = true;
				}
			}
		}
		
		for($i=1;$i<=8;$i++) {
			$teamid = $_POST['viertelfinal'.$i];
			$hauptrundetipps[] = $teamid;
			if(!$isStillEnabled && $teamid != ''){
				$isStillEnabled = true;
			}
		}
		
		for($i=1;$i<=4;$i++) {
			$teamid = $_POST['halbfinal'.$i];
			$hauptrundetipps[] = $teamid;
			if(!$isStillEnabled && $teamid != ''){
				$isStillEnabled = true;
			}
		}

		for($i=1;$i<=2;$i++) {
			$teamid = $_POST['final'.$i];
			$hauptrundetipps[] = $teamid;
			if(!$isStillEnabled && $teamid != ''){
				$isStillEnabled = true;
			}
		}

		$teamid = $_POST['sieger'];
		$hauptrundetipps[] = $teamid;

		//timecheck??
		$this->hauptrundefsid = $this->isExistingHauptrunde();
		if($this->isDisabledHauptrunde()=="enabled") {
			if($this->hauptrundefsid) {
				$this->updateHauptrundeTipp($hauptrundetipps);
			} else {
				$this->addHauptrundeTipp($hauptrundetipps);
			}
		} else if($isStillEnabled) {
			$this->errors[] = "Die Zeit ist abgelaufen, um Hauptrundentipps zu erfassen.";
		}

		$_SESSION['infos'][] = "Ihre Tipps wurden erfolgreich erfasst.";
	}

	private function isDisabledHauptrunde() {
		$abfrage = "SELECT start FROM vorrundeteams where vorrundeteamsid=1";

		$ergebnis = mysql_query($abfrage);
		$startTime = mysql_fetch_row($ergebnis);
		if(mktime() > strtotime($startTime[0])){
			return "disabled";
		}
		else{
			return "enabled";
		}
	}

	private function updateHauptrundeTipp($hauptrundetipps) {
	
		if(Constants::$isWM){
			$abfrage = sprintf("Update hauptrunde set achtelfinal1 = '%s', achtelfinal2 = '%s', achtelfinal3 = '%s', achtelfinal4 = '%s', achtelfinal5 = '%s', achtelfinal6 = '%s', achtelfinal7 = '%s', achtelfinal8 = '%s', achtelfinal9 = '%s', achtelfinal10 = '%s', achtelfinal11 = '%s', achtelfinal12 = '%s', achtelfinal13 = '%s', achtelfinal14 = '%s', achtelfinal15 = '%s', achtelfinal16 = '%s', viertelfinal1 = '%s', viertelfinal2 = '%s', viertelfinal3 = '%s', viertelfinal4 = '%s', viertelfinal5 = '%s', viertelfinal6 = '%s', viertelfinal7 = '%s', viertelfinal8 = '%s', halbfinal1 = '%s', halbfinal2 = '%s', halbfinal3 = '%s', halbfinal4 = '%s', final1 = '%s', final2 = '%s', sieger = '%s' where userfsid=".$_SESSION['userid'], htmlentities(mysql_real_escape_string($hauptrundetipps[0], $this->link)),htmlentities(mysql_real_escape_string($hauptrundetipps[1], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[2], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[3], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[4], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[5], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[6], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[7], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[8], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[9], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[10], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[11], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[12], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[13], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[14], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[15], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[16], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[17], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[18], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[19], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[20], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[21], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[22], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[23], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[24], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[25], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[26], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[27], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[28], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[29], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[30], $this->link)));
		}
		else{
			$abfrage = sprintf("Update hauptrunde set viertelfinal1 = '%s', viertelfinal2 = '%s', viertelfinal3 = '%s', viertelfinal4 = '%s', viertelfinal5 = '%s', viertelfinal6 = '%s', viertelfinal7 = '%s', viertelfinal8 = '%s', halbfinal1 = '%s', halbfinal2 = '%s', halbfinal3 = '%s', halbfinal4 = '%s', final1 = '%s', final2 = '%s', sieger = '%s' where userfsid=".$_SESSION['userid'], htmlentities(mysql_real_escape_string($hauptrundetipps[0], $this->link)),htmlentities(mysql_real_escape_string($hauptrundetipps[1], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[2], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[3], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[4], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[5], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[6], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[7], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[8], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[9], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[10], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[11], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[12], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[13], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[14], $this->link)));	
		}

		$ergebnis = mysql_query($abfrage, $this->link);
	}

	private function addHauptrundeTipp($hauptrundetipps) {
		if(Constants::$isWM){
			$abfrage = sprintf("Insert into hauptrunde values(%d, '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')",$_SESSION['userid'], htmlentities(mysql_real_escape_string($hauptrundetipps[0], $this->link)),htmlentities(mysql_real_escape_string($hauptrundetipps[1], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[2], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[3], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[4], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[5], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[6], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[7], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[8], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[9], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[10], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[11], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[12], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[13], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[14], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[15], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[16], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[17], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[18], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[19], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[20], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[21], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[22], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[23], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[24], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[25], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[26], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[27], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[28], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[29], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[30], $this->link)));
		}
		else{
			$abfrage = sprintf("Insert into hauptrunde values(%d, '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')",$_SESSION['userid'], htmlentities(mysql_real_escape_string($hauptrundetipps[0], $this->link)),htmlentities(mysql_real_escape_string($hauptrundetipps[1], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[2], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[3], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[4], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[5], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[6], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[7], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[8], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[9], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[10], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[11], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[12], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[13], $this->link)), htmlentities(mysql_real_escape_string($hauptrundetipps[14], $this->link)));
		}
			
		$ergebnis = mysql_query($abfrage, $this->link);
	}

	private function isExistingHauptrunde() {
		$userid = $_SESSION['userid'];

		$abfrage = "SELECT userfsid FROM hauptrunde where userfsid=".$userid;

		$ergebnis = mysql_query($abfrage);
		while($row = mysql_fetch_assoc($ergebnis))
		{
			if($row['userfsid'] == '')
			return false;
			else
			return true;
		}
		return false;
	}

	private function addTipp($i, $result1, $result2) {
		if($this->isDisabled($this->vorrunde[$i-1]['start']) == 'enabled') {
			$abfrage = sprintf("Insert into vorrunde value('', '".$result1."', '".$result2."', '".$i."')", htmlentities(mysql_real_escape_string($result1, $this->link)),  htmlentities(mysql_real_escape_string($result2, $this->link)),  htmlentities(mysql_real_escape_string($i, $this->link)));
			mysql_query($abfrage);

			$vorrundeid = mysql_insert_id();

			$abfrage = "Insert into uservorrunde value(".$_SESSION['userid'].", ".$vorrundeid.")";
			mysql_query($abfrage);
		} else {
			$this->errors[] = "Die Zeit ist abgelaufen, um Vorrundentipps zu erfassen.";
		}
	}

	private function updateTipp($i, $result1, $result2) {
		if($this->isDisabled($this->vorrunde[$i-1]['start']) == 'enabled') {

			$userid = $_SESSION['userid'];

			$anzahlUserTipps = "SELECT vorrundefsid FROM uservorrunde where userfsid=$userid";
			$resultUserTipps = mysql_query($anzahlUserTipps);

			while($row = mysql_fetch_assoc($resultUserTipps))
			{
				$vorrundeid = $row['vorrundefsid'];

				$tippedMatch = sprintf("Update vorrunde set result1 = '%s', result2 = '%s' where vorrundeid=$vorrundeid and vorrundeteamsfsid=%d", htmlentities(mysql_real_escape_string($result1, $this->link)), htmlentities(mysql_real_escape_string($result2, $this->link)), htmlentities(mysql_real_escape_string($i, $this->link)));

				$resultTippedMatch = mysql_query($tippedMatch);

			}

		} else {
			$this->errors[] = "Die Zeit ist abgelaufen, um Vorrudentipps zu erfassen.";
		}
	}

	private function isExisting($vorrundeteamsid) {
		$userid = $_SESSION['userid'];

		$abfrage = "select * from uservorrunde, vorrunde where vorrundeteamsfsid=".$vorrundeteamsid." and userfsid=".$userid." and vorrundefsid=vorrundeid";

		$ergebnis = mysql_query($abfrage);
		while($row = mysql_fetch_assoc($ergebnis))
		{
			return true;
		}

		return false;
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

	private function getUserResult($vorrundeteamsid) {
		$userid = $_SESSION['userid'];

		$anzahlUserTipps = "SELECT vorrundefsid FROM uservorrunde where userfsid=$userid";
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

	private function isDisabled($start) {
		if(mktime() > strtotime($start))
		return "disabled";

		return "enabled";
	}
	private function getData() {
		$abfrage = "SELECT * FROM vorrundeteams";

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

	private function hasEqualTeams(){
		if($this->isDisabledHauptrunde() == "disabled"){
			return false;
		}

		$viertelfinalArray = array();

		if(Constants::$isWM){
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
				$this->errors[] = "Mehrfachnennungen von gleichen Teams innerhalb derselben Finalrunde sind nicht erlaubt!";
				return true;
			}
		}
		
		$viertelfinalArray[0] = $_POST["viertelfinal1"];
		$viertelfinalArray[1] = $_POST["viertelfinal2"];
		$viertelfinalArray[2] = $_POST["viertelfinal3"];
		$viertelfinalArray[3] = $_POST["viertelfinal4"];
		$viertelfinalArray[4] = $_POST["viertelfinal5"];
		$viertelfinalArray[5] = $_POST["viertelfinal6"];
		$viertelfinalArray[6] = $_POST["viertelfinal7"];
		$viertelfinalArray[7] = $_POST["viertelfinal8"];

		$resultViertelFinalArray = array_count_values($viertelfinalArray);
			
		if(count($resultViertelFinalArray) <= (8 - ($resultViertelFinalArray[''] == 0 ? 1 : $resultViertelFinalArray['']))){
			$this->errors[] = "Mehrfachnennungen von gleichen Teams innerhalb derselben Finalrunde sind nicht erlaubt!";
			return true;
		}

		$halbfinalArray = array();

		$halbfinalArray[0] = $_POST["halbfinal1"];
		$halbfinalArray[1] = $_POST["halbfinal2"];
		$halbfinalArray[2] = $_POST["halbfinal3"];
		$halbfinalArray[3] = $_POST["halbfinal4"];

		$resultHalbFinalArray = array_count_values($halbfinalArray);

		if(count($resultHalbFinalArray) <= (4 - ($resultHalbFinalArray[''] == 0 ? 1 : $resultHalbFinalArray['']))){
			$this->errors[] = "Mehrfachnennungen von gleichen Teams innerhalb derselben Finalrunde sind nicht erlaubt!";
			return true;
		}

		$finalArray = array();

		$finalArray[0] = $_POST["final1"];
		$finalArray[1] = $_POST["final2"];

		$resultFinalArray = array_count_values($finalArray);

		if(count($resultFinalArray) <= (2 - ($resultFinalArray[''] == 0 ? 1 : $resultFinalArray['']))){
			$this->errors[] = "Mehrfachnennungen von gleichen Teams innerhalb derselben Finalrunde sind nicht erlaubt!";
			return true;
		}
	}

	public function getHTML() {
		$this->getCountries();
		include('layout/myTipps.tpl');
	}
}
?>