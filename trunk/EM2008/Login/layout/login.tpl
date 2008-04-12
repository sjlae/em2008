<h2>Login</h2>

<? if(count($_SESSION['infos']) > 0): ?>
<p>Information/en:</p>
<ul>	
<?foreach($_SESSION['infos'] as $info):?>
	<li><?echo $info; ?></li>
<?endforeach ?>
<?unset($_SESSION['infos']); ?>
</ul>
<?endif?>
<? if(count($_SESSION['errors']) > 0): ?>
<p>Fehler</p>
<ul>	
<?foreach($_SESSION['errors'] as $info):?>
	<li><?echo $info; ?></li>
<?endforeach ?>
<?unset($_SESSION['errors']); ?>
</ul>
<?endif?>
<form action="index.php?go=login&action=login" method="POST">
<div>E-Mail<input type="text" name="email" /></div>
<div>Passwort<input type="password" name="passwort" /></div>
<input type="submit" value="Einloggen" />
</form>