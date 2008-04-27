<?php
require_once("Page.php");
require_once('Datenbank/db.php');

class MyTipps extends HTMLPage implements Page {

	private $vorrunde = array();
	private $countries = array();
	private $hauptrundefsid = '';

	private $userViertelfinal = array();
	private $userHalbfinal = array();
	private $userFinal = array();
	private $userEuropameister= '';


	public function __construct() {
		$action = isset($_GET['action']) ? $_GET['action'] : '';

		if($action == "setTipps") {
			$this->setTipps();
		}
		
		$this->hauptrundefsid = $this->isExistingHauptrunde();
		
		if($this->hauptrundefsid) {
		$this->getUserHauptrundeTipps();
		} 
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
			if($result1 != '' || $result2 != '') {
				if($this->isExisting($i)) {
					$this->updateTipp($i, $result1, $result2);
				} else {
					$this->addTipp($i, $result1, $result2);
				}
			}
		}
		//set hauptrunde tipps
		//Existingcheck

		$hauptrundetipps = array();


		for($i=1;$i<=8;$i++) {
			$teamid = $_POST['viertelfinal'.$i];
			$hauptrundetipps[] = $teamid;
		}
		//halbfinal
		for($i=1;$i<=4;$i++) {
			$teamid = $_POST['halbfinal'.$i];
			$hauptrundetipps[] = $teamid;
		}

		//Final
		for($i=1;$i<=2;$i++) {
			$teamid = $_POST['final'.$i];
			$hauptrundetipps[] = $teamid;
		}

		//Europameister
		$teamid = $_POST['europameister'];
		$hauptrundetipps[] = $teamid;

		//timecheck??
		$this->hauptrundefsid = $this->isExistingHauptrunde();
		
		if($this->hauptrundefsid) {
			$this->updateHauptrundeTipp($hauptrundetipps);
		} else {
			$this->addHauptrundeTipp($hauptrundetipps);
			
		}
	}

	private function updateHauptrundeTipp($hauptrundetipps) {
		$abfrage = "Update hauptrunde set viertelfinal1 = '".$hauptrundetipps[0]."', viertelfinal2 = '".$hauptrundetipps[1]."', viertelfinal3 = '".$hauptrundetipps[2]."', viertelfinal4 = '".$hauptrundetipps[3]."', viertelfinal5 = '".$hauptrundetipps[4]."', viertelfinal6 = '".$hauptrundetipps[5]."', viertelfinal7 = '".$hauptrundetipps[6]."', viertelfinal8 = '".$hauptrundetipps[7]."', halbfinal1 = '".$hauptrundetipps[8]."', halbfinal2 = '".$hauptrundetipps[9]."', halbfinal3 = '".$hauptrundetipps[10]."', halbfinal4 = '".$hauptrundetipps[11]."', final1 = '".$hauptrundetipps[12]."', final2 = '".$hauptrundetipps[13]."', europameister = '".$hauptrundetipps[14]."' where userfsid=".$_SESSION['userid'];
		mysql_query($abfrage);
	}

	private function addHauptrundeTipp($hauptrundetipps) {
		echo "insert";
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

		$i=0;
		while($row = mysql_fetch_assoc($ergebnis))
		{
			$this->countries[$i]['id'] = $row['teamid'];
			$this->countries[$i]['land'] = $row['land'];
			$i++;
		}
	}
	public function getHTML() {
		$this->getData();
		$this->getCountries();
		include('layout/myTipps.tpl');
	}
}
?>