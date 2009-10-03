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
	
	public static function getTippColor($tipp1, $tipp2, $real1, $real2){
		if($real1 != '' && $real2 != '' && $tipp1 != '' && $tipp2 != '' && $tipp1>=0 && $tipp2>=0 && is_numeric($tipp1) && is_numeric($tipp2)){
        	if ($tipp1==$real1 && $tipp2==$real2) { 
            	return "#006600"; // 5
            } 
            else if ($real1>$real2 && $tipp1>$tipp2) { 
                if ($real1-$real2 == $tipp1-$tipp2) { 
                	return "#3300CC"; // 4
                } 
                else { 
                	return "#FF9900"; // 3
                } 
           	} 
            else if ($real2>$real1 && $tipp2>$tipp1) { 
            	if ($real2-$real1 == $tipp2-$tipp1) { 
                	return "#3300CC"; // 4
                } 
            	else { 
            		return "#FF9900"; // 3
            	}                                                    
        	} 
        	else if ($real1==$real2 && $tipp1==$tipp2) { 
        		return "#3300CC"; // 4
        	}
        	
        	return "#000000"; // 0
		}
		else{
			return "#000000"; // etwas leer
		}
	}
}

?>