<?php
require_once('Page.php');
require_once('Home/Home.php');
require_once('Datenbank/db.php');

class Home extends HTMLPage implements Page{
	
	private $news = array();
	
	public function __construct() {
		$this->getNews();
	}
	
	private function getNews(){
		$abfrage = "SELECT * FROM News order by datum desc";

		$ergebnis = mysql_query($abfrage);
		$counter = 0;
		while($row = mysql_fetch_assoc($ergebnis))
		{
			$this->news[$counter]['date'] = date('d.m.Y H:i', strtotime($row['datum']));
			$this->news[$counter]['title'] = $row['titel'];
			$this->news[$counter]['text'] = $row['text'];
			$counter++;
		}
	}
	
	public function getHTML() {
		include('layout/home.tpl');
	}
}

?>