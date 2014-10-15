<h2>Registrieren</h2>
<?php require_once('Layout/errors.tpl'); ?>
<form action="index.php?go=register&action=register" method="POST">
	<table>
		<tr>
			<td style="padding-top: 5px">	
				Vorname:
			</td>
			<td>
				<input type="text" name="vorname" value="<?php echo htmlentities($this->vorname, ENT_COMPAT, 'UTF-8'); ?>" style="width: 150px" />
			</td>
		</tr>
		<tr>
			<td>
				Name:
			</td>
			<td>
				<input type="text" name="nachname" value="<?php echo htmlentities($this->nachname, ENT_COMPAT, 'UTF-8'); ?>" style="width: 150px" />
			</td>
		</tr>
		<tr>
			<td style="padding-top: 5px">	
				Email:
			</td>
			<td>
				<input type="text" name="email" value="<?php echo htmlentities($this->email, ENT_COMPAT, 'UTF-8'); ?>" style="width: 150px" />
			</td>
		</tr>
		<tr>
			<td style="padding-top: 5px">	
				Passwort:
			</td>
			<td>
				<input type="password" name="passwort1" style="width: 150px"/>
			</td>
		</tr>
		<tr>
			<td style="padding-top: 5px">	
				Passwort wiederholen:
			</td>
			<td>
				<input type="password" name="passwort2" style="width: 150px"/>
			</td>
		</tr>
		<tr>
			<td style="padding-top: 5px">	
				Kam zu dieser Seite:
			</td>
			<td>
				<select name="where">
					<?php $i=0; ?>
					<?php foreach($this->wheres as $where): ?>
						<option value="<?php echo ++$i; ?>"><?php echo $where; ?></option>
					<?php endforeach; ?>
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
