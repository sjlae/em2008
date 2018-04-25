<!-- Section Title -->
<div class="section-title" style="background:url(img/slide/1.jpg)">
	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<h1>Passwort &auml;ndern</h1>
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
		<div class="panel-box block-form">
			<div class="titles text-center">
				<h4>Passwort &auml;ndern</h4>
			</div>


<form action="index.php?go=changePassword&action=change" method="POST">
	<table>
		<tr>
			<td style="padding-top: 5px">	
				Altes Passwort:
			</td>
			<td>
				<input class="form-control" type="password" name="oldPassword" value="<?php echo htmlentities($this->oldPassword, ENT_COMPAT, 'UTF-8'); ?>" style="width: 150px" />
			</td>
		</tr>
		<tr> 
			<td style="padding-top: 5px">	
				Neues Passwort:
			</td>
			<td>
				<input class="form-control" type="password" name="newPassword1" value="<?php echo htmlentities($this->newPassword1, ENT_COMPAT, 'UTF-8'); ?>" style="width: 150px" />
			</td>
		</tr>
		<tr>
			<td style="padding-top: 5px">	
				Neues Passwort wiederholen:
			</td>
			<td>
				<input class="form-control" type="password" name="newPassword2" value="<?php echo htmlentities($this->newPassword2, ENT_COMPAT, 'UTF-8'); ?>" style="width: 150px" />
			</td>
		</tr>
		<tr>
			<td style="padding-top: 10px">
				<input type="submit" value="Speichern" class="bnt btn-iw" />
			</td>
		</tr>
	</table>
</form>

		</div>
	</div>
</section>
<!-- End Section Area -  Content Central -->