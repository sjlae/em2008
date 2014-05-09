<!--[if IE 6]>
<div style="height:100%">
<![endif]-->
<h2>Rangliste</h2>
Anzahl Teilnehmer:&nbsp;&nbsp;<b><? echo mysql_result($countPlayers,0); ?></b>
<? if($_SESSION['eingeloggt']){?>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Dein aktueller Rang:&nbsp;
		<b><? echo $currentPlace;?></b>
<?	} ?>
<? if(mysql_result($countPlayersNotPayed,0) != 0){ ?>
	<br><br> 
	<div style="color: red">Noch nicht bezahlt (rot eingef&auml;rbt) haben:&nbsp;&nbsp;<b><? echo mysql_result($countPlayersNotPayed,0); ?></b></div>
	<br>
<? } ?>
<table>
	<tr>
		<td>
			<b>Rang</b>
		</td>
		<td>
			&nbsp;
		</td>
		<td style="padding-left: 20px">
			<b>Nachname</b>
		</td>
		<td style="padding-left: 20px">
			<b>Vorname</b>
		</td>
		<td style="padding-left: 20px" align="right">
			<b>Punkte</b>
		</td>
	</tr>
	<tr />
	<? 
		$previousRank = 0;
		
		if($rankingArray != null){
			foreach($rankingArray as $ranking): 
	?>
				<tr style="background-color: <? if($_SESSION['userid'] == $ranking['userid']){ echo 'yellow'; } ?>;">
					<td>
						<?
							if($ranking['now'] != 0){
								if($previousRank == 0 || $previousRank != $ranking['now']){
									$previousRank = $ranking['now'];
									echo $ranking['now'];
						?>
									.
						<?
								}
							}
						?>
					</td>
					<td>
						<?
							if($ranking['now'] > $ranking['last']){
								$diff = $ranking['now'] - $ranking['last'];
						?>
								<img alt="" src="icons_down.png" width="15px;"/>
								(-<?echo $diff;?>)
						<?	
							}
							else if($ranking['now'] < $ranking['last']){
								$diff = $ranking['last'] - $ranking['now'];
						?>
								<img alt="" src="icons_up.png" width="15px;"/>
								(+<?echo $diff;?>)
						<?	
							}
							else{
						?>
								<img alt="" src="icons_right.png" width="15px;"/>
								(+0)
						<?	
							}
						?>
					</td>
					<?
						if($ranking['bezahlt'] == 0){
					?>
							<td style="padding-left: 20px; color:red">
								<?
									if($_SESSION['eingeloggt']){
								?>
										<a href="index.php?go=otherTipps&action=getTipps&id=<?php echo $ranking['userid']+5; ?>" style="color:red">
											<?echo $ranking['nachname'] ?>
										</a>
								<?
									}
									else{
								?>
										<?echo $ranking['nachname'] ?>
								<?
									}
								?>
							</td>
							<td style="padding-left: 20px; color: red">
								<?echo $ranking['vorname']?>
							</td>
					<?
						}
						else{
					?>
							<td style="padding-left: 20px;">
								<?
									if($_SESSION['eingeloggt']){
								?>
										<a href="index.php?go=otherTipps&action=getTipps&id=<?php echo $ranking['userid']+5; ?>">
											<?echo $ranking['nachname'] ?>
										</a>
								<?
									}
									else{
								?>
										<?echo $ranking['nachname'] ?>
								<?
									}
								?>
							</td>
							<td style="padding-left: 20px;">
								<?echo $ranking['vorname']?>
							</td>
					<?
						}
					?>
					<td style="padding-left: 20px" align="right">
						<?echo $ranking['punkte'] ?>
					</td>
				</tr>
	<? 
			endforeach; 
		}
	?>
</table>
<!--[if IE 6]>
</div>
<![endif]-->