<h2>Registrieren</h2>
<form action="index.php?go=register&action=register" method="POST">
	<table>
		<tr>
			<td>
				Name:
			</td>
			<td>
				<input type="text" name="nachname" />
			</td>
		</tr>
		<tr>
			<td style="padding-top: 5px">	
				Vorname:
			</td>
			<td>
				<input type="text" name="vorname" />
			</td>
		</tr>
		<tr>
			<td style="padding-top: 5px">	
				Email:
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
