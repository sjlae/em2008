<ul id="menu">
	<li class="Startseite" id="mn_Standard"><a href="index.php?go=home"><span>Startseite</span></a></li>
	<li class="Startseite" id="mn_Standard"><a href="index.php?go=myTipps"><span>Tipps erfassen</span></a></li>
	<li class="Startseite" id="mn_Standard"><a href="index.php?go=otherTipps"><span>Tipps Mitspieler</span></a></li>
	<li class="Startseite" id="mn_Standard"><a href="index.php?go=ranking"><span>Rangliste</span></a></li>
	<li class="Startseite" id="mn_Standard"><a href="index.php?go=statistics"><span>Statistiken</span></a></li>
	<li class="Startseite" id="mn_Standard"><a href="index.php?go=guestbook"><span>G&auml;stebuch</span></a></li>
	<li class="Startseite" id="mn_Standard"><a href="index.php?go=rules"><span>Spielregeln</span></a></li>
	<?php
		$abfrage = "SELECT * FROM user where userid='".$_SESSION['userid']."'";

		$ergebnis = mysql_query($abfrage);
		
		while($row = mysql_fetch_assoc($ergebnis))
		{
			if($row['admin'] == '1'){
	?>
				<li class="Startseite" id="mn_Standard"><a href="index.php?go=admin"><span>Admin</span></a></li>
	<?php
			}
		}		
	?>
	<li class="Startseite" id="mn_Standard"><a href="index.php?go=logout"><span>Logout</span></a></li>
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