<?php
require_once("Page.php");
require_once('Datenbank/db.php');
require_once('Constants.php');

class StatisticsDetail extends HTMLPage implements Page {

	private $link = '';
	private $result;
	private $action;
	private $id;
	private $tipps = array();
	private $filter = array();
	private $filterResult;
	private $team1;
	private $team2;
	
	public function __construct() {
		if(isset($_GET['result']) && isset($_GET['id'])){
			$this->link = Db::getConnection();
			$this->result = isset($_GET['result']) ? $_GET['result'] : '';
			$this->id = isset($_GET['id']) ? $_GET['id'] : '';
			$this->action = isset($_GET['action']) ? $_GET['action'] : '';
			$this->sort = isset($_POST['sort']) ? $_POST['sort'] : '';
			$this->filterResult = isset($_POST['filterResult']) ? $_POST['filterResult'] : '';
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
				$this->team1 =  $this->team1 != null ? $this->team1 : $row_game['team1fsid'];
				$this->team2 =  $this->team2 != null ? $this->team2 : $row_game['team2fsid'];
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
					$search = $row_result['result1'].':'.$row_result['result2'];
						
					if(!in_array($search, $this->filter)){
						$this->filter[] = $search;
					}
					
					if($this->filterResult == 'Alle' || $this->filterResult == '' || $this->filterResult == $search){
						$userid = $this->getUserId($row_result['vorrundeid']);
							
						$abfrage_user = "SELECT * FROM user WHERE userid = ".$userid;
						$ergebnis_user = mysql_query($abfrage_user);
						while($row_user = mysql_fetch_assoc($ergebnis_user))
						{
							$this->tipps[$i]['nachname'] = $row_user['nachname'];
							$this->tipps[$i]['vorname'] = $row_user['vorname'];
							$this->tipps[$i]['rank_now'] = $row_user['rank_now'];
						}
						$this->tipps[$i]['result1'] = $row_result['result1'];
						$this->tipps[$i]['result2'] = $row_result['result2'];
						$this->tipps[$i]['userid']  = $userid;
					}
					
					$i++;
				}
			}
			asort($this->filter);
			if($this->action == 'sort' && $this->sort == 'Rang') {
				$sortArray = array();
				foreach($this->tipps as $key => $array) {
					$sortArray[$key] = $array['rank_now'];
				}
				
				array_multisort($sortArray, SORT_ASC, SORT_NUMERIC, $this->tipps);
			}
			else{
				asort($this->tipps);
			}
		}
	}
	
	private function getTeam($id) {
		if($id != ''){
			$abfrage = "SELECT * FROM teams where teamid=".$id;

			$ergebnis = mysql_query($abfrage);
			if($ergebnis != null){
				while($row = mysql_fetch_assoc($ergebnis))
				{
					return $row['land'];
				}
			}
			return null;
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