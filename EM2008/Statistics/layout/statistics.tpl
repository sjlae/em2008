<!-- Section Title -->
<div class="section-title" style="background:url(img/slide/1.jpg)">
	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<h1>Auswertung aller abgegebenen Tipps</h1>
			</div>
		</div>
	</div>
</div>
<!-- End Section Title -->


<!-- Section Area - Content Central -->
<section class="content-info">

	<!--<div class="container paddings-mini">-->
	<div class="single-player-tabs">
		<div class="container">

<?php require_once('Layout/Tabs.php'); ?>
<?php require_once('Constants.php'); ?>

<?php $tabs = new Tabs("Statistics"); ?>
<?php $tabs->start("Resultattipps"); ?>

	<table border="0">
		<tr>
			<td style="background-color: #2196f3; width: 30px;">&nbsp;</td>
			<td>Anzahl Tipps auf Sieg Team 1</td>
		</tr>
		<tr>
			<td style="background-color: #ffc107; width: 30px;">&nbsp;</td>
			<td>Anzahl Tipps auf Unentschieden</td>
		</tr>
		<tr>
			<td style="background-color: #4caf50; width: 30px;">&nbsp;</td>
			<td>Anzahl Tipps auf Sieg Team 2</td>
		</tr>
	</table>

	<form action="index.php?go=statistics&page=groups" name="formular" method="POST">
		<table border="0">
			<tr>
				<td style="white-space: nowrap; width: 20px;"><b>Datum</b></td>
				<td style="white-space: nowrap;"><b>Team 1</b></td>
				<td style="white-space: nowrap;"><b>Team 2</b></td>
				<td style="white-space: nowrap;"><b>Tippverteilung</b></td>
			</tr>
			<?php foreach($this->vorrunde as $spiel): ?>
			<tr>
				<td valign="top" style="white-space: nowrap;"><?php echo $spiel['start']; ?></td>
				<td valign="top" style="white-space: nowrap;"><?php echo $spiel['team1']; ?></td>
				<td valign="top" style="white-space: nowrap;"><?php echo $spiel['team2']; ?></td>
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
								<?php $link1 = "index.php?go=statisticsDetail&id=" . $spiel['id'] . "&result=1"; ?>
								<td align="center" style="background-color: #2196f3; width: <?php echo $wert1 ?>%; cursor: pointer;" onclick="document.location='<?php echo $link1 ?>'">
									<a href="index.php?go=statisticsDetail&id=<?php echo $spiel['id']; ?>&result=1" <?php echo $spiel['userResult'] == '1' ? 'style="color: red;text-decoration: underline; "' : 'style="color: white; text-decoration: underline;"'; ?>><b><?php echo $spiel['total_1']; ?></b></a>
								</td>
							<?php } ?>
							<?php if($wertX != 0){ ?>
								<?php $linkX = "index.php?go=statisticsDetail&id=" . $spiel['id'] . "&result=X"; ?>
								<td align="center" style="background-color: #ffc107; width: <?php echo $wertX ?>%; cursor: pointer;"  onclick="document.location='<?php echo $linkX ?>'">
									<a href="index.php?go=statisticsDetail&id=<?php echo $spiel['id']; ?>&result=X" <?php echo $spiel['userResult'] == 'X' ? 'style="color: red;text-decoration: underline;"' : 'style="color: white;text-decoration: underline;"'; ?>><b><?php echo $spiel['total_X']; ?></b></a>
								</td>
							<?php } ?>
							<?php if($wert2 != 0){ ?>
								<?php $link2 = "index.php?go=statisticsDetail&id=" . $spiel['id'] . "&result=2"; ?>
								<td align="center" style="background-color: #4caf50; width: <?php echo $wert2 ?>%;  cursor: pointer;" onclick="document.location='<?php echo $link2 ?>'">
									<a href="index.php?go=statisticsDetail&id=<?php echo $spiel['id']; ?>&result=2" <?php echo $spiel['userResult'] == '2' ? 'style="color: red;text-decoration: underline;"' : 'style="color: white;text-decoration: underline;"'; ?>><b><?php echo $spiel['total_2']; ?></b></a>
								</td>
							<?php } ?>
						</tr>
					</table>
				</td>
			</tr>
			<?php endforeach; ?>
		</table>
<?php $tabs->end(); ?>
<?php $tabs->start("Weitere Tipps"); ?>
		<table class="table-striped table-responsive table-hover result-point">
			<thead class="point-table-head">
			<tr>
				<td style="white-space: nowrap; width="*"><b>Land</b></td>
				<td style="white-space: nowrap; text-align: center; width: 14%;"><b>1/8 Final</b></td>
				<td style="white-space: nowrap; text-align: center; width: 14%;"><b>Bestes Team</b></td>
				<td style="white-space: nowrap; text-align: center; width: 14%;"><b>Schlechtestes Team</b></td>
				<td style="white-space: nowrap; text-align: center; width: 14%;"><b>Sieger</b></td>
			</tr>
			</thead>
			<?php foreach($this->teams as $land): ?>
				<tr>
					<td><img alt="" src="nationalFlags/<?php echo $land['id'] ?>.gif" width="20"/>&nbsp;<?php echo $land['team']; ?></td>
					<td align="center"><?php echo $this->achtelfinal[$land['id']] != '' ? $this->achtelfinal[$land['id']] : 0; ?></td>
					<td align="center"><?php echo $this->best[$land['id']] != '' ? $this->best[$land['id']] : 0; ?></td>
					<td align="center"><?php echo $this->worst[$land['id']] != '' ? $this->worst[$land['id']] : 0; ?></td>
					<td align="center"><?php echo $this->winner[$land['id']] != '' ? $this->winner[$land['id']] : 0; ?></td>
				</tr>
			<?php endforeach; ?>
		</table>
		<table class="table-striped table-responsive table-hover result-point">
			<tr>
				<td style="white-space: nowrap; padding-bottom: 5px" colspan="2"><b>Wie weit kommt die Schweiz im Turnier?</b></td>
			</tr>
			<?php foreach($this->phases as $phase): ?>
				<tr>
					<td style="white-space: nowrap;"><?php echo $phase['beschreibung'] != '' ? $phase['beschreibung'] : 0; ?></td>
					<td width="100%" style="padding-left: 20px;"><?php echo $this->switzerland[$phase['id']] != '' ? $this->switzerland[$phase['id']] : 0; ?></td>
				</tr>
			<?php endforeach; ?>
		</table>
		<table class="table-striped table-responsive table-hover result-point">
			<tr>
				<td style="white-space: nowrap; padding-bottom: 5px" colspan="2"><b>Wie weit kommt der Titelverteidiger Deutschland im Turnier?</b></td>
			</tr>
			<?php foreach($this->phases as $phase): ?>
				<tr>
					<td style="white-space: nowrap;"><?php echo $phase['beschreibung'] != '' ? $phase['beschreibung'] : 0; ?></td>
					<td width="100%" style="padding-left: 20px;"><?php echo $this->lastwinner[$phase['id']] != '' ? $this->lastwinner[$phase['id']] : 0; ?></td>
				</tr>
			<?php endforeach; ?>
		</table>
<?php $tabs->end(); ?>
<?php $tabs->run(); ?>
		</div>
	</div>
</section>