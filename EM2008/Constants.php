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
	    if($_SERVER['REMOTE_ADDR'] == '127.0.0.1'){
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
					return "16_punkte.png";
				}
				else{
					return "0_punkte.png";
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
				return "8_punkte.png";
			}
			else if($points == 6){
				return "6_punkte.png";
			}
			else if($points == 5){
				return "5_punkte.png";
			}
			else if($points == 4){
				return "4_punkte.png";
			}
			else if($points == 1){
				return "1_punkt.png";
			}
			else if($points == 0){
				return "0_punkte.png";
			}
		}
		return "0_punkte.png";
	}
	
	public static function hasTournamentStarted() {
		$abfrage = "SELECT start FROM vorrundeteams where vorrundeteamsid=1";
	
		$ergebnis = mysqli_query(Db::getConnection(), $abfrage);
		$startTime = mysqli_fetch_row($ergebnis);
		if(time() > strtotime($startTime[0])){
			return true;
		}
		else{
			return false;
		}
	}
	
	public static function isAlreadyFinalround(){
		$relevantRow = (Constants::$isWM ? 49 : 37);
	
		$result = mysqli_query(Db::getConnection(), "Select * from vorrundeteams WHERE vorrundeteamsid = $relevantRow");
		$dbRow = mysqli_fetch_row($result);
	
		if($dbRow[4] != '' && $dbRow[5] != ''){
			return "Finalspiele";
		}
		return "Gruppenspiele";
	}
	
	public static function getPhases() {
		$abfrage = "SELECT * FROM phase order by phaseid asc";
	
		$ergebnis = mysqli_query(Db::getConnection(), $abfrage);
		
		$phases = array();
		$i=0;
		while($row = mysqli_fetch_assoc($ergebnis))
		{
			$phases[$i]['id'] = $row['phaseid'];
			$phases[$i]['beschreibung'] = $row['beschreibung'];
			$i++;
		}
		return $phases;
	}
}

?>