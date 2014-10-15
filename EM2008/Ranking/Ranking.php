<?php
require_once("Page.php");
require_once('Datenbank/db.php');

class Ranking extends HTMLPage implements Page {
	
	private $link = '';
	private $gruppen = array();
	private $currentUsers = array();
	private $rankingArray = array();
	private $currentPlace = '';
	private $gruppe = '';
	private $gruppeid;
	private $action;
	private $gruppenname;
	private $errors = array();
	
	public function __construct() {
		$this->link = Db::getConnection();
	}

	public function init() {
		$this->action = isset($_GET['action']) ? $_GET['action'] : '';
		$this->gruppe = isset($_POST['gruppe']) ? $_POST['gruppe'] : '';
		
		if($this->action == "gruppenfilter" & $this->gruppe != 'Alle') {
			$this->gruppenfilter();
			return true;
		}
		
		if($this->action == "addmodify") {
			$this->addmodify($_GET['gruppeid']);
			return true;
		}
		
		if($this->action == "savegroup") {
			$this->savegroup();
			return true;
		}
		
		if($this->action == "deletegroup") {
			$this->deletegroup();
			return true;
		}

		$this->getFullRanking();
		
		return true;
	}
	
	public function addmodify($gruppeid) {
		if(isset($gruppeid) && $gruppeid != ''){
			$this->gruppeid = $gruppeid;
			$query = mysql_query("SELECT name FROM gruppe where gruppeid = '$this->gruppeid'");
			$result = mysql_fetch_assoc($query);
			$this->gruppenname = $result['name'];
			
			$abfrage = "SELECT userfsid FROM gruppeuser where gruppefsid = '$this->gruppeid'";
			$ergebnis = mysql_query($abfrage);
			
			if($ergebnis != null){
				$counter = 1;
				while($row = mysql_fetch_assoc($ergebnis))
				{
					$this->currentUsers[$counter]= $row['userfsid'];
					
					$counter++;
				}
			}
		}
		
		$abfrage = "SELECT userid, vorname, nachname FROM user ORDER BY nachname ASC";
		
		$ergebnis = mysql_query($abfrage);
		
		if($ergebnis != null){
			$counter = 0;
			while($row = mysql_fetch_assoc($ergebnis))
			{
				$this->rankingArray[$counter]['userid'] = $row['userid'];
				$this->rankingArray[$counter]['vorname'] = $row['vorname'];
				$this->rankingArray[$counter]['nachname'] = $row['nachname'];
		
				$counter++;
			}
		}
	}
	
	public function deletegroup() {
		if(isset($_GET['gruppeid'])){
			$gruppeid = $_GET['gruppeid'];			
			
			mysql_query("Delete from gruppeuser where gruppefsid = '$gruppeid'");
			mysql_query("Delete from gruppe where gruppeid = '$gruppeid'");
		}
		
		$_SESSION['infos'][] = "Die Gruppe wurde erfolgreich gelöscht.";
		
		header('location:	index.php?go=ranking');
		return false;
	}
	
	public function savegroup() {
		$this->gruppenname = htmlentities(trim($_POST["gruppenname"]), ENT_QUOTES, 'UTF-8');
		
		// Validations
		if($this->checkExistingName($this->gruppenname)) {
			$this->errors[] = "Dieser Gruppenname ($this->gruppenname) ist bereits vorhanden.";
		}
			
		if(count($_POST['users_group']) == 0){
			$this->errors[] = "Es muss mindestens 1 Teilnehmer der Gruppe zugewiesen werden.";
		}
			
		if($this->gruppenname == ''){
			$this->errors[] = "Es muss ein Gruppenname erfasst werden.";
		}
			
		if(count($this->errors) > 0) {
			$this->addmodify($_POST['gruppeid']);
			return true;
		}
			
		if(isset($_POST['gruppeid'])){
			$gruppeid = $_POST['gruppeid'];
				
			mysql_query("Delete from gruppeuser where gruppefsid = '$gruppeid'");
			mysql_query("Delete from gruppe where gruppeid = '$gruppeid'");
		}
		
		$query = "Insert into gruppe (name) values('".$this->gruppenname."')";
		mysql_query($query);
		
		$query = mysql_query("SELECT gruppeid FROM gruppe where name = '$this->gruppenname'");
		$result = mysql_fetch_assoc($query);
		
		if(isset($_POST['users_group'])){
			foreach($_POST['users_group'] as $user_id){
				$abfrage = "Insert into gruppeuser (gruppefsid, userfsid) values('".$result['gruppeid']."', '".$user_id."')";
				mysql_query($abfrage);
			}
		}
		
		$_SESSION['infos'][] = "Die Gruppe wurde erfolgreich gespeichert";
		
		header('location:	index.php?go=ranking');
		return false;
	}
	
