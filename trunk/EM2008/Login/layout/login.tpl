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
<?foreach($_SESSION['errors'] as $error):?>
	<li><?echo $error; ?></li>
<?endforeach ?>
<?unset($_SESSION['errors']); ?>
</ul>
<?endif?>
<form action="index.php?go=login&action=login" method="POST">
<table>
	<tr>
		<td>
			E-Mail:
		</td>
		<td>
			<input type="text" name="email" />
		</td>
	</tr>
	<tr>
		<td style="padding-top: 5px">	
			Passwort:
		</td>
		<td>
			<input type="password" name="passwort" />
		</td>
	</tr>
	<tr>
		<td style="padding-top: 10px">
			<input type="submit" value="Einloggen" />
		</td
	</tr>
</table>
</form>