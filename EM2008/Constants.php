<?php

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
	
	public static function getPointsPng($tipp1, $tipp2, $real1, $real2){
		$points;
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

?>