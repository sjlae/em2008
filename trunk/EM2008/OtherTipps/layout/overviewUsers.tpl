<h2>Tipps von allen Mitspielern</h2>
<form action="index.php?go=otherTipps&action=sort" name="formular" method="POST">
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
</form>
<ul>
	<?php foreach($this->players as $player): ?>
	<li><a href="index.php?go=otherTipps&action=getTipps&id=<?php echo $player['id']; ?>"><?php echo $player['nachname']; ?> <?php echo $player['vorname']; ?> &nbsp;(<?php echo $player['rank_now']; ?>.)</a></li>
	<?php endforeach; ?>
</ul>
