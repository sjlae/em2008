<!-- Section Title -->
<div class="section-title" style="background:url(img/slide/1.jpg)">
	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<h1>Statistik-Details</h1>
			</div>
		</div>
	</div>
</div>
<!-- End Section Title -->

<!-- Section Area - Content Central -->
<section class="content-info">

	<div class="container paddings-mini">
<form action="index.php?go=statisticsDetail&action=sort&id=<?php echo $this->id; ?>&result=<?php echo $this->result; ?>" name="formular" method="POST">
	Sortierung:&nbsp;
	<select name="sort" value="" onChange="this.form.submit()" class="form-control" style="display: inline; margin-bottom: 10px; width: 20%">
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
	&nbsp;&nbsp;&nbsp;Filter:&nbsp;
	<select name="filterResult" value="" onChange="this.form.submit()"class="form-control" style="display: inline; margin-bottom: 10px; width: 20%">
		<option value="Alle">Alle</option>
		<?php foreach($this->filter as $filter): ?>
			<?php if($this->filterResult == $filter): ?>
				<option value="<?php echo $filter; ?>" selected><?php echo $filter; ?></option>
			<?php else:?>
				<option value="<?php echo $filter; ?>"><?php echo $filter; ?></option>
			<?php endif; ?>
		<?php endforeach; ?>
	</select>
</form>
		<table class="table-striped table-responsive table-hover result-point">
			<thead class="point-table-head">
	<tr>
		<th style="white-space: nowrap;"><b>Vorname</b></th>
		<th style="white-space: nowrap; padding-left: 10px;"><b>Nachname</b></th>
		<th style="white-space: nowrap; padding-left: 10px;"><b><?php echo $this->team1; ?></b></th>
		<th style="white-space: nowrap; padding-left: 10px;"><b><?php echo $this->team2; ?></b></th>
		<th style="white-space: nowrap; padding-left: 10px;"><b>High Risk</b></th>
	</tr>
			</thead>
	
	<?php foreach($this->tipps as $tipps): ?>
		<tr>
			<td style="white-space: nowrap;"><?php echo $tipps['vorname'] ?></td>
			<td style="white-space: nowrap; padding-left: 10px;"><a href="index.php?go=otherTipps&action=getTipps&id=<?php echo $tipps['userid']+5; ?>"><?php echo $tipps['nachname'] ?>&nbsp;(<?php echo $tipps['rank_now']; ?>.)</a></td>
			<td style="white-space: nowrap; padding-left: 10px;" align="center"><?php echo $tipps['result1'] ?></td>
			<td style="white-space: nowrap; padding-left: 10px;" align="center"><?php echo $tipps['result2'] ?></td>
			<td style="white-space: nowrap; padding-left: 10px;" align="center">
				<?php if($tipps['highrisk'] == 1){ ?>
					<input type="checkbox" name="games_highrisk" disabled checked/>
				<?php } else{ ?>
					<input type="checkbox" name="games_highrisk" disabled/>
				<?php } ?>
			</td>
		</tr>
	<?php endforeach; ?>
</table>
</div>
</section>