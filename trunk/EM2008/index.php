<?php
include_once('Layout/header.tpl');
include_once('Home/Home.php');
include_once('Login/Login.php');
require_once('Rules/Rules.php');
require_once('Register/Register.php');
require_once('Ranking/Ranking.php');
require_once('MyTipps/MyTipps.php');
require_once('OtherTipps/OtherTipps.php');

//unset($_SESSION['eingeloggt']);
//unset($_SESSION['infos']);

$go = $_GET['go'];
$login = new Login();

switch($go) {
	case 'home':
		$home = new Home();
		$home->getView();
		break;
	case 'rules':
		$rules = new Rules();
		$rules->getView();
		break;
	case 'login':
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

include('Layout/footer.tpl')
?>