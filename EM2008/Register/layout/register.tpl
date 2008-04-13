<h2>Register</h2>

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
