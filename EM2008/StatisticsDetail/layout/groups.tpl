<h2>Statistik-Details</h2>
<form action="index.php?go=statisticsDetail&action=sort&id=<?php echo $this->id; ?>&result=<?php echo $this->result; ?>" name="formular" method="POST">
	Sortierung:&nbsp;
	<select name="sort" value="" onChange="this.form.submit()">
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
	<select name="filterResult" value="" onChange="this.form.submit()">
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
<table border="0">
	<tr>
		<td style="white-space: nowrap;"><b>Vorname</b></td>
		<td style="white-space: nowrap; padding-left: 10px;"><b>Nachname</b></td>
		<td style="white-space: nowrap; padding-left: 10px;"><b><?php echo $this->team1; ?></b></td>
		<td style="white-space: nowrap; padding-left: 10px;"><b><?php echo $this->team2; ?></b></td>
	</tr>
	
	<?php foreach($this->tipps as $tipps): ?>
		<tr>
			<td style="white-space: nowrap;"><?php echo $tipps['vorname'] ?></td>
			<td style="white-space: nowrap; padding-left: 10px;"><a href="index.php?go=otherTipps&action=getTipps&id=<?php echo $tipps['userid']+5; ?>"><?php echo $tipps['nachname'] ?>&nbsp;(<?php echo $tipps['rank_now']; ?>.)</a></td>
			<td style="white-space: nowrap; padding-left: 10px;" align="center"><?php echo $tipps['result1'] ?></td>
			<td style="white-space: nowrap; padding-left: 10px;" align="center"><?php echo $tipps['result2'] ?></td>
		</tr>
	<?php endforeach; ?>
</table>