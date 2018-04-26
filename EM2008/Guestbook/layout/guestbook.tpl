<!-- Section Title -->
<div class="section-title" style="background:url(img/slide/1.jpg)">
	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<h1>Gästebuch</h1>
			</div>
		</div>
	</div>
</div>
<!-- End Section Title -->
<?php require_once('Layout/infos.tpl'); ?>
<?php require_once('Layout/errors.tpl'); ?>

<!-- Section Area - Content Central -->
<section class="content-info">

	<div class="container paddings-mini">


<form action="index.php?go=guestbook&action=newEntry" name="formular" method="POST">
	<div class="panel-box">
		<div class="titles">
			<h4>Neuer Eintrag</h4>
		</div>
	<table border="0">
		<tr>
			<td>
				<textarea name="text" rows="5" style="width: 520px;"><?php echo $this->text ?></textarea>
			</td>
		</tr>
		<tr>
			<td align="left">
				<input type="submit" value="Eintragen" class="bnt btn-iw" />
			</td>
		</tr>
	</table>
	</div>
	<div class="row">
	<?php foreach($this->entries as $entry): ?>
		<table border="0">
			<tr>
				<td><b><?php echo $entry['name'] ?></b>&nbsp;schrieb am&nbsp;<?php echo $entry['timestamp'] ?></td>
			</tr>
			<tr>
				<td><?php echo $entry['text'] ?></td>
			</tr>
			<hr noshade="noshade"/>
		</table>
	<?php endforeach; ?>
	<hr noshade="noshade"/>
</form>
		</div>
	</div>
</section>
<!-- End Section Area -  Content Central -->