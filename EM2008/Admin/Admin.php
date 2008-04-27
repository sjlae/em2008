<?php
require_once('Page.php');
require_once('Home/Home.php');
require_once('Datenbank/db.php');

class Admin extends HTMLPage implements Page{

	private $errors = array();
	
	private $nnb = array();
	private $countries = array();
	private $vorrunde = array();
	private $viertelfinal1 = '';
	private $viertelfinal2 = '';
	private $viertelfinal3 = '';
	private $viertelfinal4 = '';
	private $viertelfinal5 = '';
	private $viertelfinal6 = '';
	private $viertelfinal7 = '';
	private $viertelfinal8 = '';
	private $halbfinal1 = '';
	private $halbfinal2 = '';
	private $halbfinal3 = '';
	private $halbfinal4 = '';
	private $final1 = '';
	private $final2 = '';
	private $europameister = '';
		
	public function __construct() {
		$action = isset($_GET['action']) ? $_GET['action'] : '';

		if($action == 'nnb') {
			$this->setPayFlag();
		}
		
		if($action == 'results') {
			$this->setVorrundenResults();
			$this->hasEqualTeams();
			if(count($this->errors) == 0){
				$this->setHauptrundenTeams();
				$this->updateUserPoints();
			}
		}
		
		if($action == 'news') {
			$this->saveNews();
		}
	}

	private function hasEqualTeams(){
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
				return;
		}
		
		$halbfinalArray = array();
		
		$halbfinalArray[0] = $_POST["halbfinal1"];
		$halbfinalArray[1] = $_POST["halbfinal2"];
		$halbfinalArray[2] = $_POST["halbfinal3"];
		$halbfinalArray[3] = $_POST["halbfinal4"];
		
		$resultHalbFinalArray = array_count_values($halbfinalArray);
		
		if(count($resultHalbFinalArray) <= (4 - ($resultHalbFinalArray[''] == 0 ? 1 : $resultHalbFinalArray['']))){
				$this->errors[] = "Mehrfachnennungen von gleichen Teams innerhalb derselben Finalrunde sind nicht erlaubt!";
				return;
		}
		
		$finalArray = array();
		
		$finalArray[0] = $_POST["final1"];
		$finalArray[1] = $_POST["final2"];
		
		$resultFinalArray = array_count_values($finalArray);
		
