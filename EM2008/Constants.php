<?php

class Constants{
	public static $isWM = true;
	public static $winnerLabel = 'Weltmeister';
	
	public static function getWinnerLabel(){
		if(Constants::$isWM != true){
			Constants::$winnerLabel = 'Europameister';
		}
		return Constants::$winnerLabel;
	}
}

?>