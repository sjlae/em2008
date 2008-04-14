<?php
session_start();

include_once('Home/Home.php');
include_once('Login/Login.php');
require_once('Rules/Rules.php');
require_once('Register/Register.php');
require_once('Ranking/Ranking.php');
require_once('MyTipps/MyTipps.php');
require_once('OtherTipps/OtherTipps.php');


//unset($_SESSION['eingeloggt']);
//unset($_SESSION['infos']);

$go = isset($_GET['go']) ? $_GET['go'] : '';

switch($go) {
	case 'rules':
		$rules = new Rules();
		$rules->getView();
		break;
	case 'login':
		$login = new Login();
		$login->getView();
		break;
	case 'register':
		$register = new Register();
		$register->getView();
		break;
	case 'ranking':
		$ranking = new Ranking();
		$ranking->getView();
		break;
	case 'myTipps':
		$myTipps = new MyTipps();
		$myTipps->getView();
		break;
	case 'otherTipps':
		$otherTipps = new OtherTipps();
		$otherTipps->getView();
		break;
	default:
		$home = new Home();
		$home->getView();
}

?>