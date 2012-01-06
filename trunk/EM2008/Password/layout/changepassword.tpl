<h2>Passwort &auml;ndern</h2>
<?php require_once('Layout/infos.tpl'); ?>
<?php require_once('Layout/errors.tpl'); ?>
<form action="index.php?go=changePassword&action=change" method="POST">
	<table>
		<tr>
			<td style="padding-top: 5px">	
				Altes Passwort:
			</td>
			<td>
				<input type="password" name="oldPassword" value="<?php echo htmlentities($this->oldPassword, ENT_COMPAT, 'UTF-8'); ?>" style="width: 150px" />
			</td>
		</tr>
		<tr> 
			<td style="padding-top: 5px">	
				Neues Passwort:
			</td>
			<td>
				<input type="password" name="newPassword1" value="<?php echo htmlentities($this->newPassword1, ENT_COMPAT, 'UTF-8'); ?>" style="width: 150px" />
			</td>
		</tr>
		<tr>
			<td style="padding-top: 5px">	
				Neues Passwort wiederholen:
			</td>
			<td>
				<input type="password" name="newPassword2" value="<?php echo htmlentities($this->newPassword2, ENT_COMPAT, 'UTF-8'); ?>" style="width: 150px" />
			</td>
		</tr>
		<tr>
			<td style="padding-top: 10px">
				<input type="submit" value="Speichern" />
			</td
		</tr>
	</table>
</form>
