<?php
require_once('Page.php');
require_once('Home/Home.php');
require_once('Datenbank/db.php');

class Admin extends HTMLPage implements Page{

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
			$this->setHauptrundenTeams();
			$this->updateUserPoints();
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
		$abfrage = "Update Realhauptrunde set viertelfinal1=$viertelfinal1";
		mysql_query($abfrage);
		
		$viertelfinal2 = $_POST["viertelfinal2"];
		$abfrage = "Update Realhauptrunde set viertelfinal2=$viertelfinal2";
		mysql_query($abfrage);
		
		$viertelfinal3 = $_POST["viertelfinal3"];
		$abfrage = "Update Realhauptrunde set viertelfinal3=$viertelfinal3";
		mysql_query($abfrage);
		
		$viertelfinal4 = $_POST["viertelfinal4"];
		$abfrage = "Update Realhauptrunde set viertelfinal4=$viertelfinal4";
		mysql_query($abfrage);
		
		$viertelfinal5 = $_POST["viertelfinal5"];
		$abfrage = "Update Realhauptrunde set viertelfinal5=$viertelfinal5";
		mysql_query($abfrage);
		
		$viertelfinal6 = $_POST["viertelfinal6"];
		$abfrage = "Update Realhauptrunde set viertelfinal6=$viertelfinal6";
		mysql_query($abfrage);
		
		$viertelfinal7 = $_POST["viertelfinal7"];
		$abfrage = "Update Realhauptrunde set viertelfinal7=$viertelfinal7";
		mysql_query($abfrage);
		
		$viertelfinal8 = $_POST["viertelfinal8"];
		$abfrage = "Update Realhauptrunde set viertelfinal8=$viertelfinal8";
		mysql_query($abfrage);
		
		$halbfinal1 = $_POST["halbfinal1"];
		$abfrage = "Update Realhauptrunde set halbfinal1=$halbfinal1";
		mysql_query($abfrage);
		
		$halbfinal2 = $_POST["halbfinal2"];
		$abfrage = "Update Realhauptrunde set halbfinal2=$halbfinal2";
		mysql_query($abfrage);
		
		$halbfinal3 = $_POST["halbfinal3"];
		$abfrage = "Update Realhauptrunde set halbfinal3=$halbfinal3";
		mysql_query($abfrage);
		
		$halbfinal4 = $_POST["halbfinal4"];
		$abfrage = "Update Realhauptrunde set halbfinal4=$halbfinal4";
		mysql_query($abfrage);
		
		$final1 = $_POST["final1"];
		$abfrage = "Update Realhauptrunde set final1=$final1";
		mysql_query($abfrage);
		
		$final2 = $_POST["final2"];
		$abfrage = "Update Realhauptrunde set final2=$final2";
		mysql_query($abfrage);
		
		$europameister = $_POST["europameister"];
		$abfrage = "Update Realhauptrunde set europameister=$europameister";
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

							if($real1 != '' && $real2 != ''){
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
				
				$abfrage = "Update User set punkte=$points where userid=$userid";
				mysql_query($abfrage);
				
			}
		return $results;
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