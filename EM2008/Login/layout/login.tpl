<!-- Section Title -->
<div class="section-title" style="background:url(img/slide/1.jpg)">
	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<h1>Login</h1>
			</div>
		</div>
	</div>
</div>
<!-- End Section Title -->

<!-- Section Area - Content Central -->
<section class="content-info">

	<div class="container paddings-mini">
		<div class="panel-box block-form">
			<div class="titles text-center">
				<h4>Einloggen</h4>
			</div>
<?php require_once('Layout/infos.tpl'); ?>
<?php require_once('Layout/errors.tpl'); ?>
<form action="index.php?go=login&action=login" method="POST">
<table>
	<tr>
		<td>
			E-Mail:
		</td>
		<td>
			<input type="text" name="email" value="<?php echo $this->email; ?>" style="width: 150px"/>
		</td>
	</tr>
	<tr>
		<td style="padding-top: 5px">	
			Passwort:
		</td>
		<td>
			<input type="password" name="passwort" style="width: 150px"/>
		</td>
	</tr>
	<tr>
		<td style="padding-top: 10px">

		</td>
		<td style="padding-top: 10px; padding-left: 10px;">
			<input type="submit" value="Einloggen" class="bnt btn-iw"  />
			<input type="submit" value="Passwort vergessen" class="bnt btn-iw" onclick="document.forms['forgot'].submit(); return(false);"/>
		</td>
	</tr>
</table>
<script type="text/javascript">
	$(document).ready(function() {
		$('input[name="email"]').focus();
	});
</script>
</form>
<form action="index.php?go=password" method="POST" name="forgot"/>

		</div>
	</div>
</section>
<!-- End Section Area -  Content Central -->