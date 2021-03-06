<?php
require_once('Page.php');
require_once('Home/Home.php');
require_once('Datenbank/db.php');
require_once('Constants.php');

class Admin extends HTMLPage implements Page{

	private $errors = array();
	private $phases = array();
	private $nnb = array();
	private $all = array();
	private $notTipped = array();
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
	private $winner = '';
	private $best = '';
	private $worst = '';
	private $switzerland = '';
	private $lastwinner = '';
	
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
				$this->setWeitereTipps();
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
				mysql_query("Delete from userweiteretipps where userfsid = $user_id");
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
			$var1 = $counter."_1";
			$var2 = $counter."_2";
			if(is_numeric($_POST[$var1]) || is_numeric($_POST[$var2])){
				$team1 = $_POST[$var1];
				$team2 = $_POST[$var2];
				$abfrage = "";
				
				if(is_numeric($_POST[$var1]) && is_numeric($_POST[$var2])){
					$abfrage = "Update vorrundeteams set team1fsid='".$team1."', team2fsid='".$team2."', realresult1='".$result1."', realresult2='".$result2."' where vorrundeteamsid=$counter";
				}
				
				else if(is_numeric($_POST[$var1])){
					$abfrage = "Update vorrundeteams set team1fsid='".$team1."', realresult1='".$result1."', realresult2='".$result2."' where vorrundeteamsid=$counter";
				}
				
				else{
					$abfrage = "Update vorrundeteams set team2fsid='".$team2."', realresult1='".$result1."', realresult2='".$result2."' where vorrundeteamsid=$counter";
				}
				
				mysql_query($abfrage);
			}
			else{
				$abfrage = "Update vorrundeteams set realresult1='".$result1."', realresult2='".$result2."' where vorrundeteamsid=$counter";
				mysql_query($abfrage);
			}
		}
	}
	
	private function getRealWeitereTipps() {
		$abfrage = "SELECT * FROM realweiteretipps";
		$ergebnis = mysql_query($abfrage);
		while($row = mysql_fetch_assoc($ergebnis))
		{
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
			$this->winner = $row['winner'];
			$this->best = $row['best'];
			$this->worst = $row['worst'];
			$this->switzerland = $row['switzerland'];
			$this->lastwinner = $row['lastwinner'];
		}
	}
	
	private function setWeitereTipps() {
		$this->achtelfinal1 = $_POST["achtelfinal1"];
		$this->achtelfinal2 = $_POST["achtelfinal2"];
		$this->achtelfinal3 = $_POST["achtelfinal3"];
		$this->achtelfinal4 = $_POST["achtelfinal4"];
		$this->achtelfinal5 = $_POST["achtelfinal5"];
		$this->achtelfinal6 = $_POST["achtelfinal6"];
		$this->achtelfinal7 = $_POST["achtelfinal7"];
		$this->achtelfinal8 = $_POST["achtelfinal8"];
		$this->achtelfinal9 = $_POST["achtelfinal9"];
		$this->achtelfinal10 = $_POST["achtelfinal10"];
		$this->achtelfinal11 = $_POST["achtelfinal11"];
		$this->achtelfinal12 = $_POST["achtelfinal12"];
		$this->achtelfinal13 = $_POST["achtelfinal13"];
		$this->achtelfinal14 = $_POST["achtelfinal14"];
		$this->achtelfinal15 = $_POST["achtelfinal15"];
		$this->achtelfinal16 = $_POST["achtelfinal16"];
		$this->winner = $_POST['winner'];
		$this->best = $_POST['best'];
		$this->worst = $_POST['worst'];
		$this->switzerland = $_POST['switzerland'];
		$this->lastwinner = $_POST['lastwinner'];
		
		$abfrage = "Update realweiteretipps set achtelfinal1 ='".$this->achtelfinal1."', achtelfinal2 ='".$this->achtelfinal2."', achtelfinal3 ='".$this->achtelfinal3."', achtelfinal4 ='".$this->achtelfinal4."', achtelfinal5 ='".$this->achtelfinal5."', achtelfinal6 ='".$this->achtelfinal6."',
						achtelfinal7 ='".$this->achtelfinal7."', achtelfinal8 ='".$this->achtelfinal8."', achtelfinal9 ='".$this->achtelfinal9."', achtelfinal10 ='".$this->achtelfinal10."', achtelfinal11 ='".$this->achtelfinal11."', achtelfinal12 ='".$this->achtelfinal12."', achtelfinal13 ='".$this->achtelfinal13."',
						achtelfinal14 ='".$this->achtelfinal14."', achtelfinal15 ='".$this->achtelfinal15."', achtelfinal16 ='".$this->achtelfinal16."', winner = '".$this->winner."', best = '".$this->best."', worst = '".$this->worst."', switzerland = '".$this->switzerland."', lastwinner = '".$this->lastwinner."'";
		
		mysql_query($abfrage);
	}

	private function getNNB() {
		$abfrage = "SELECT userid, nachname, vorname, email FROM user where bezahlt=0 order by nachname ASC";

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
		$abfrage = "SELECT userid, nachname, vorname, email FROM user order by nachname ASC";

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
		$abfrage = "SELECT vorrundeteamsid, start, team1fsid, team2fsid, realresult1, realresult2 FROM vorrundeteams order by start asc";

		$ergebnis = mysql_query($abfrage);

		$i = 0;

		while($row = mysql_fetch_assoc($ergebnis))
		{
			$this->vorrunde[$i]['id'] = $row['vorrundeteamsid'];
			$this->vorrunde[$i]['start'] = date('d.m.Y H:i', strtotime($row['start']));
			$this->vorrunde[$i]['team1'] = is_numeric($row['team1fsid']) ? $this->getTeam($row['team1fsid']) : $row['team1fsid'];
			$this->vorrunde[$i]['team2'] = is_numeric($row['team2fsid']) ? $this->getTeam($row['team2fsid']) : $row['team2fsid'];
			$this->vorrunde[$i]['team1id'] = $row['team1fsid'];
			$this->vorrunde[$i]['team2id'] = $row['team2fsid'];
			$this->vorrunde[$i]['realresult1'] = $row['realresult1'];
			$this->vorrunde[$i]['realresult2'] = $row['realresult2'];
				
			$i++;
		}
	}
	
	private function getTeam($id) {
		$abfrage = "SELECT land FROM teams where teamid=".$id;

		$ergebnis = mysql_query($abfrage);
		while($row = mysql_fetch_assoc($ergebnis))
		{
			return $row['land'];
		}
	}
	
	private function getCountries() {
		$abfrage = "SELECT land, teamid FROM teams order by land asc";

		$ergebnis = mysql_query($abfrage);
		$counter = 0;
		while($row = mysql_fetch_assoc($ergebnis))
		{
			$this->countries[$counter]['land'] = $row['land'];
			$this->countries[$counter]['id'] = $row['teamid'];
			$counter++;
		}
	}
	
	private function updateUserPoints() {
		$userids = "SELECT userid FROM user";
		
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
					
					$tippedMatch = "SELECT result1, result2, highrisk, vorrundeteamsfsid FROM vorrunde where vorrundeid=$vorrundeid";
					$resultTippedMatch = mysql_query($tippedMatch);
					
					while($row = mysql_fetch_assoc($resultTippedMatch))
					{
						$tipp1 = $row['result1'];
						$tipp2 = $row['result2'];
						$highrisk = $row['highrisk'];
						
						$match = $row['vorrundeteamsfsid'];
						
						$realResults = "SELECT realresult1, realresult2 FROM vorrundeteams where vorrundeteamsid=".$match;
						
						$resultRealResults = mysql_query($realResults);
						while($row = mysql_fetch_assoc($resultRealResults))
						{	
							$real1 = $row['realresult1'];
							$real2 = $row['realresult2'];
							
							if($real1 != '' && $real2 != '' && $tipp1 != '' && $tipp2 != '' && $tipp1>=0 && $tipp2>=0 && is_numeric($tipp1) && is_numeric($tipp2)){
								// punktevergabe f�r highrisk
								if($highrisk == '1'){
									if($real1 == $tipp1 && $real2 == $tipp2){
										$points = $points+16;
									}
								}
	                            
								else{
		                            // 4 Punkte f�r korrekten Ausgang & 2 Punkt f�r korrekte Differenz
		                            if(($real1>$real2 && $tipp1>$tipp2) || ($real2>$real1 && $tipp2>$tipp1) || ($real1==$real2 && $tipp1==$tipp2)){
		                            	$points = $points+4;
		                            	if(($real1-$real2 == $tipp1-$tipp2) || ($real2-$real1 == $tipp2-$tipp1) || ($real1==$real2 && $tipp1==$tipp2)){
		                            		$points = $points+2;
		                            	}
		                            }
		                            // je 1 Punkt f�r korrekte Anzahl Tore der beiden Teams
									if($tipp1==$real1){
										$points = $points+1;
									}
									if($tipp2==$real2){
										$points = $points+1;
									}
								}
							}
						}
					}
				}
				
				$userweiteretipps = "SELECT * FROM userweiteretipps where userfsid=$userid";
				$resultUserWeitereTipps = mysql_query($userweiteretipps);
				
				while($rowUser = mysql_fetch_assoc($resultUserWeitereTipps))
				{
					$achtelfinal_points = '5';
					$winner_points = '12';
					$other_points = '5';
					
					if($rowUser['achtelfinal1'] != ''){
						if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal1'])){
							$points = $points+$achtelfinal_points; 
						}
					}
					
					if($rowUser['achtelfinal2'] != ''){
						if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal2'])){
							$points = $points+$achtelfinal_points; 
						}
					}
					
					if($rowUser['achtelfinal3'] != ''){
						if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal3'])){
							$points = $points+$achtelfinal_points; 
						}
					}
					
					if($rowUser['achtelfinal4'] != ''){
						if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal4'])){
							$points = $points+$achtelfinal_points; 
						}
					}
					
					if($rowUser['achtelfinal5'] != ''){
						if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal5'])){
							$points = $points+$achtelfinal_points; 
						}
					}
					
					if($rowUser['achtelfinal6'] != ''){
						if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal6'])){
							$points = $points+$achtelfinal_points; 
						}
					}
					
					if($rowUser['achtelfinal7'] != ''){
						if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal7'])){
							$points = $points+$achtelfinal_points; 
						}
					}
					
					if($rowUser['achtelfinal8'] != ''){
						if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal8'])){
							$points = $points+$achtelfinal_points; 
						}
					}
					
					if($rowUser['achtelfinal9'] != ''){
						if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal9'])){
							$points = $points+$achtelfinal_points; 
						}
					}
					
					if($rowUser['achtelfinal10'] != ''){
						if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal10'])){
							$points = $points+$achtelfinal_points; 
						}
					}
					
					if($rowUser['achtelfinal11'] != ''){
						if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal11'])){
							$points = $points+$achtelfinal_points; 
						}
					}
					
					if($rowUser['achtelfinal12'] != ''){
						if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal12'])){
							$points = $points+$achtelfinal_points; 
						}
					}
					
					if($rowUser['achtelfinal13'] != ''){
						if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal13'])){
							$points = $points+$achtelfinal_points; 
						}
					}
					
					if($rowUser['achtelfinal14'] != ''){
						if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal14'])){
							$points = $points+$achtelfinal_points; 
						}
					}
					
					if($rowUser['achtelfinal15'] != ''){
						if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal15'])){
							$points = $points+$achtelfinal_points; 
						}
					}
					
					if($rowUser['achtelfinal16'] != ''){
						if($this->isAchtelfinalTippCorrect($rowUser['achtelfinal16'])){
							$points = $points+$achtelfinal_points; 
						}
					}
					
					if($rowUser['winner'] != '' && ($rowUser['winner'] == $this->winner)){
						$points = $points+$winner_points;
					}
					
					if($rowUser['best'] != '' && ($rowUser['best'] == $this->best)){
						$points = $points+$other_points;
					}
					
					if($rowUser['worst'] != '' && ($rowUser['worst'] == $this->worst)){
						$points = $points+$other_points;
					}
					
					if($rowUser['switzerland'] != '' && ($rowUser['switzerland'] == $this->switzerland)){
						$points = $points+$other_points;
					}
					
					if($rowUser['lastwinner'] != '' && ($rowUser['lastwinner'] == $this->lastwinner)){
						$points = $points+$other_points;
					}
				}
				$abfrage = "Update user set punkte=$points where userid=$userid";
				mysql_query($abfrage);
			}
	}
	
	private function updateRanking(){
		$userids = "SELECT userid, rank_now, punkte FROM user ORDER BY punkte DESC";
		
		$resultUsers = mysql_query($userids);
		
		$temp_points = '';
		$rank_counter = 1;
		$rank_logic= 1;
		while($row = mysql_fetch_assoc($resultUsers))
		{
			$userid = $row['userid'];
			$rank_now = $row['rank_now'];
			
			if($temp_points == '' || $temp_points != $row['punkte']){
				$temp_points = $row['punkte'];
				$rank_logic = $rank_counter;
			}
			
			$ranks = "Update user set rank_now=$rank_logic, rank_last=$rank_now where userid=$userid";
	
			mysql_query($ranks);	

			$rank_counter++;
		}
	}
	
	private function isAchtelfinalTippCorrect($value){
		$tippCorrect = false;
			
		if($this->achtelfinal1 != ''){
			if($this->achtelfinal1 == $value){
				$tippCorrect = true;
				return $tippCorrect;
			}
		}
		if($this->achtelfinal2 != ''){
			if($this->achtelfinal2 == $value){
				$tippCorrect = true;
				return $tippCorrect;
			}
		}
		if($this->achtelfinal3 != ''){
			if($this->achtelfinal3 == $value){
				$tippCorrect = true;
				return $tippCorrect;
			}
		}
		if($this->achtelfinal4 != ''){
			if($this->achtelfinal4 == $value){
				$tippCorrect = true;
				return $tippCorrect;
			}
		}
		if($this->achtelfinal5 != ''){
			if($this->achtelfinal5 == $value){
				$tippCorrect = true;
				return $tippCorrect;
			}
		}
		if($this->achtelfinal6 != ''){
			if($this->achtelfinal6 == $value){
				$tippCorrect = true;
				return $tippCorrect;
			}
		}
		if($this->achtelfinal7 != ''){
			if($this->achtelfinal7 == $value){
				$tippCorrect = true;
				return $tippCorrect;
			}
		}
		if($this->achtelfinal8 != ''){
			if($this->achtelfinal8 == $value){
				$tippCorrect = true;
				return $tippCorrect;
			}
		}
		if($this->achtelfinal9 != ''){
			if($this->achtelfinal9 == $value){
				$tippCorrect = true;
				return $tippCorrect;
			}
		}
		if($this->achtelfinal10 != ''){
			if($this->achtelfinal10 == $value){
				$tippCorrect = true;
				return $tippCorrect;
			}
		}
		if($this->achtelfinal11 != ''){
			if($this->achtelfinal11 == $value){
				$tippCorrect = true;
				return $tippCorrect;
			}
		}
		if($this->achtelfinal12 != ''){
			if($this->achtelfinal12 == $value){
				$tippCorrect = true;
				return $tippCorrect;
			}
		}
		if($this->achtelfinal13 != ''){
			if($this->achtelfinal13 == $value){
				$tippCorrect = true;
				return $tippCorrect;
			}
		}
		if($this->achtelfinal14 != ''){
			if($this->achtelfinal14 == $value){
				$tippCorrect = true;
				return $tippCorrect;
			}
		}
		if($this->achtelfinal15 != ''){
			if($this->achtelfinal15 == $value){
				$tippCorrect = true;
				return $tippCorrect;
			}
		}
		if($this->achtelfinal16 != ''){
			if($this->achtelfinal16 == $value){
				$tippCorrect = true;
				return $tippCorrect;
			}
		}
		return $tippCorrect;			
	}
	
	private function saveNews(){
		$title = $_POST["newsTitle"];
		$text = $_POST["newsText"];
		
		$query = "Insert into news(titel, text) values('".$title."', '".$text."')";
			
		mysql_query($query);
	}
	
	private function getNotTipped(){
		$userQuery = "SELECT userid, email FROM user";
		$resultUser = mysql_query($userQuery);
		
		$i = 0;
		
		while($rowUser = mysql_fetch_assoc($resultUser))
		{
			$user = $rowUser['userid'];
			
			$userweiteretippsquery = "SELECT * FROM userweiteretipps WHERE userfsid = $user";
			$resultUserWeitereTipps = mysql_query($userweiteretippsquery);
			
			$rowWeitereTipps = mysql_fetch_assoc($resultUserWeitereTipps);
			
			if($rowWeitereTipps != false){
				if($rowWeitereTipps['achtelfinal1'] == ''
					|| $rowWeitereTipps['achtelfinal2'] == ''
					|| $rowWeitereTipps['achtelfinal3'] == ''
					|| $rowWeitereTipps['achtelfinal4'] == ''
					|| $rowWeitereTipps['achtelfinal5'] == ''
					|| $rowWeitereTipps['achtelfinal6'] == ''
					|| $rowWeitereTipps['achtelfinal7'] == ''
					|| $rowWeitereTipps['achtelfinal8'] == ''
					|| $rowWeitereTipps['achtelfinal9'] == ''
					|| $rowWeitereTipps['achtelfinal10'] == ''
					|| $rowWeitereTipps['achtelfinal11'] == ''
					|| $rowWeitereTipps['achtelfinal12'] == ''
					|| $rowWeitereTipps['achtelfinal13'] == ''
					|| $rowWeitereTipps['achtelfinal14'] == ''
					|| $rowWeitereTipps['achtelfinal15'] == ''
					|| $rowWeitereTipps['achtelfinal16'] == ''
					|| $rowWeitereTipps['winner'] == ''
					|| $rowWeitereTipps['best'] == ''
					|| $rowWeitereTipps['worst'] == ''
					|| $rowWeitereTipps['switzerland'] == ''
					|| $rowWeitereTipps['lastwinner'] == ''){
						$this->notTipped[$i]['email'] = $rowUser['email'];
						$i++;
				}
			}
			else{
				$this->notTipped[$i]['email'] = $rowUser['email'];
				$i++;
			}
		}
	}
	
	private function getPhases() {
		$abfrage = "SELECT * FROM phase order by phaseid asc";
	
		$ergebnis = mysql_query($abfrage);
	
		$i=0;
		while($row = mysql_fetch_assoc($ergebnis))
		{
			$this->phases[$i]['id'] = $row['phaseid'];
			$this->phases[$i]['beschreibung'] = $row['beschreibung'];
			$i++;
		}
	}
	
	public function getHTML() {
		$this->getNNB();
		$this->getAll();
		$this->getGames();
		$this->getCountries();
		$this->getNotTipped();
		$this->getRealWeitereTipps();
		$this->phases = Constants::getPhases();
		require_once('layout/admin.tpl');
	}
}
?>