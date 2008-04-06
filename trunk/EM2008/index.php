<?php
include_once('Layout/header.tpl');
include_once('Home/Home.php');
include_once('Login/Login.php');
require_once('Regeln/Regeln.php');

$go = $_GET['go'];

$login = new Login();

switch($go) {
	case 'home':
		$home = new Home();
		$login->checkLogin($home);
		break;
	case 'regeln':
		$regeln = new Regeln();
		$regeln->getView();
		break;
	default:
		$home = new Home();
		$home->getView();
}

include('Layout/footer.tpl')
?>