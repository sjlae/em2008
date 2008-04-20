<?php
require_once('Page.php');
require_once('Home/Home.php');
require_once('Datenbank/db.php');

class Admin extends HTMLPage implements Page{

	private $nnb = array();

	public function __construct() {
		$action = isset($_GET['action']) ? $_GET['action'] : '';

		if($action == 'nnb') {
			$this->setPayFlag();
		}
	}

	private function setPayFlag() {
		echo $_POST['maxUser'];
		echo "blbla"+$_POST['user0'];
		for($i=0; $i<=$_POST['maxUser']; $i++) {
			echo "t1t";
			
			if($_POST['user'+$i] != '') {
				echo "t2t";
				$userid = $_POST['user'+$i];

				$abfrage = "Update User set bezahlt=1 where userid="+$userid;
				mysql_query($abfrage);

			}
		}
	}

	private function getNNB() {
		$abfrage = "SELECT * FROM User where bezahlt=0";

		$ergebnis = mysql_query($abfrage);
		$counter = 0;
		if(isset($ergebnis) && $ergebnis != null) {
			while($row = mysql_fetch_assoc($ergebnis))
			{
				$this->nnb[$counter]['userid'] = $row['userid'];
				$this->nnb[$counter]['nachname'] = $row['nachname'];
				$this->nnb[$counter]['vorname'] = $row['vorname'];
				$this->nnb[$counter]['email'] = $row['email'];
					
				$counter++;
			}
		}
	}

	public function getHTML() {
		$this->getNNB();
		require_once('layout/admin.tpl');
	}
}
?>