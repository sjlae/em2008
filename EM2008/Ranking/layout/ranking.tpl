<h2>Rangliste</h2>
<?php require_once('Layout/infos.tpl'); ?>
Anzahl Teilnehmer:&nbsp;&nbsp;<b><? echo mysql_result($countPlayers,0); ?></b>
<? if($_SESSION['eingeloggt']){?>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Dein aktueller Rang:&nbsp;
		<b><? echo $this->currentPlace;?></b>
<?	} ?>
<br>
<? if(mysql_result($countPlayersNotPayed,0) != 0){ ?>
	<br>
	<span style="color: red">Noch nicht bezahlt (rot eingef&auml;rbt) haben:&nbsp;&nbsp;<b><? echo mysql_result($countPlayersNotPayed,0); ?></b></span>
	<br>
<? } ?>
<br>

<? $isDisabled = count($this->gruppen) == '0' ? 'disabled' : ''; ?>

<form action="index.php?go=ranking&action=gruppenfilter" name="formular" method="POST">
	<select name="gruppe" <? echo $isDisabled; ?> onChange="this.form.submit()">
		<option value="Alle">Alle</option>
		<?foreach($this->gruppen as $gruppe): ?>
			<?php if($this->gruppe == $gruppe['gruppeid']): ?>
				<option value="<?echo $gruppe['gruppeid']; ?>" selected><?echo $gruppe['name']; ?></option>
			<?php else:?>
				<option value="<?echo $gruppe['gruppeid']; ?>"><?echo $gruppe['name']; ?></option>
			<?php endif; ?>
		<?endforeach; ?>
	</select>
	&nbsp;
	<? if($_SESSION['eingeloggt']){ ?>
			<a href="index.php?go=ranking&action=addmodify" style="text-decoration: none;">
				<img align="top" alt="Gruppe erstellen" title="Gruppe erstellen" src="icons_add.png" width="19px;"/>
			</a>
			&nbsp;
			<? if($this->gruppe != 'Alle' && $this->gruppe != ''){ ?>
				<a href="index.php?go=ranking&action=addmodify&gruppeid=<? echo $this->gruppe; ?>"  style="text-decoration: none;">
					<img align="top" alt="Gruppe bearbeiten" title="Gruppe bearbeiten" src="icons_modify.png" width="18px;"/>
				</a>
			<? } ?>
	<? } ?>
</form>

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
		
		if($this->rankingArray != null){
			foreach($this->rankingArray as $ranking): 
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