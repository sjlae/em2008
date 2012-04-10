<ul id="menu">
	<li class="Startseite" id="mn_Standard"><a href="index.php?go=home"><span>Startseite</span></a></li>
	<li class="Startseite" id="mn_Standard"><a href="index.php?go=ranking"><span>Rangliste</span></a></li>
	<li class="Startseite" id="mn_Standard"><a href="index.php?go=login"><span>Login</span></a></li>
  <li class="Startseite" id="mn_Standard"><a href="index.php?go=register"><span>Registrieren</span></a></li> 
	<li class="Startseite" id="mn_Standard"><a href="index.php?go=rules"><span>Spielregeln</span></a></li>
	<?php
		if(isset($_SESSION['users_names'])){
	?>
			<li class="Startseite" id="mn_Standard"><a class="tooltip" href="#"><?php echo $_SESSION['users'] ?><span><?php echo $_SESSION['users_names'] ?></span></a></li>
	<?php
		}
		else{
	?>
			<li class="Startseite" id="mn_Standard"><a class="tooltip" href="#"><?php echo $_SESSION['users'] ?></a></li>
	<?php
		}
	?>
</ul>
<?php 
	unset($_SESSION['users']);
	unset($_SESSION['users_names']);
?>