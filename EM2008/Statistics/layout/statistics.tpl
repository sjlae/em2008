<h2>Auswertung aller abgegebenen Tipps</h2>
<?php require_once('Layout/infos.tpl'); ?>
<?php require_once('Layout/errors.tpl'); ?>
<?php require_once('Layout/Tabs.php'); ?>

<?php $tabs = new Tabs("Statistics"); ?>
<?php $tabs->start("Gruppenspiele"); ?>

	<table border="0">
		<tr>
			<td style="background-color: #3333FF; width: 30px;">&nbsp;</td>
			<td style="width: 10px;">&nbsp;</td>
			<td>Anzahl Tipps auf Sieg Team 1</td>
		</tr>
		<tr>
			<td style="background-color: #00FF66; width: 30px;">&nbsp;</td>
			<td style="width: 10px;">&nbsp;</td>
			<td>Anzahl Tipps auf Unentschieden</td>
		</tr>
		<tr>
			<td style="background-color: #3399FF; width: 30px;">&nbsp;</td>
			<td style="width: 10px;">&nbsp;</td>
			<td>Anzahl Tipps auf Sieg Team 2</td>
		</tr>
	</table>

	<form action="index.php?go=statistics&page=groups" name="formular" method="POST">
		<table border="0">
			<tr>
				<td align="center" style="white-space: nowrap; padding-bottom: 5px"><b>#</b></td>
				<td style="white-space: nowrap; padding-bottom: 5px"><b>Datum</b></td>
				<td style="white-space: nowrap; padding-bottom: 5px"><b>Team 1</b></td>
				<td style="white-space: nowrap; padding-bottom: 5px"><b>Team 2</b></td>
				<td style="white-space: nowrap; padding-bottom: 5px">&nbsp;</td>
			</tr>
			<?php foreach($this->vorrunde as $spiel): ?>
			<tr>
				<td align="center" valign="top"><?php echo $spiel['id']; ?></td>
				<td valign="top"><?php echo $spiel['start']; ?></td>
				<td valign="top"><?php echo $spiel['team1']; ?></td>
				<td valign="top"><?php echo $spiel['team2']; ?></td>
				<td width="100%" valign="top">
					<table border="0" width="100%">
						<tr>
							<?php
								$total = $spiel['total_1'] + $spiel['total_X'] + $spiel['total_2'];
								
								$wert1 = 0;
								$wertX = 0;
								$wert2 = 0;
								
								if($total != 0){
									$wert1 = $spiel['total_1'] / $total * 100;
									$wertX = $spiel['total_X'] / $total * 100;
									$wert2 = $spiel['total_2'] / $total * 100;
								}
							?>
							
							<?php if($wert1 != 0){ ?>
								<td align="center" style="background-color: #3333FF; width: <?php echo $wert1 ?>% ">
									<?php echo $spiel['total_1']; ?>
								</td>
							<?php } ?>
							<?php if($wertX != 0){ ?>
								<td align="center" style="background-color: #00FF66; width: <?php echo $wertX ?>%">
									<?php echo $spiel['total_X']; ?>
								</td>
							<?php } ?>
							<?php if($wert2 != 0){ ?>
								<td align="center" style="background-color: #3399FF; width: <?php echo $wert2 ?>%">
									<?php echo $spiel['total_2']; ?>
								</td>
							<?php } ?>
						</tr>
					</table>
				</td>
			</tr>
			<?php endforeach; ?>
		</table>
<?php $tabs->end(); ?>
<?php $tabs->start("Finalspiele"); ?>		
		Die in den Spalten angegebenen Werte zeigen auf, wieviele Tipps f&uuml;r ein Land abgegeben wurden, das die entsprechende Runde erreicht.
		<table border="0" width="100%">
			<tr>
				<td style="white-space: nowrap; padding-bottom: 5px; padding-right: 5px"><b>Land</b></td>
				<td style="white-space: nowrap; padding-bottom: 5px" align="right"><b>1/8 Final</b></td>
				<td style="white-space: nowrap; padding-bottom: 5px" align="right"><b>1/4 Final</b></td>
				<td style="white-space: nowrap; padding-bottom: 5px" align="right"><b>1/2 Final</b></td>
				<td style="white-space: nowrap; padding-bottom: 5px" align="right"><b>Final</b></td>
				<td style="white-space: nowrap; padding-bottom: 5px" align="right"><b>Sieger</b></td>
			</tr>
			<?php foreach($this->hauptrunde as $land): ?>
				<tr>
					<td><img alt="" src="nationalFlags/<?php echo $land['id'] ?>.png"/>&nbsp;<?php echo $land['team']; ?></td>
					<td align="right">0</td>
					<td align="right"><?php echo $this->viertelfinal[$land['id']] != '' ? $this->viertelfinal[$land['id']] : 0; ?></td>
					<td align="right"><?php echo $this->halbfinal[$land['id']] != '' ? $this->halbfinal[$land['id']] : 0; ?></td>
					<td align="right"><?php echo $this->final[$land['id']] != '' ? $this->final[$land['id']] : 0; ?></td>
					<td align="right"><?php echo $this->sieger[$land['id']] != '' ? $this->sieger[$land['id']] : 0; ?></td>
				</tr>
			<?php endforeach; ?>
		</table>
<?php $tabs->end(); ?>
<?php $tabs->run(); ?>