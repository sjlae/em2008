<ul id="menu">
	<li class="startseite" id="mn_Startseite"><a href="index.php?go=home"><span>Startseite</span></a></li>
	<li class="zwischenstand" id="mn_zwischenstand"><a href="index.php?go=myTipps"><span>Tipps erfassen</span></a></li>
	<li class="zwischenstand" id="mn_zwischenstand"><a href="index.php?go=otherTipps"><span>Tipps Mitspieler</span></a></li>
	<li class="overview" id="mn_Overview"><a href="index.php?go=rules"><span>Spielregeln</span></a></li>
	<li class="overview" id="mn_Overview"><a href="index.php?go=ranking"><span>Rangliste</span></a></li>
	<?php
		$abfrage = "SELECT * FROM User where userid='".$_SESSION['userid']."'";

		$ergebnis = mysql_query($abfrage);
		
		while($row = mysql_fetch_assoc($ergebnis))
		{
			if($row['admin'] == '1'){
	?>
				<li class="overview" id="mn_admin"><a href="index.php?go=admin"><span>Admin</span></a></li>
	<?php
			}
		}		
	?>
	<li class="overview" id="mn_Overview"><a href="index.php?go=logout"><span>Logout</span></a></li>
</ul>		