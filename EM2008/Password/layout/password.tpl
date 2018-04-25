<!-- Section Title -->
<div class="section-title" style="background:url(img/slide/1.jpg)">
	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<h1>Neues Passwort anfordern</h1>
			</div>
		</div>
	</div>
</div>
<!-- End Section Title -->
<?php require_once('Layout/errors.tpl'); ?>

<!-- Section Area - Content Central -->
<section class="content-info">

	<div class="container paddings-mini">
		<div class="panel-box block-form">
			<div class="titles text-center">
				<h4>Neues Passwort</h4>
			</div>
<form action="index.php?go=password&action=new" method="POST">
	<table>
		<tr>
			<td style="padding-top: 5px">	
				Deine E-Mail Adresse:
			</td>
			<td>
				<input type="text" name="email" value="<?php echo htmlentities($this->email, ENT_COMPAT, 'UTF-8'); ?>" class="form-control"/>
			</td>
		</tr>
		<tr>
			<td>

			</td>
			<td><input type="submit" value="Senden" class="bnt btn-iw"  /></td>
		</tr>
	</table>
</form>
		</div>
	</div>
</section>
<!-- End Section Area -  Content Central -->