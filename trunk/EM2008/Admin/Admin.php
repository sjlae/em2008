<?php
require_once('Page.php');
require_once('Home/Home.php');
require_once('Datenbank/db.php');
require_once('Constants.php');

class Admin extends HTMLPage implements Page{

	private $errors = array();
	
	private $nnb = array();
	private $all = array();
	private $countries = array();
	private $vorrunde = array();
	private $achtelfinal1 = '';
	private $achtelfinal2 = '';
	private $achtelfinal3 = '';
	private $achtelfinal4 = '';
	private $achtelfinal5 = '';
	private $achtelfinal6 = '';
	private $achtelfinal7 = '';
	private $achtelfinal8 = '';
	private $achtelfinal9 = '';
	private $achtelfinal10 = '';
	private $achtelfinal11 = '';
	private $achtelfinal12 = '';
	private $achtelfinal13 = '';
	private $achtelfinal14 = '';
	private $achtelfinal15 = '';
	private $achtelfinal16 = '';
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
	private $sieger = '';

	private $link = '';
	
	public function __construct() {
		$this->link = Db::getConnection();
	
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
			$this->updateRanking();
		}
		
		if($action == 'news') {
			$this->saveNews();
		}
		
		if($action == 'delete') {
			$this->deleteUsers();
		}
	}

	private function hasEqualTeams(){
		if(Constants::$isWM){
			$achtelfinalArray = array();
			
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
					return;
			}
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
		if(isset($_POST['users_nnb'])){
			foreach($_POST['users_nnb'] as $user_id){
				$abfrage = "Update user set bezahlt=1 where userid=$user_id";
				mysql_query($abfrage);
			}
		}
	}
	
	private function deleteUsers() {
		if(isset($_POST['users_delete'])){
			foreach($_POST['users_delete'] as $user_id){
				$vorrunde_ids = mysql_query("Select vorrundefsid FROM uservorrunde where userfsid = $user_id");
				while($row = mysql_fetch_assoc($vorrunde_ids)){
					mysql_query("Delete from vorrunde where vorrundeid = $row[vorrundefsid]");
				}
				mysql_query("Delete from uservorrunde where userfsid = $user_id");
				mysql_query("Delete from user where userid = $user_id");
				mysql_query("Delete from hauptrunde where userfsid = $user_id");
				mysql_query("Delete from guestbook where userfsid = $user_id");
			}
		}
	}
	
	private function setVorrundenResults() {
		$result = mysql_query("Select COUNT(start) as Number from vorrundeteams");
		$countGames = mysql_fetch_assoc($result);
		for($counter=1; $counter<=$countGames['Number']; $counter++) {
			$result1 = $_POST["result1_$counter"];
			$result2 = $_POST["result2_$counter"];
			$abfrage = "Update vorrundeteams set realresult1='".$result1."', realresult2='".$result2."' where vorrundeteamsid=$counter";
			mysql_query($abfrage);
		}
	}
	
	private function setHauptrundenTeams() {
		if(Constants::$isWM){
			$achtelfinal1 = $_POST["achtelfinal1"];
			$abfrage = "Update realhauptrunde set achtelfinal1='".$achtelfinal1."'";
			mysql_query($abfrage);
			
			$achtelfinal2 = $_POST["achtelfinal2"];
			$abfrage = "Update realhauptrunde set achtelfinal2='".$achtelfinal2."'";
			mysql_query($abfrage);
			
			$achtelfinal3 = $_POST["achtelfinal3"];
			$abfrage = "Update realhauptrunde set achtelfinal3='".$achtelfinal3."'";
			mysql_query($abfrage);
			
			$achtelfinal4 = $_POST["achtelfinal4"];
			$abfrage = "Update realhauptrunde set achtelfinal4='".$achtelfinal4."'";
			mysql_query($abfrage);
			
			$achtelfinal5 = $_POST["achtelfinal5"];
			$abfrage = "Update realhauptrunde set achtelfinal5='".$achtelfinal5."'";
			mysql_query($abfrage);
			
			$achtelfinal6 = $_POST["achtelfinal6"];
			$abfrage = "Update realhauptrunde set achtelfinal6='".$achtelfinal6."'";
			mysql_query($abfrage);
			
			$achtelfinal7 = $_POST["achtelfinal7"];
			$abfrage = "Update realhauptrunde set achtelfinal7='".$achtelfinal7."'";
			mysql_query($abfrage);
			
			$achtelfinal8 = $_POST["achtelfinal8"];
			$abfrage = "Update realhauptrunde set achtelfinal8='".$achtelfinal8."'";
			mysql_query($abfrage);
			
			$achtelfinal9 = $_POST["achtelfinal9"];
			$abfrage = "Update realhauptrunde set achtelfinal9='".$achtelfinal9."'";
			mysql_query($abfrage);
			
			$achtelfinal10 = $_POST["achtelfinal10"];
			$abfrage = "Update realhauptrunde set achtelfinal10='".$achtelfinal10."'";
			mysql_query($abfrage);
			
			$achtelfinal11 = $_POST["achtelfinal11"];
			$abfrage = "Update realhauptrunde set achtelfinal11='".$achtelfinal11."'";
			mysql_query($abfrage);
			
			$achtelfinal12 = $_POST["achtelfinal12"];
			$abfrage = "Update realhauptrunde set achtelfinal12='".$achtelfinal12."'";
			mysql_query($abfrage);
			
			$achtelfinal13 = $_POST["achtelfinal13"];
			$abfrage = "Update realhauptrunde set achtelfinal13='".$achtelfinal13."'";
			mysql_query($abfrage);
			
			$achtelfinal14 = $_POST["achtelfinal14"];
			$abfrage = "Update realhauptrunde set achtelfinal14='".$achtelfinal14."'";
			mysql_query($abfrage);
			
			$achtelfinal15 = $_POST["achtelfinal15"];
			$abfrage = "Update realhauptrunde set achtelfinal15='".$achtelfinal15."'";
			mysql_query($abfrage);
			
			$achtelfinal16 = $_POST["achtelfinal16"];
			$abfrage = "Update realhauptrunde set achtelfinal16='".$achtelfinal16."'";
			mysql_query($abfrage);
		}
		
		$viertelfinal1 = $_POST["viertelfinal1"];
		$abfrage = "Update realhauptrunde set viertelfinal1='".$viertelfinal1."'";
		mysql_query($abfrage);
		
		$viertelfinal2 = $_POST["viertelfinal2"];
		$abfrage = "Update realhauptrunde set viertelfinal2='".$viertelfinal2."'";
		mysql_query($abfrage);
		
		$viertelfinal3 = $_POST["viertelfinal3"];
		$abfrage = "Update realhauptrunde set viertelfinal3='".$viertelfinal3."'";
		mysql_query($abfrage);
		
		$viertelfinal4 = $_POST["viertelfinal4"];
		$abfrage = "Update realhauptrunde set viertelfinal4='".$viertelfinal4."'";
		mysql_query($abfrage);
		
		$viertelfinal5 = $_POST["viertelfinal5"];
		$abfrage = "Update realhauptrunde set viertelfinal5='".$viertelfinal5."'";
		mysql_query($abfrage);
		
		$viertelfinal6 = $_POST["viertelfinal6"];
		$abfrage = "Update realhauptrunde set viertelfinal6='".$viertelfinal6."'";
		mysql_query($abfrage);
		
		$viertelfinal7 = $_POST["viertelfinal7"];
		$abfrage = "Update realhauptrunde set viertelfinal7='".$viertelfinal7."'";
		mysql_query($abfrage);
		
		$viertelfinal8 = $_POST["viertelfinal8"];
		$abfrage = "Update realhauptrunde set viertelfinal8='".$viertelfinal8."'";
		mysql_query($abfrage);
		
		$halbfinal1 = $_POST["halbfinal1"];
		$abfrage = "Update realhauptrunde set halbfinal1='".$halbfinal1."'";
		mysql_query($abfrage);
		
		$halbfinal2 = $_POST["halbfinal2"];
		$abfrage = "Update realhauptrunde set halbfinal2='".$halbfinal2."'";
		mysql_query($abfrage);
		
		$halbfinal3 = $_POST["halbfinal3"];
		$abfrage = "Update realhauptrunde set halbfinal3='".$halbfinal3."'";
		mysql_query($abfrage);
		
		$halbfinal4 = $_POST["halbfinal4"];
		$abfrage = "Update realhauptrunde set halbfinal4='".$halbfinal4."'";
		mysql_query($abfrage);
		
		$final1 = $_POST["final1"];
		$abfrage = "Update realhauptrunde set final1='".$final1."'";
		mysql_query($abfrage);
		
		$final2 = $_POST["final2"];
		$abfrage = "Update realhauptrunde set final2='".$final2."'";
		mysql_query($abfrage);
		
		$sieger = $_POST["sieger"];
		$abfrage = "Update realhauptrunde set sieger='".$sieger."'";
		mysql_query($abfrage);
	}

	private function getNNB() {
		$abfrage = "SELECT * FROM user where bezahlt=0 order by nachname ASC";

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
	
	private function getAll() {
		$abfrage = "SELECT * FROM user order by nachname ASC";

		$ergebnis = mysql_query($abfrage);
		$counter = 0;
		if(isset($ergebnis) && $ergebnis != null) {
			while($row = mysql_fetch_assoc($ergebnis))
			{
				$this->all[$counter]['userid'] = $row['userid'];
				$this->all[$counter]['nachname'] = $row['nachname'];
				$this->all[$counter]['vorname'] = $row['vorname'];
				$this->all[$counter]['email'] = $row['email'];
					
				$counter++;
			}
		}
	}

	private function getGames() {
		$abfrage = "SELECT * FROM vorrundeteams";

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
		$abfrage = "SELECT * FROM teams where teamid=".$id;

		$ergebnis = mysql_query($abfrage);
		while($row = mysql_fetch_assoc($ergebnis))
		{
			return $row['land'];
		}
	}
	
	private function getCountries() {
		$abfrage = "SELECT * FROM teams order by land asc";

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
		$abfrage = "SELECT * FROM realhauptrunde";
		$ergebnis = mysql_query($abfrage);
		while($row = mysql_fetch_assoc($ergebnis))
		{
			if(Constants::$isWM){
				$this->achtelfinal1 = $row['achtelfinal1'];
				$this->achtelfinal2 = $row['achtelfinal2'];
				$this->achtelfinal3 = $row['achtelfinal3'];
				$this->achtelfinal4 = $row['achtelfinal4'];
				$this->achtelfinal5 = $row['achtelfinal5'];
				$this->achtelfinal6 = $row['achtelfinal6'];
				$this->achtelfinal7 = $row['achtelfinal7'];
				$this->achtelfinal8 = $row['achtelfinal8'];
				$this->achtelfinal9 = $row['achtelfinal9'];
				$this->achtelfinal10 = $row['achtelfinal10'];
				$this->achtelfinal11 = $row['achtelfinal11'];
				$this->achtelfinal12 = $row['achtelfinal12'];
				$this->achtelfinal13 = $row['achtelfinal13'];
				$this->achtelfinal14 = $row['achtelfinal14'];
				$this->achtelfinal15 = $row['achtelfinal15'];
				$this->achtelfinal16 = $row['achtelfinal16'];
			}
			
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
			$this->sieger = $row['sieger'];
		}
	}
	
	private function updateUserPoints() {
		$userids = "SELECT * FROM user";
		
		$resultUsers = mysql_query($userids);
		
		while($row = mysql_fetch_assoc($resultUsers))
			{
				$userid = $row['userid'];
				$points = 0;
				
				$anzahlUserTipps = "SELECT vorrundefsid FROM uservorrunde where userfsid=$userid";
				$resultUserTipps = mysql_query($anzahlUserTipps);
				
				while($row = mysql_fetch_assoc($resultUserTipps))
				{
					$vorrundeid = $row['vorrundefsid'];
					
					$tippedMatch = "SELECT * FROM vorrunde where vorrundeid=$vorrundeid";
					$resultTippedMatch = mysql_query($tippedMatch);
					
					while($row = mysql_fetch_assoc($resultTippedMatch))
					{
						$tipp1 = $row['result1'];
						$tipp2 = $row['result2'];
						
						$match = $row['vorrundeteamsfsid'];
						
						$realResults = "SELECT realresult1, realresult2 FROM vorrundeteams where vorrundeteamsid=".$match;
						
						$resultRealResults = mysql_query($realResults);
						while($row = mysql_fetch_assoc($resultRealResults))
						{	
							$real1 = $row['realresult1'];
							$real2 = $row['realresult2'];
							
							if($real1 != '' && $real2 != '' && $tipp1 != '' && $tipp2 != '' && $tipp1>=0 && $tipp2>=0 && is_numeric($tipp1) && is_numeric($tipp2)){
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
				
				$hauptrundeTippsFromUser = "SELECT * FROM hauptrunde where userfsid=$userid";
				$resultHauptrundeTippsFromUser = mysql_query($hauptrundeTippsFromUser);
				
				while($rowUser = mysql_fetch_assoc($resultHauptrundeTippsFromUser))
				{
					if(Constants::$isWM){
						if($rowUser['achtelfinal1'] != ''){
							if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal1'])){
								$points = $points+4; 
							}
						}
						
						if($rowUser['achtelfinal2'] != ''){
							if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal2'])){
								$points = $points+4; 
							}
						}
						
						if($rowUser['achtelfinal3'] != ''){
							if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal3'])){
								$points = $points+4; 
							}
						}
						
						if($rowUser['achtelfinal4'] != ''){
							if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal4'])){
								$points = $points+4; 
							}
						}
						
						if($rowUser['achtelfinal5'] != ''){
							if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal5'])){
								$points = $points+4; 
							}
						}
						
						if($rowUser['achtelfinal6'] != ''){
							if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal6'])){
								$points = $points+4; 
							}
						}
						
						if($rowUser['achtelfinal7'] != ''){
							if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal7'])){
								$points = $points+4; 
							}
						}
						
						if($rowUser['achtelfinal8'] != ''){
							if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal8'])){
								$points = $points+4; 
							}
						}
						
						if($rowUser['achtelfinal9'] != ''){
							if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal9'])){
								$points = $points+4; 
							}
						}
						
						if($rowUser['achtelfinal10'] != ''){
							if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal10'])){
								$points = $points+4; 
							}
						}
						
						if($rowUser['achtelfinal11'] != ''){
							if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal11'])){
								$points = $points+4; 
							}
						}
						
						if($rowUser['achtelfinal12'] != ''){
							if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal12'])){
								$points = $points+4; 
							}
						}
						
						if($rowUser['achtelfinal13'] != ''){
							if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal13'])){
								$points = $points+4; 
							}
						}
						
						if($rowUser['achtelfinal14'] != ''){
							if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal14'])){
								$points = $points+4; 
							}
						}
						
						if($rowUser['achtelfinal15'] != ''){
							if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal15'])){
								$points = $points+4; 
							}
						}
						
						if($rowUser['achtelfinal16'] != ''){
							if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal16'])){
								$points = $points+4; 
							}
						}
					}
					
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
					if($rowUser['sieger'] != ''){
						if($this->isSiegerTippCorrect($rowUser['sieger'])){
							$points = $points+12; 
						}
					}
				}
				
				$abfrage = "Update user set punkte=$points where userid=$userid";
				mysql_query($abfrage);
				
			}
		return $results;
	}
	
	private function updateRanking(){
		$userids = "SELECT * FROM user ORDER BY punkte DESC";
		
		$resultUsers = mysql_query($userids);
		
		$temp_points = '';
		$rank_counter = 1;
		$rank_logic= 1;
		while($row = mysql_fetch_assoc($resultUsers))
		{
			$userid = $row['userid'];
			$rank_now = $row['rank_now'];
			
			$rank_last = "Update user set rank_last=$rank_now where userid=$userid";
		
			mysql_query($rank_last); 
			
			if($temp_points == '' || $temp_points != $row['punkte']){
				$temp_points = $row['punkte'];
				$rank_logic = $rank_counter;
			}
			
			$rank_now = "Update user set rank_now=$rank_logic where userid=$userid";
	
			mysql_query($rank_now);	

			$rank_counter++;
		}
	}
	
	private function isAchtelfinalTippCorrect($value){
		$realhauptrunde = "SELECT * FROM realhauptrunde";
		$resultRealhauptrunde = mysql_query($realhauptrunde);
		
		$tippCorrect = false;
		
		while($rowReal = mysql_fetch_assoc($resultRealhauptrunde))
		{
			if($rowReal['achtelfinal1'] != ''){
				if($rowReal['achtelfinal1'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			if($rowReal['achtelfinal2'] != ''){
				if($rowReal['achtelfinal2'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			if($rowReal['achtelfinal3'] != ''){
				if($rowReal['achtelfinal3'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			if($rowReal['achtelfinal4'] != ''){
				if($rowReal['achtelfinal4'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			if($rowReal['achtelfinal5'] != ''){
				if($rowReal['achtelfinal5'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			if($rowReal['achtelfinal6'] != ''){
				if($rowReal['achtelfinal6'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			if($rowReal['achtelfinal7'] != ''){
				if($rowReal['achtelfinal7'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			if($rowReal['achtelfinal8'] != ''){
				if($rowReal['achtelfinal8'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			if($rowReal['achtelfinal9'] != ''){
				if($rowReal['achtelfinal9'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			if($rowReal['achtelfinal10'] != ''){
				if($rowReal['achtelfinal10'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			if($rowReal['achtelfinal11'] != ''){
				if($rowReal['achtelfinal11'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			if($rowReal['achtelfinal12'] != ''){
				if($rowReal['achtelfinal12'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			if($rowReal['achtelfinal13'] != ''){
				if($rowReal['achtelfinal13'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			if($rowReal['achtelfinal14'] != ''){
				if($rowReal['achtelfinal14'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			if($rowReal['achtelfinal15'] != ''){
				if($rowReal['achtelfinal15'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			if($rowReal['achtelfinal16'] != ''){
				if($rowReal['achtelfinal16'] == $value){
					$tippCorrect = true;
					return $tippCorrect;
				}
			}
			return $tippCorrect;			
		}
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

	private function isSiegerTippCorrect($value){
		$realhauptrunde = "SELECT sieger FROM realhauptrunde";
		$resultRealhauptrunde = mysql_query($realhauptrunde);
		
		$tippCorrect = false;
		
		while($rowReal = mysql_fetch_assoc($resultRealhauptrunde))
		{
			if($rowReal['sieger'] != ''){
				if($rowReal['sieger'] == $value){
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
		
		$query = "Insert into news(titel, text) values('".$title."', '".$text."')";
			
		mysql_query($query);
	}
	
	public function getHTML() {
		$this->getNNB();
		$this->getAll();
		$this->getGames();
		$this->getCountries();
		$this->getRealHauptrundenTeams();
		require_once('layout/admin.tpl');
	}
}
?>