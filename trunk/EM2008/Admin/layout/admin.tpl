<h2>Admin</h2>
<h3>Zahlungen erfassen</h3>
<form action="index.php?go=admin&action=nnb" method="POST">
<table>
	<tr>
		<td></td>
		<td>Nachname</td>
		<td>Vorname</td>
		<td>Email</td>
	</tr>
	<?php $i=0; ?>
	<?php foreach($this->nnb as $nnbUser): ?>
	<tr>
		<td><input type="checkbox" name="user<?php echo $i; ?>" value="<?php echo $nnbUser['userid']; ?>" /></td>
		<td><?php echo $nnbUser['nachname']; ?></td>
		<td><?php echo $nnbUser['vorname']; ?></td>
		<td><a href="mailto:<?php echo $nnbUser['email']; ?>"><?php echo $nnbUser['email']; ?></a></td>
	</tr>
	<?php $i++; ?>
	<?php endforeach; ?>
</table>
<input type="submit" value="Erfassen" />
</form>