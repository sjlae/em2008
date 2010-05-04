<div style="float: left">
<h2>G&auml;stebuch</h2>
<?php require_once('Layout/infos.tpl'); ?>
<?php require_once('Layout/errors.tpl'); ?>
<form action="index.php?go=guestbook&action=newEntry" name="formular" method="POST">
	<table border="0">
		<tr>
			<td>
				<textarea name="text" rows="5" style="width: 520px;"><?php echo $this->text ?></textarea>
			</td>
		</tr>
		<tr>
			<td align="right">
				<input type="submit" value="Eintragen" />
			</td>
		</tr>
	</table>
	
	<?php foreach($this->entries as $entry): ?>
		<table border="0" width="520px">
			<tr>
				<td><b><?php echo $entry['name'] ?></b>&nbsp;schrieb am&nbsp;<?php echo $entry['timestamp'] ?></td>
			</tr>
			<tr>
				<td><?php echo $entry['text'] ?></td>
			</tr>
			<hr noshade="noshade" width="520px"/>
		</table>
	<?php endforeach; ?>
	<hr noshade="noshade" width="520px"/>
</form>
</div>