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


	public function __construct() {
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

	private function setTipps() {
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

		if($this->hasEqualTeams()){
			return false;
		}
		
		//set hauptrunde tipps
		//Existingcheck

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
		} else if($isStillEnabled) {
			$this->errors[] = "Die Zeit ist abgelaufen, um Hauptrundentipps zu erfassen.";
		}

		$_SESSION['infos'][] = "Ihre Tipps wurden erfolgreich erfasst.";
	}

	private function isDisabledHauptrunde() {
		if(mktime() > mktime(18, 0, 0, 6, 7, 2008))
		return "disabled";

		return "enabled";
	}

	private function updateHauptrundeTipp($hauptrundetipps) {
		$abfrage = "Update hauptrunde set viertelfinal1 = '".$hauptrundetipps[0]."', viertelfinal2 = '".$hauptrundetipps[1]."', viertelfinal3 = '".$hauptrundetipps[2]."', viertelfinal4 = '".$hauptrundetipps[3]."', viertelfinal5 = '".$hauptrundetipps[4]."', viertelfinal6 = '".$hauptrundetipps[5]."', viertelfinal7 = '".$hauptrundetipps[6]."', viertelfinal8 = '".$hauptrundetipps[7]."', halbfinal1 = '".$hauptrundetipps[8]."', halbfinal2 = '".$hauptrundetipps[9]."', halbfinal3 = '".$hauptrundetipps[10]."', halbfinal4 = '".$hauptrundetipps[11]."', final1 = '".$hauptrundetipps[12]."', final2 = '".$hauptrundetipps[13]."', europameister = '".$hauptrundetipps[14]."' where userfsid=".$_SESSION['userid'];
		mysql_query($abfrage);
	}

	private function addHauptrundeTipp($hauptrundetipps) {
		$abfrage = "Insert into hauptrunde values(".$_SESSION['userid'].", '".$hauptrundetipps[0]."', '".$hauptrundetipps[1]."', '".$hauptrundetipps[2]."', '".$hauptrundetipps[3]."', '".$hauptrundetipps[4]."', '".$hauptrundetipps[5]."', '".$hauptrundetipps[6]."', '".$hauptrundetipps[7]."', '".$hauptrundetipps[8]."', '".$hauptrundetipps[9]."', '".$hauptrundetipps[10]."', '".$hauptrundetipps[11]."', '".$hauptrundetipps[12]."', '".$hauptrundetipps[13]."', '".$hauptrundetipps[14]."')";
		mysql_query($abfrage);
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
			$abfrage = "Insert into vorrunde value('', '".$result1."', '".$result2."', '".$i."')";
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

				$tippedMatch = "Update vorrunde set result1 = '".$result1."', result2 = '".$result2."' where vorrundeid=$vorrundeid and vorrundeteamsfsid=".$i;

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