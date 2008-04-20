<h2>Admin</h2>
<h3>Zahlungen erfassen</h3>
<form action="index.php?go=admin&action=nnb" method="POST">
<table>
	<tr>
		<td></td>
		<td style="padding-left: 5px"><b>Vorname</b></td>
		<td style="padding-left: 5px"><b>Nachname</b></td>
		<td style="padding-left: 5px"><b>Email</b></td>
	</tr>
	<?php $i=0; ?>
	<?php foreach($this->nnb as $nnbUser): ?>
	<tr>
		<td><input type="checkbox" name="user<?php echo $i; ?>" value="<?php echo $nnbUser['userid']; ?>" /></td>
		<td style="padding-left: 5px"><?php echo $nnbUser['vorname']; ?></td>
		<td style="padding-left: 5px"><?php echo $nnbUser['nachname']; ?></td>
		<td style="padding-left: 5px"><a href="mailto:<?php echo $nnbUser['email']; ?>"><?php echo $nnbUser['email']; ?></a></td>
	</tr>
	<?php $i++; ?>
	<?php endforeach; ?>
</table>
<input type="hidden" name="maxUser" value="<?php echo $i-1; ?>" />
<input type="submit" value="Erfassen" />
</form>
<h3>Resultate erfassen</h3>
<table>
	<tr>
		<td>#</td>
		<td>Team1</td>
		<td>Team2</td>
		<td>Resultat1</td>
		<td>Resultat2</td>
	</tr>
</table>