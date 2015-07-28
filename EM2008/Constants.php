<?php

class Constants{
	public static $isWM = false;
	public static $winnerLabel = 'Europameister';
	 
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
		if($real1 != '' && $real2 != '' && $tipp1 != '' && $tipp2 != '' && $tipp1>=0 && $tipp2>=0 && is_numeric($tipp1) && is_numeric($tipp2)){
        	if ($tipp1==$real1 && $tipp2==$real2) { 
            	return "gold.png"; // 5
            } 
            else if ($real1>$real2 && $tipp1>$tipp2) { 
                if ($real1-$real2 == $tipp1-$tipp2) { 
                	return "silver.png"; // 4
                } 
                else { 
                	return "bronce.png"; // 3
                } 
           	} 
            else if ($real2>$real1 && $tipp2>$tipp1) { 
            	if ($real2-$real1 == $tipp2-$tipp1) { 
                	return "silver.png"; // 4
                } 
            	else { 
            		return "bronce.png"; // 3
            	}                                                    
        	} 
        	else if ($real1==$real2 && $tipp1==$tipp2) { 
        		return "silver.png"; // 4
        	}
        	
        	return "white.png"; // 0
		}
		else{
			return ""; // etwas leer
		}
	}
}

?>