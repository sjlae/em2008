<h2>Tipps von allen Mitspielern</h2>
<ul>
	<?php foreach($this->players as $player): ?>
	<li><a href="index.php?go=otherTipps&action=getTipps&id=<?php echo $player['id']; ?>"><?php echo $player['nachname']; ?> <?php echo $player['vorname']; ?></a></li>
	<?php endforeach; ?>
</ul>
