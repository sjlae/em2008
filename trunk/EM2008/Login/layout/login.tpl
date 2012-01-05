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
			<input type="text" name="email" value="<?php echo $this->email; ?>" style="width: 150px"/>
		</td>
	</tr>
	<tr>
		<td style="padding-top: 5px">	
			Passwort:
		</td>
		<td>
			<input type="password" name="passwort" style="width: 150px"/>
		</td>
	</tr>
	<tr>
		<td style="padding-top: 10px">
			<input type="submit" value="Einloggen" />
		</td>
		<td style="padding-top: 10px; padding-left: 10px;">
			<input type="submit" value="Passwort vergessen" onclick="document.forms['forgot'].submit(); return(false);"/>
		</td>
	</tr>
</table>
<script type="text/javascript">
	$(document).ready(function() {
		$('input[name="email"]').focus();
	});
</script>
</form>
<form action="index.php?go=password" method="POST" name="forgot"/>