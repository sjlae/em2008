<?php

class Constants{
	public static $isWM = true;
	public static $winnerLabel = 'Weltmeister';
	
	public static $regexSpecialSigns_Names = '/[<>\._\-&!?=#@^`\'()\{\}\[\]\$£!*%\/¨,`"\s\\\]+/';
	public static $regexSpecialSigns_Guestbook = '/[<>&\'"\\\]+/';
	
	public static function getWinnerLabel(){
		if(Constants::$isWM != true){
			Constants::$winnerLabel = 'Europameister';
		}
		return Constants::$winnerLabel;
	}
}

?>