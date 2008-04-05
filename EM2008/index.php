<?php
include_once('Layout/header.tpl');
include_once('Home/Home.php');
include_once('Login/Login.php');

$go = $_GET['go'];

$login = new Login();

switch($go) {
	case 'home':
		$home = new Home();
		$login->checkLogin($home);
		break;
	default:
		$home = new Home();
		$home->getView();
}

include('Layout/footer.tpl')
?>