		if(count($resultFinalArray) <= (2 - ($resultFinalArray[''] == 0 ? 1 : $resultFinalArray['']))){
				$this->errors[] = "Mehrfachnennungen von gleichen Teams innerhalb derselben Finalrunde sind nicht erlaubt!";
				return;
		}
	}
		
	private function setPayFlag() {
		for($i=0; $i<=$_POST['maxUser']; $i++) {
			if($_POST["user$i"] != '') {
				$userid = $_POST["user$i"];
				$abfrage = "Update User set bezahlt=1 where userid=$userid";
				mysql_query($abfrage);
			}
		}
	}
	
	private function setVorrundenResults() {
		for($counter=1; $counter<=24; $counter++) {
			if($_POST["result1_$counter"] != '' || $_POST["result1_$counter"] != '') {
				$result1 = $_POST["result1_$counter"];
				$result2 = $_POST["result2_$counter"];
				$abfrage = "Update Vorrundeteams set realresult1=$result1, realresult2=$result2 where vorrundeteamsid=$counter";
				mysql_query($abfrage);
			}
		}
	}
	
	private function setHauptrundenTeams() {
		$viertelfinal1 = $_POST["viertelfinal1"];
		$abfrage = "Update Realhauptrunde set viertelfinal1='".$viertelfinal1."'";
		mysql_query($abfrage);
		
		$viertelfinal2 = $_POST["viertelfinal2"];
		$abfrage = "Update Realhauptrunde set viertelfinal2='".$viertelfinal2."'";
		mysql_query($abfrage);
		
		$viertelfinal3 = $_POST["viertelfinal3"];
		$abfrage = "Update Realhauptrunde set viertelfinal3='".$viertelfinal3."'";
		mysql_query($abfrage);
		
		$viertelfinal4 = $_POST["viertelfinal4"];
		$abfrage = "Update Realhauptrunde set viertelfinal4='".$viertelfinal4."'";
		mysql_query($abfrage);
		
		$viertelfinal5 = $_POST["viertelfinal5"];
		$abfrage = "Update Realhauptrunde set viertelfinal5='".$viertelfinal5."'";
		mysql_query($abfrage);
		
		$viertelfinal6 = $_POST["viertelfinal6"];
		$abfrage = "Update Realhauptrunde set viertelfinal6='".$viertelfinal6."'";
		mysql_query($abfrage);
		
		$viertelfinal7 = $_POST["viertelfinal7"];
		$abfrage = "Update Realhauptrunde set viertelfinal7='".$viertelfinal7."'";
		mysql_query($abfrage);
		
		$viertelfinal8 = $_POST["viertelfinal8"];
		$abfrage = "Update Realhauptrunde set viertelfinal8='".$viertelfinal8."'";
		mysql_query($abfrage);
		
		$halbfinal1 = $_POST["halbfinal1"];
		$abfrage = "Update Realhauptrunde set halbfinal1='".$halbfinal1."'";
		mysql_query($abfrage);
		
		$halbfinal2 = $_POST["halbfinal2"];
		$abfrage = "Update Realhauptrunde set halbfinal2='".$halbfinal2."'";
		mysql_query($abfrage);
		
		$halbfinal3 = $_POST["halbfinal3"];
		$abfrage = "Update Realhauptrunde set halbfinal3='".$halbfinal3."'";
		mysql_query($abfrage);
		
		$halbfinal4 = $_POST["halbfinal4"];
		$abfrage = "Update Realhauptrunde set halbfinal4='".$halbfinal4."'";
		mysql_query($abfrage);
		
		$final1 = $_POST["final1"];
		$abfrage = "Update Realhauptrunde set final1='".$final1."'";
		mysql_query($abfrage);
		
		$final2 = $_POST["final2"];
		$abfrage = "Update Realhauptrunde set final2='".$final2."'";
		mysql_query($abfrage);
		
		$europameister = $_POST["europameister"];
		$abfrage = "Update Realhauptrunde set europameister='".$europameister."'";
		mysql_query($abfrage);
	}

	private function getNNB() {
		$abfrage = "SELECT * FROM User where bezahlt=0";

		$ergebnis = mysql_query($abfrage);
		$counter = 0;
		if(isset($ergebnis) && $ergebnis != null) {
			while($row = mysql_fetch_assoc($ergebnis))
			{
				$this->nnb[$counter]['userid'] = $row['userid'];
				$this->nnb[$counter]['nachname'] = $row['nachname'];
				$this->nnb[$counter]['vorname'] = $row['vorname'];
				$this->nnb[$counter]['email'] = $row['email'];
					
				$counter++;
			}
		}
	}

	private function getGames() {
		$abfrage = "SELECT * FROM VorrundeTeams";

		$ergebnis = mysql_query($abfrage);

		$i = 0;

		while($row = mysql_fetch_assoc($ergebnis))
		{
			$this->vorrunde[$i]['id'] = $row['vorrundeteamsid'];
			$this->vorrunde[$i]['start'] = date('d.m.Y H:i', strtotime($row['start']));
			$this->vorrunde[$i]['team1'] = $this->getTeam($row['team1fsid']);
			$this->vorrunde[$i]['team2'] = $this->getTeam($row['team2fsid']);
			$this->vorrunde[$i]['realresult1'] = $row['realresult1'];
			$this->vorrunde[$i]['realresult2'] = $row['realresult2'];
				
			$i++;
		}
	}
	
	private function getTeam($id) {
		$abfrage = "SELECT * FROM Teams where teamid=".$id;

		$ergebnis = mysql_query($abfrage);
		while($row = mysql_fetch_assoc($ergebnis))
		{
			return $row['land'];
		}
	}
	
	private function getCountries() {
		$abfrage = "SELECT * FROM Teams order by land asc";

		$ergebnis = mysql_query($abfrage);
		$counter = 0;
		while($row = mysql_fetch_assoc($ergebnis))
		{
			$this->countries[$counter]['land'] = $row['land'];
			$this->countries[$counter]['id'] = $row['teamid'];
			$counter++;
		}
	}
	
	private function getRealHauptrundenTeams() {
		$abfrage = "SELECT * FROM Realhauptrunde";
		$ergebnis = mysql_query($abfrage);
		while($row = mysql_fetch_assoc($ergebnis))
		{
			$this->viertelfinal1 = $row['viertelfinal1'];
			$this->viertelfinal2 = $row['viertelfinal2'];
			$this->viertelfinal3 = $row['viertelfinal3'];
			$this->viertelfinal4 = $row['viertelfinal4'];
			$this->viertelfinal5 = $row['viertelfinal5'];
			$this->viertelfinal6 = $row['viertelfinal6'];
			$this->viertelfinal7 = $row['viertelfinal7'];
			$this->viertelfinal8 = $row['viertelfinal8'];
			$this->halbfinal1 = $row['halbfinal1'];
			$this->halbfinal2 = $row['halbfinal2'];
			$this->halbfinal3 = $row['halbfinal3'];
			$this->halbfinal4 = $row['halbfinal4'];
			$this->final1 = $row['final1'];
			$this->final2 = $row['final2'];
			$this->europameister = $row['europameister'];
		}
	}
	
	private function updateUserPoints() {
		$userids = "SELECT * FROM User";
		
		$resultUsers = mysql_query($userids);
		
		while($row = mysql_fetch_assoc($resultUsers))
			{
				$userid = $row['userid'];
				$points = 0;
				
				$anzahlUserTipps = "SELECT vorrundefsid FROM UserVorrunde where userfsid=$userid";
				$resultUserTipps = mysql_query($anzahlUserTipps);
				
				while($row = mysql_fetch_assoc($resultUserTipps))
				{
					$vorrundeid = $row['vorrundefsid'];
					
					$tippedMatch = "SELECT * FROM Vorrunde where vorrundeid=$vorrundeid";
					$resultTippedMatch = mysql_query($tippedMatch);
					
					while($row = mysql_fetch_assoc($resultTippedMatch))
					{
						$tipp1 = $row['result1'];
						$tipp2 = $row['result2'];
						
						$match = $row['vorrundeteamsfsid'];
						
						$realResults = "SELECT realresult1, realresult2 FROM Vorrundeteams where vorrundeteamsid=".$match;
						
						$resultRealResults = mysql_query($realResults);
						while($row = mysql_fetch_assoc($resultRealResults))
						{	
							$real1 = $row['realresult1'];
							$real2 = $row['realresult2'];
							
							if($real1 != '' && $real2 != '' && $tipp1 != '' && $tipp2 != ''){
	                            if ($tipp1==$real1 && $tipp2==$real2) { 
	                            	$points = $points+5; 
	                            } 
	                            else if ($real1>$real2 && $tipp1>$tipp2) { 
	                            	if ($real1-$real2 == $tipp1-$tipp2) { 
	                                	$points = $points+4; 
	                                } 
	                                else { 
	                                	$points = $points+3; 
	                                } 
	                            } 
	                            else if ($real2>$real1 && $tipp2>$tipp1) { 
	                            	if ($real2-$real1 == $tipp2-$tipp1) { 
	                                	$points = $points+4; 
	                                } 
	                                else { 
	                                	$points = $points+3; 
	                                }                                                    
	                            } 
	                            else if ($real1==$real2 && $tipp1==$tipp2) { 
	                            	$points = $points+4; 
	                            }
							}
						}
					}
				}
				
				echo $points;
				
				$hauptrundeTippsFromUser = "SELECT * FROM hauptrunde where userfsid=$userid";
				$resultHauptrundeTippsFromUser = mysql_query($hauptrundeTippsFromUser);
				
				while($rowUser = mysql_fetch_assoc($resultHauptrundeTippsFromUser))
				{
					if($rowUser['viertelfinal1'] != ''){
						if($this->isViertelfinalTippCorrect($rowUser['viertelfinal1'])){
							$points = $points+6; 
						}
					}
					if($rowUser['viertelfinal2'] != ''){
						if($this->isViertelfinalTippCorrect($rowUser['viertelfinal2'])){
							$points = $points+6; 
						}
					}
					if($rowUser['viertelfinal3'] != ''){
						if($this->isViertelfinalTippCorrect($rowUser['viertelfinal3'])){
							$points = $points+6; 
						}
					}
					if($rowUser['viertelfinal4'] != ''){
						if($this->isViertelfinalTippCorrect($rowUser['viertelfinal4'])){
							$points = $points+6; 
						}
					}
					if($rowUser['viertelfinal5'] != ''){
						if($this->isViertelfinalTippCorrect($rowUser['viertelfinal5'])){
							$points = $points+6; 
						}
					}
					if($rowUser['viertelfinal6'] != ''){
						if($this->isViertelfinalTippCorrect($rowUser['viertelfinal6'])){
							$points = $points+6; 
						}
					}
					if($rowUser['viertelfinal7'] != ''){
						if($this->isViertelfinalTippCorrect($rowUser['viertelfinal7'])){
							$points = $points+6; 
						}
					}
					if($rowUser['viertelfinal8'] != ''){
						if($this->isViertelfinalTippCorrect($rowUser['viertelfinal8'])){
							$points = $points+6; 
						}
					}
					if($rowUser['halbfinal1'] != ''){
						if($this->isHalbfinalTippCorrect($rowUser['halbfinal1'])){
							$points = $points+8; 
						}
					}
					if($rowUser['halbfinal2'] != ''){
						if($this->isHalbfinalTippCorrect($rowUser['halbfinal2'])){
							$points = $points+8; 
						}
					}
					if($rowUser['halbfinal3'] != ''){
						if($this->isHalbfinalTippCorrect($rowUser['halbfinal3'])){
							$points = $points+8; 
						}
					}
					if($rowUser['halbfinal4'] != ''){
						if($this->isHalbfinalTippCorrect($rowUser['halbfinal4'])){
							$points = $points+8; 
						}
					}
					if($rowUser['final1'] != ''){
						if($this->isFinalTippCorrect($rowUser['final1'])){
							$points = $points+10; 
						}
					}
					if($rowUser['final2'] != ''){
						if($this->isFinalTippCorrect($rowUser['final2'])){
							$points = $points+10; 
						}
					}
					if($rowUser['europameister'] != ''){
						if($this->isEuropameisterTippCorrect($rowUser['europameister'])){
							$points = $points+12; 
						}
					}
				}
				
				$abfrage = "Update User set punkte=$points where userid=$userid";
				mysql_query($abfrage);
				
			}
		return $results;
	}
	
	private function isViertelfinalTippCorrect($value){
		$realhauptrunde = "SELECT * FROM realhauptrunde";
		$resultRealhauptrunde = mysql_query($realhauptrunde);
		
		$tippCorrect = false;
		
		while($rowReal = mysql_fetch_assoc($resultRealhauptrunde))
		{
			if($rowReal['viertelfinal1'] != ''){
				if($rowReal['viertelfinal1'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			if($rowReal['viertelfinal2'] != ''){
				if($rowReal['viertelfinal2'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			if($rowReal['viertelfinal3'] != ''){
				if($rowReal['viertelfinal3'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			if($rowReal['viertelfinal4'] != ''){
				if($rowReal['viertelfinal4'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			if($rowReal['viertelfinal5'] != ''){
				if($rowReal['viertelfinal5'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			if($rowReal['viertelfinal6'] != ''){
				if($rowReal['viertelfinal6'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			if($rowReal['viertelfinal7'] != ''){
				if($rowReal['viertelfinal7'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			if($rowReal['viertelfinal8'] != ''){
				if($rowReal['viertelfinal8'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			return $tippCorrect;			
		}
	}
	
	private function isHalbfinalTippCorrect($value){
		$realhauptrunde = "SELECT * FROM realhauptrunde";
		$resultRealhauptrunde = mysql_query($realhauptrunde);
		
		$tippCorrect = false;
		
		while($rowReal = mysql_fetch_assoc($resultRealhauptrunde))
		{
			if($rowReal['halbfinal1'] != ''){
				if($rowReal['halbfinal1'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			if($rowReal['halbfinal2'] != ''){
				if($rowReal['halbfinal2'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			if($rowReal['halbfinal3'] != ''){
				if($rowReal['halbfinal3'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			if($rowReal['halbfinal4'] != ''){
				if($rowReal['halbfinal4'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			return $tippCorrect;			
		}
	}

	private function isFinalTippCorrect($value){
		$realhauptrunde = "SELECT * FROM realhauptrunde";
		$resultRealhauptrunde = mysql_query($realhauptrunde);
		
		$tippCorrect = false;
		
		while($rowReal = mysql_fetch_assoc($resultRealhauptrunde))
		{
			if($rowReal['final1'] != ''){
				if($rowReal['final1'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			if($rowReal['final2'] != ''){
				if($rowReal['final2'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			return $tippCorrect;			
		}
	}

	private function isEuropameisterTippCorrect($value){
		$realhauptrunde = "SELECT europameister FROM realhauptrunde";
		$resultRealhauptrunde = mysql_query($realhauptrunde);
		
		$tippCorrect = false;
		
		while($rowReal = mysql_fetch_assoc($resultRealhauptrunde))
		{
			if($rowReal['europameister'] != ''){
				if($rowReal['europameister'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			return $tippCorrect;			
		}
	}
	
	private function saveNews(){
		$title = $_POST["newsTitle"];
		$text = $_POST["newsText"];
		
		$query = "Insert into News(titel, text) values('".$title."', '".$text."')";
			
		mysql_query($query);
	}
	
	public function getHTML() {
		$this->getNNB();
		$this->getGames();
		$this->getCountries();
		$this->getRealHauptrundenTeams();
		require_once('layout/admin.tpl');
	}
}
?>