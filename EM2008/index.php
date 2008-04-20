<?php
session_start();

require_once('Home/Home.php');
require_once('Login/Login.php');
require_once('Login/LoggedIn.php');
require_once('Rules/Rules.php');
require_once('Register/Register.php');
require_once('Ranking/Ranking.php');
require_once('MyTipps/MyTipps.php');
require_once('OtherTipps/OtherTipps.php');
require_once('Admin/Admin.php');


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
		LoggedIn::isRegistered($myTipps);
		break;
	case 'otherTipps':
		$otherTipps = new OtherTipps();
		LoggedIn::isRegistered($otherTipps);
		break;
	case 'admin':
		$admin = new Admin();
		LoggedIn::isAdmin($admin);
		break;
	default:
		$home = new Home();
		$home->getView();
}

?>