	public function checkExistingName($gruppenname) {
		if(isset($_POST['gruppeid'])){
			$gruppeid = $_POST['gruppeid'];
			$query = mysql_query("SELECT name FROM gruppe where gruppeid = '$gruppeid'");
			$result = mysql_fetch_assoc($query);
			if($gruppenname == $result['name']){
				return false;
			}
		}
		
		$abfrage = sprintf("SELECT * FROM gruppe where name='$gruppenname'");
	
		$result = mysql_query($abfrage);
	
		while($row = mysql_fetch_assoc($result))
		{
			return true;
		}
		return false;
	}
	
	public function gruppenfilter() {
		$this->gruppe = isset($_POST['gruppe']) ? $_POST['gruppe'] : '';
		
		$abfrage = "SELECT
   						a.userid, a.vorname, a.nachname, a.punkte, a.bezahlt, a.rank_last, a.rank_now
					FROM
   						user as a,
   						gruppe as b,
   						gruppeuser as c
					WHERE
   						a.userid = c.userfsid AND b.gruppeid = c.gruppefsid
   						AND b.gruppeid ='$this->gruppe' 
					ORDER BY punkte DESC, a.nachname ";
		
		$ergebnis = mysql_query($abfrage);
		
		if($ergebnis != null){
			$counter = 0;
			while($row = mysql_fetch_assoc($ergebnis))
			{
				$this->rankingArray[$counter]['userid'] = $row['userid'];
				$this->rankingArray[$counter]['vorname'] = $row['vorname'];
				$this->rankingArray[$counter]['nachname'] = $row['nachname'];
				$this->rankingArray[$counter]['punkte'] = $row['punkte'];
				$this->rankingArray[$counter]['bezahlt'] = $row['bezahlt'];
				$this->rankingArray[$counter]['last'] = $row['rank_last'];
				$this->rankingArray[$counter]['now'] = $row['rank_now'];
		
				if($_SESSION['eingeloggt']){
					if($_SESSION['userid'] == $this->rankingArray[$counter]['userid']){
						$this->currentPlace = $this->rankingArray[$counter]['now'];
					}
				}
		
				$counter++;
			}
		}
	}
	
	public function getFullRanking() {
		$abfrage = "SELECT userid, vorname, nachname, punkte, bezahlt, rank_last, rank_now FROM user ORDER BY punkte DESC, nachname";

		$ergebnis = mysql_query($abfrage);
		
		if($ergebnis != null){
			$counter = 0;
			while($row = mysql_fetch_assoc($ergebnis))
			{
				$this->rankingArray[$counter]['userid'] = $row['userid'];
				$this->rankingArray[$counter]['vorname'] = $row['vorname'];
				$this->rankingArray[$counter]['nachname'] = $row['nachname'];
				$this->rankingArray[$counter]['punkte'] = $row['punkte'];
				$this->rankingArray[$counter]['bezahlt'] = $row['bezahlt'];
				$this->rankingArray[$counter]['last'] = $row['rank_last'];
				$this->rankingArray[$counter]['now'] = $row['rank_now'];
				
				$loged_in = isset($_SESSION['eingeloggt']) ? true : false;
				
				if($loged_in){
					if($_SESSION['userid'] == $this->rankingArray[$counter]['userid']){
						$this->currentPlace = $this->rankingArray[$counter]['now'];
					}
				}
				
				$counter++;
			}
		}
	}
	
	public function getHTML() {
		if($this->action == "addmodify" || $this->action == "savegroup") {
			include('layout/addmodify.tpl');
		}
		
		else{
			$count = "SELECT COUNT(*) FROM user";
			$countPlayers = mysql_query($count);
			
			$countNotPayed = "SELECT COUNT(*) FROM user WHERE bezahlt = 0";
			$countPlayersNotPayed = mysql_query($countNotPayed);
			
			$userid = isset($_SESSION['userid']) ? $_SESSION['userid'] : '';
			$abfrage = "SELECT
						a.gruppeid, a.name
						FROM
						gruppe as a,
						gruppeuser as b
					WHERE
						a.gruppeid = b.gruppefsid and b.userfsid = '$userid'
					ORDER BY a.name ASC";
			
			$ergebnis = mysql_query($abfrage);
			if($ergebnis != null){
				$counter = 0;
	
				while($row = mysql_fetch_assoc($ergebnis))
				{
					$this->gruppen[$counter]['name'] = $row['name'];
					$this->gruppen[$counter]['gruppeid'] = $row['gruppeid'];
	
					$counter++;
				}
			}
			include('layout/ranking.tpl');
		}
	}
}
?>