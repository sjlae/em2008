<?php
require_once("Page.php");
require_once('Datenbank/db.php');
require_once('Constants.php');

class StatisticsDetail extends HTMLPage implements Page {

	private $link = '';
	private $result;
	private $id;
	private $tipps = array();
	private $team1;
	private $team2;
	
	public function __construct() {
		if(isset($_GET['result']) && isset($_GET['id'])){
			$this->link = Db::getConnection();
			$this->result = isset($_GET['result']) ? $_GET['result'] : '';
			$this->id = isset($_GET['id']) ? $_GET['id'] : '';
			$this->getData();
		}
	}

	private function getData() {
		$abfrage_game = "SELECT * FROM vorrundeteams WHERE vorrundeteamsid = ".$this->id;
		$ergebnis_game = mysql_query($abfrage_game);
		
		if($ergebnis_game != null){
		
			while($row_game = mysql_fetch_assoc($ergebnis_game))
			{
				$this->team1 =  $this->getTeam($row_game['team1fsid']);
				$this->team2 =  $this->getTeam($row_game['team2fsid']);
			}
			
			$sql_query = "result1 > result2";
			
			if($this->result == 1){
				$sql_query = "result1 > result2";
			}
			else if($this->result == X){
				$sql_query = "result1 = result2";
			}
			else if($this->result == 2){
				$sql_query = "result1 < result2";
			}
			
			$abfrage_result = "SELECT * FROM vorrunde WHERE ".$sql_query." AND vorrundeteamsfsid = ".$this->id;
			$ergebnis_result = mysql_query($abfrage_result);
			$i = 0;
			while($row_result = mysql_fetch_assoc($ergebnis_result))
			{
				if($row_result['result1'] != '' || $row_result['result2'] != ''){
					$userid = $this->getUserId($row_result['vorrundeid']);
					
					$abfrage_user = "SELECT * FROM user WHERE userid = ".$userid;
					$ergebnis_user = mysql_query($abfrage_user);
					while($row_user = mysql_fetch_assoc($ergebnis_user))
					{
						$this->tipps[$i]['nachname'] = $row_user['nachname'];
						$this->tipps[$i]['vorname'] = $row_user['vorname'];
					}
					$this->tipps[$i]['result1'] = $row_result['result1'];
					$this->tipps[$i]['result2'] = $row_result['result2'];
					$this->tipps[$i]['userid']  = $userid;
					
					$i++;
				}
			}
			asort($this->tipps);
		}
	}
	
	private function getTeam($id) {
		if($id != ''){
			$abfrage = "SELECT * FROM teams where teamid=".$id;

			$ergebnis = mysql_query($abfrage);
			while($row = mysql_fetch_assoc($ergebnis))
			{
				return $row['land'];
			}
		}
	}
	
	private function getUserId($id) {
		if($id != ''){
			$abfrage = "SELECT * FROM uservorrunde where vorrundefsid=".$id;

			$ergebnis = mysql_query($abfrage);
			while($row = mysql_fetch_assoc($ergebnis))
			{
				return $row['userfsid'];
			}
		}
	}
	
	public function getHTML() {
		include('layout/groups.tpl');
	}
}
?>