<!-- Section Title -->
<div class="section-title" style="background:url(img/slide/1.jpg)">
	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<h1>Tipps von allen Mitspielern</h1>
			</div>
		</div>
	</div>
</div>
<!-- End Section Title -->

<!-- Section Area - Content Central -->
<section class="content-info">

	<div class="container paddings-mini">
		<div class="panel-box block-form">

<form action="index.php?go=otherTipps&action=sort" name="formular" method="POST" class="form-horizontal form-theme padding-top-mini">
	<div class="form-group">
		<label class="control-label col-sm-2">Sortierung: </label>
		<div class="col-sm-10">
			<select name="sort" value="" onChange="this.form.submit()" class="form-control" style="width: 200px;">
				<?php if($this->sort == 'Nachname'){ ?>
				<option value="Nachname" selected>Nachname</option>
				<?php } else{?>
				<option value="Nachname">Nachname</option>
				<?php } ?>
				<?php if($this->sort == 'Rang'){ ?>
				<option value="Rang" selected>Rang</option>
				<?php } else{?>
				<option value="Rang">Rang</option>
				<?php } ?>
			</select>
		</div>
	</div>

</form>
<ul>
	<?php foreach($this->players as $player): ?>
	<li><a href="index.php?go=otherTipps&action=getTipps&id=<?php echo $player['id']; ?>"><?php echo $player['nachname']; ?> <?php echo $player['vorname']; ?> &nbsp;(<?php echo $player['rank_now']; ?>.)</a></li>
	<?php endforeach; ?>
</ul>
		</div>
	</div>
</section>