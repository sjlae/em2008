<h2>Register</h2>
<form action="index.php?go=register&action=register" method="POST">
Name:<input type="text" name="nachname" /><br />
Vorname:<input type="text" name="vorname" /><br />
Email:<input type="text" name="email" /><br />
Passwort:<input type="password" name="passwort" /><br />
Passwort wiederholen:<input type="password" name="passwort2" /><br />
Kam zu dieser Seite:
<select name="where">
<?$i=0; ?>
<?foreach($wheres as $where): ?>
<option value="<?echo ++$i; ?>"><?echo $where ?></option>
<?endforeach; ?>
</select>
<br />
<input type="submit" value="Registrieren" />
</form>
