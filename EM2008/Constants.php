<?php
require_once('Datenbank/db.php');

class Constants{
	public static $isWM = true;
	public static $winnerLabel = 'Weltmeister';
	 
	public static $regexSpecialSigns = '/[<>&\'"\\\]+/';
	
	public static function hasSpecialSigns($value){
		return preg_match(Constants::$regexSpecialSigns, $value);
	}
	
	public static function getWinnerLabel(){
		if(Constants::$isWM != true){
			Constants::$winnerLabel = 'Europameister';
		}
		return Constants::$winnerLabel;
	}
	
	public static function isLocal(){
		if($_SERVER[HTTP_HOST] == "localhost"){
			return true;
		}
		return false;
	}
	
	public static function getPointsPng($tipp1, $tipp2, $real1, $real2, $highrisk){
		if($real1 != '' && $real2 != '' && $tipp1 != '' && $tipp2 != '' && $tipp1>=0 && $tipp2>=0 && is_numeric($tipp1) && is_numeric($tipp2)){
			$points;
			
			// punktevergabe für highrisk
			if($highrisk == '1'){
				if($real1 == $tipp1 && $real2 == $tipp2){
					return "16";
				}
				else{
					return "0";
				}
			}
			
			// 4 Punkte für korrekten Ausgang & 2 Punkt für korrekte Differenz
			if(($real1>$real2 && $tipp1>$tipp2) || ($real2>$real1 && $tipp2>$tipp1) || ($real1==$real2 && $tipp1==$tipp2)){
				$points = $points+4;
				if(($real1-$real2 == $tipp1-$tipp2) || ($real2-$real1 == $tipp2-$tipp1) || ($real1==$real2 && $tipp1==$tipp2)){
					$points = $points+2;
				}
			}
			// je 1 Punkt für korrekte Anzahl Tore der beiden Teams
			if($tipp1==$real1){
				$points = $points+1;
			}
			if($tipp2==$real2){
				$points = $points+1;
			}
			
			if($points == 8){
				return "8";
			}
			else if($points == 6){
				return "6";
			}
			else if($points == 5){
				return "5";
			}
			else if($points == 4){
				return "4";
			}
			else if($points == 1){
				return "1";
			}
			else if($points == 0){
				return "0";
			}
		}
	}
	
	public function hasTournamentStarted() {
		$abfrage = "SELECT start FROM vorrundeteams where vorrundeteamsid=1";
	
		$ergebnis = mysql_query($abfrage);
		$startTime = mysql_fetch_row($ergebnis);
		if(mktime() > strtotime($startTime[0])){
			return true;
		}
		else{
			return false;
		}
	}
	
	public function isAlreadyFinalround(){
		$relevantRow = (Constants::$isWM ? 49 : 37);
	
		$result = mysql_query("Select * from vorrundeteams WHERE vorrundeteamsid = $relevantRow");
		$dbRow = mysql_fetch_row($result);
	
		if($dbRow[4] != '' && $dbRow[5] != ''){
			return "Finalspiele";
		}
		return "Gruppenspiele";
	}
	
	public function getPhases() {
		$abfrage = "SELECT * FROM phase order by phaseid asc";
	
		$ergebnis = mysql_query($abfrage);
		
		$phases = array();
		$i=0;
		while($row = mysql_fetch_assoc($ergebnis))
		{
			$phases[$i]['id'] = $row['phaseid'];
			$phases[$i]['beschreibung'] = $row['beschreibung'];
			$i++;
		}
		return $phases;
	}
}

?>