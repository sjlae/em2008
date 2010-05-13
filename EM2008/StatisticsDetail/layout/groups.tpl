<h2>Statistik-Details</h2>
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
			<td style="white-space: nowrap; padding-left: 10px;"><a href="index.php?go=otherTipps&action=getTipps&id=<?php echo $tipps['userid']+5; ?>"><?php echo $tipps['nachname'] ?></a></td>
			<td style="white-space: nowrap; padding-left: 10px;" align="center"><?php echo $tipps['result1'] ?></td>
			<td style="white-space: nowrap; padding-left: 10px;" align="center"><?php echo $tipps['result2'] ?></td>
		</tr>
	<?php endforeach; ?>
</table>