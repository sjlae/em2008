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
}

?>