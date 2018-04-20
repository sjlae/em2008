<!-- mainmenu-->
<nav class="mainmenu">
    <div class="container">
        <!-- Menu-->
        <ul class="sf-menu" id="menu">
            <li class="current">
                <a href="index.php?go=home">Startseite</a>
            </li>
            <li class="current">
                <a href="index.php?go=myTipps">Tipps erfassen</a>
            </li>
            <li class="current">
                <a href="index.php?go=otherTipps">Tipps Mitspieler</a>
            </li>
            <li class="current">
                <a href="index.php?go=ranking">Rangliste</a>
            </li>
            <li class="current">
                <a href="index.php?go=statistics">Statistiken</a>
            </li>
            <li class="current">
                <a href="index.php?go=guestbook">Gästebuch</a>
            </li>
            <li class="current">
                <a href="index.php?go=rules">Spielregeln</a>
            </li>
            <?php
		$abfrage = "SELECT * FROM user where userid='".$_SESSION['userid']."'";

            $ergebnis = mysql_query($abfrage);

            while($row = mysql_fetch_assoc($ergebnis))
            {
            if($row['admin'] == '1'){
            ?>
            <li class="current">
                <a href="index.php?go=admin">Admin</a>
            </li>
            <?php
			}
		}
	?>
            <li class="current">
                <a href="index.php?go=changePassword">Passwort &auml;ndern</a>
            </li>
            <li class="current">
                <a href="index.php?go=logout">Logout</a>
            </li>
        </ul>
        <!-- End Menu-->
    </div>
</nav>
<!-- End mainmenu-->
</header>
<!-- Mobile Nav-->
<div id="mobile-nav">
    <!-- Menu-->
    <ul>
        <li>
            <a href="index.php?go=home">Startseite</a>
        </li>
        <li>
            <a href="index.php?go=myTipps">Tipps erfassen</a>
        </li>
        <li>
            <a href="index.php?go=otherTipps">Tipps Mitspieler</a>
        </li>
        <li>
            <a href="index.php?go=ranking">Rangliste</a>
        </li>
        <li>
            <a href="index.php?go=statistics">Statistiken</a>
        </li>
        <li>
            <a href="index.php?go=guestbook">Gästebuch</a>
        </li>
        <li s>
            <a href="index.php?go=rules">Spielregeln</a>
        </li>
        <?php
		$abfrage = "SELECT * FROM user where userid='".$_SESSION['userid']."'";

            $ergebnis = mysql_query($abfrage);

            while($row = mysql_fetch_assoc($ergebnis))
            {
            if($row['admin'] == '1'){
            ?>
        <li >
            <a href="index.php?go=admin">Admin</a>
        </li>
        <?php
			}
		}
	?>
        <li >
            <a href="index.php?go=changePassword">Passwort &auml;ndern</a>
        </li>
        <li >
            <a href="index.php?go=logout">Logout</a>
        </li>
    </ul>

    <!-- End Menu-->
</div>
<!-- End Mobile Nav-->
