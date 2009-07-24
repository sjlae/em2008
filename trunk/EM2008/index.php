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
require_once('Statistics/Statistics.php');
require_once('Guestbook/Guestbook.php');
require_once('Admin/Admin.php');

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
	case 'statistics':
		$statistics = new Statistics();
		LoggedIn::isRegistered($statistics);
		break;
	case 'guestbook':
		$guestbook = new Guestbook();
		LoggedIn::isRegistered($guestbook);
		break;
	case 'admin':
		$admin = new Admin();
		LoggedIn::isAdmin($admin);
		break;
	case 'logout':
		unset($_SESSION['eingeloggt']);
		unset($_SESSION['userid']);
		$_SESSION['infos'][] = "Sie haben erfolgreich ausgeloggt";
		$home = new Home();
		$home->getView();
		break;
	default:
		$home = new Home();
		$home->getView();
}

?>