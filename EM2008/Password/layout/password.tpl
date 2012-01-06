<h2>Neues Passwort anfordern</h2>
<?php require_once('Layout/errors.tpl'); ?>
<form action="index.php?go=password&action=new" method="POST">
	<table>
		<tr>
			<td style="padding-top: 5px">	
				Deine E-Mail Adresse:
			</td>
			<td>
				<input type="text" name="email" value="<?php echo htmlentities($this->email, ENT_COMPAT, 'UTF-8'); ?>" style="width: 150px" />
			</td>
		</tr>
		<tr>
			<td style="padding-top: 10px">
				<input type="submit" value="Senden" />
			</td
		</tr>
	</table>
</form>
