<h2>Login</h2>
<?php require_once('Layout/infos.tpl'); ?>
<?php require_once('Layout/errors.tpl'); ?>
<form action="index.php?go=login&action=login" method="POST">
<table>
	<tr>
		<td>
			E-Mail:
		</td>
		<td>
			<input type="text" name="email" value="<?php echo $this->email; ?>"/>
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