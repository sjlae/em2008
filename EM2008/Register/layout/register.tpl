<h2>Register</h2>
<?php require_once('Layout/errors.tpl'); ?>
<form action="index.php?go=register&action=register" method="POST">
	<table>
		<tr>
			<td>
				Name:
			</td>
			<td>
				<input type="text" name="nachname" value="<?php echo $this->nachname; ?>" />
			</td>
		</tr>
		<tr>
			<td style="padding-top: 5px">	
				Vorname:
			</td>
			<td>
				<input type="text" name="vorname" value="<?php echo $this->vorname; ?>" />
			</td>
		</tr>
		<tr>
			<td style="padding-top: 5px">	
				Email:
			</td>
			<td>
				<input type="text" name="email" value="<?php echo $this->email; ?>" />
			</td>
		</tr>
		<tr>
			<td style="padding-top: 5px">	
				Passwort:
			</td>
			<td>
				<input type="password" name="passwort1" />
			</td>
		</tr>
		<tr>
			<td style="padding-top: 5px">	
				Passwort wiederholen:
			</td>
			<td>
				<input type="password" name="passwort2" />
			</td>
		</tr>
		<tr>
			<td style="padding-top: 5px">	
				Kam zu dieser Seite:
			</td>
			<td>
				<select name="where">
					<?$i=0; ?>
					<?foreach($wheres as $where): ?>
						<option value="<?echo ++$i; ?>"><?echo $where ?></option>
					<?endforeach; ?>
				</select>
			</td>
		</tr>
		<tr>
			<td style="padding-top: 10px">
				<input type="submit" value="Registrieren" />
			</td
		</tr>
	</table>
</form>
