<?php
require_once("Page.php");
require_once('Datenbank/db.php');

class MyTipps extends HTMLPage implements Page {

	private $vorrunde = array();
	private $countries = array();
	private $hauptrundefsid = '';
	private $realhauptrunde = array();

	private $errors = array();

	private $userViertelfinal = array();
	private $userHalbfinal = array();
	private $userFinal = array();
	private $userEuropameister= '';


	private $link = '';

	public function __construct() {
		$this->link = Db::getConnection();

		$action = isset($_GET['action']) ? $_GET['action'] : '';

		$this->realhauptrunde = $this->getRealHauptrunde();
		$this->getData();

		if($action == "setGroupTipps") {
			$this->setGroupTipps();
		}
		
		if($action == "setFinalTipps") {
			$this->setFinalTipps();
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
				
			$realhauptrunde[] = $this->getTeam($row['europameister']);
		}

		return $realhauptrunde;
	}

	private function getUserHauptrundeTipps() {
		$userid = $_SESSION['userid'];

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

	private function setGroupTipps() {
		//set user vorrunde tipps
		for($i=1;$i<=24;$i++) {
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
				
		$_SESSION['infos'][] = "Ihre Tipps wurden erfolgreich erfasst.";
	}
	
	private function setFinalTipps() {
		//set hauptrunde tipps
		//Existingcheck
		
		if($this->hasEqualTeams()){
			return false;
		}
		
		$hauptrundetipps = array();

		$isStillEnabled = false;

		for($i=1;$i<=8;$i++) {
			$teamid = $_POST['viertelfinal'.$i];
			$hauptrundetipps[] = $teamid;
			if(!$isStillEnabled && $teamid != ''){
				$isStillEnabled = true;
			}
		}
		//halbfinal
		for($i=1;$i<=4;$i++) {
			$teamid = $_POST['halbfinal'.$i];
			$hauptrundetipps[] = $teamid;
			if(!$isStillEnabled && $teamid != ''){
				$isStillEnabled = true;
			}
		}

		//Final
		for($i=1;$i<=2;$i++) {
			$teamid = $_POST['final'.$i];
			$hauptrundetipps[] = $teamid;
			if(!$isStillEnabled && $teamid != ''){
				$isStillEnabled = true;
			}
		}

		//Europameister
		$teamid = $_POST['europameister'];
		$hauptrundetipps[] = $teamid;

		//timecheck??
		$this->hauptrundefsid = $this->isExistingHauptrunde();
		if($this->isDisabledHauptrunde()=="enabled") {
			if($this->hauptrundefsid) {
				$this->updateHauptrundeTipp($hauptrundetipps);
			} else {
				$this->addHauptrundeTipp($hauptrundetipps);
			}
		} 
		
		else if($isStillEnabled) {
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
	
		$abfrage = sprintf("Update hauptrunde set viertelfinal1 = '%s', viertelfinal2 = '%s', viertelfinal3 = '%s', viertelfinal4 = '%s', viertelfinal5 = '%s', viertelfinal6 = '%s', viertelfinal7 = '%s', viertelfinal8 = '%s', halbfinal1 = '%s', halbfinal2 = '%s', halbfinal3 = '%s', halbfinal4 = '%s', final1 = '%s', final2 = '%s', europameister = '%s' where userfsid=".$_SESSION['userid'], mysql_real_escape_string($hauptrundetipps[0], $this->link),mysql_real_escape_string($hauptrundetipps[1], $this->link), mysql_real_escape_string($hauptrundetipps[2], $this->link), mysql_real_escape_string($hauptrundetipps[3], $this->link), mysql_real_escape_string($hauptrundetipps[4], $this->link), mysql_real_escape_string($hauptrundetipps[5], $this->link), mysql_real_escape_string($hauptrundetipps[6], $this->link), mysql_real_escape_string($hauptrundetipps[7], $this->link), mysql_real_escape_string($hauptrundetipps[8], $this->link), mysql_real_escape_string($hauptrundetipps[9], $this->link), mysql_real_escape_string($hauptrundetipps[10], $this->link), mysql_real_escape_string($hauptrundetipps[11], $this->link), mysql_real_escape_string($hauptrundetipps[12], $this->link), mysql_real_escape_string($hauptrundetipps[13], $this->link), mysql_real_escape_string($hauptrundetipps[14], $this->link));

		$ergebnis = mysql_query($abfrage, $this->link);
	}

	private function addHauptrundeTipp($hauptrundetipps) {
		$abfrage = sprintf("Insert into hauptrunde values(%d, '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')",$_SESSION['userid'], mysql_real_escape_string($hauptrundetipps[0], $this->link),mysql_real_escape_string($hauptrundetipps[1], $this->link), mysql_real_escape_string($hauptrundetipps[2], $this->link), mysql_real_escape_string($hauptrundetipps[3], $this->link), mysql_real_escape_string($hauptrundetipps[4], $this->link), mysql_real_escape_string($hauptrundetipps[5], $this->link), mysql_real_escape_string($hauptrundetipps[6], $this->link), mysql_real_escape_string($hauptrundetipps[7], $this->link), mysql_real_escape_string($hauptrundetipps[8], $this->link), mysql_real_escape_string($hauptrundetipps[9], $this->link), mysql_real_escape_string($hauptrundetipps[10], $this->link), mysql_real_escape_string($hauptrundetipps[11], $this->link), mysql_real_escape_string($hauptrundetipps[12], $this->link), mysql_real_escape_string($hauptrundetipps[13], $this->link), mysql_real_escape_string($hauptrundetipps[14], $this->link));
		
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
			$abfrage = sprintf("Insert into vorrunde value('', '".$result1."', '".$result2."', '".$i."')", mysql_real_escape_string($result1, $this->link),  mysql_real_escape_string($result2, $this->link),  mysql_real_escape_string($i, $this->link));
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

				$tippedMatch = sprintf("Update vorrunde set result1 = '%s', result2 = '%s' where vorrundeid=$vorrundeid and vorrundeteamsfsid=%d", mysql_real_escape_string($result1, $this->link), mysql_real_escape_string($result2, $this->link), mysql_real_escape_string($i, $this->link));

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