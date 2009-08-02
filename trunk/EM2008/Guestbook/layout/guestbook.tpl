<h2>G&auml;stebuch</h2>
<?php require_once('Layout/infos.tpl'); ?>
<?php require_once('Layout/errors.tpl'); ?>

<form action="index.php?go=guestbook&action=newEntry" name="formular" method="POST">
	<table border="0" width="100%">
		<tr>
			<td>
				Dein G&auml;stebucheintrag darf <b>NICHT</b> mehr als <b>255 Zeichen</b> und keine der
				nachfolgenden Symbolen: <, >, &, \, ' oder " enthalten!
				<textarea name="text" rows="5" style="width: 100%;"><?php echo $this->text ?></textarea>
			</td>
		</tr>
		<tr>
			<td align="right">
				<input type="submit" value="Eintragen" />
			</td>
		</tr>
	</table>
	
	<?php foreach($this->entries as $entry): ?>
		<table border="0" width="100%">
			<tr>
				<td><b><?php echo $entry['name'] ?></b>&nbsp;schrieb am&nbsp;<?php echo $entry['timestamp'] ?></td>
			</tr>
			<tr>
				<td><?php echo $entry['text'] ?></td>
			</tr>
			<hr noshade="noshade" width="100%"/>
		</table>
	<?php endforeach; ?>
	<hr noshade="noshade" width="100%"/>
</form>