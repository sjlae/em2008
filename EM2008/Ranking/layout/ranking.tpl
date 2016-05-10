<h2>Rangliste</h2>
<?php  require_once('Layout/infos.tpl'); ?>
<?php 
   $countPlayers = mysql_result($countPlayers,0);
?>
Anzahl Teilnehmer:&nbsp;&nbsp;<b><?php  echo $countPlayers; ?></b>
<?php  
	$userDependentWinLine = '8';
	if($countPlayers >= '201'){
		$userDependentWinLine = '18';		
	}
	if($_SESSION['eingeloggt']){?>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Dein aktueller Rang:&nbsp;
		<b><?php  echo $this->currentPlace;?></b>
<?php 	} ?>
<br>
<?php  if(mysql_result($countPlayersNotPayed,0) != 0){ ?>
	<br>
	<span style="color: red">Noch nicht bezahlt (rot eingef&auml;rbt) haben:&nbsp;&nbsp;<b><?php  echo mysql_result($countPlayersNotPayed,0); ?></b></span>
	<br>
<?php  } ?>

<?php  
	$isDisabled = count($this->gruppen) == '0' ? 'disabled' : ''; 
	if($_SESSION['eingeloggt']){
?>
	<br>
	<form action="index.php?go=ranking&action=gruppenfilter" name="formular" method="POST">
		<select name="gruppe" <?php  echo $isDisabled; ?> onChange="this.form.submit()">
			<option value="Alle">Alle</option>
			<?php foreach($this->gruppen as $gruppe): ?>
				<?php  if($this->gruppe == $gruppe['gruppeid']): ?>
					<option value="<?php echo $gruppe['gruppeid']; ?>" selected><?php echo $gruppe['name']; ?></option>
				<?php  else:?>
					<option value="<?php echo $gruppe['gruppeid']; ?>"><?php echo $gruppe['name']; ?></option>
				<?php  endif; ?>
			<?php endforeach; ?>
		</select>
		&nbsp;
		<a href="index.php?go=ranking&action=addmodify" style="text-decoration: none;">
			<img align="top" alt="Gruppe erstellen" title="Gruppe erstellen" src="icons_add.png" width="19px;"/>
		</a>
		&nbsp;
		<?php  if($this->gruppe != 'Alle' && $this->gruppe != ''){ ?>
			<a href="index.php?go=ranking&action=addmodify&gruppeid=<?php  echo $this->gruppe; ?>"  style="text-decoration: none;">
				<img align="top" alt="Gruppe bearbeiten" title="Gruppe bearbeiten" src="icons_modify.png" width="18px;"/>
			</a>
		<?php  } ?>
	</form>

<?php } ?>

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
	<?php  
		$previousRank = 0;
		
		if($this->rankingArray != null){
			$hasWinLinePainted = false;
			foreach($this->rankingArray as $ranking): 
	?>
			
	<?php  		
				if(!$hasWinLinePainted && $userDependentWinLine < $ranking['now']){
	?>
					<tr>
						<td colspan="5">
							<hr/>
						</td>
					</tr>	
	<?php 
					$hasWinLinePainted = true;
				}
	?>		
				<tr style="background-color: <?php  if($_SESSION['userid'] == $ranking['userid']){ echo 'yellow'; } ?>;">
					<td>
						<?php 
							if($ranking['now'] != 0){
								if($previousRank == 0 || $previousRank != $ranking['now']){
									$previousRank = $ranking['now'];
									echo $ranking['now'];
						?>
									.
						<?php 
								}
							}
						?>
					</td>
					<td>
						<?php 
							if($ranking['now'] > $ranking['last']){
								$diff = $ranking['now'] - $ranking['last'];
						?>
								<img alt="" src="icons_down.png" width="15px;"/>
								(-<?php echo $diff;?>)
						<?php 	
							}
							else if($ranking['now'] < $ranking['last']){
								$diff = $ranking['last'] - $ranking['now'];
						?>
								<img alt="" src="icons_up.png" width="15px;"/>
								(+<?php echo $diff;?>)
						<?php 	
							}
							else{
						?>
								<img alt="" src="icons_right.png" width="15px;"/>
								(+0)
						<?php 	
							}
						?>
					</td>
					<?php 
						if($ranking['bezahlt'] == 0){
					?>
							<td style="padding-left: 20px; color:red">
								<?php 
									if($_SESSION['eingeloggt']){
								?>
										<a href="index.php?go=otherTipps&action=getTipps&id=<?php  echo $ranking['userid']+5; ?>" style="color:red">
											<?php echo $ranking['nachname'] ?>
										</a>
								<?php 
									}
									else{
								?>
										<?php echo $ranking['nachname'] ?>
								<?php 
									}
								?>
							</td>
							<td style="padding-left: 20px; color: red">
								<?php echo $ranking['vorname']?>
							</td>
					<?php 
						}
						else{
					?>
							<td style="padding-left: 20px;">
								<?php 
									if($_SESSION['eingeloggt']){
								?>
										<a href="index.php?go=otherTipps&action=getTipps&id=<?php  echo $ranking['userid']+5; ?>">
											<?php echo $ranking['nachname'] ?>
										</a>
								<?php 
									}
									else{
								?>
										<?php echo $ranking['nachname'] ?>
								<?php 
									}
								?>
							</td>
							<td style="padding-left: 20px;">
								<?php echo $ranking['vorname']?>
							</td>
					<?php 
						}
					?>
					<td style="padding-left: 20px" align="right">
						<?php echo $ranking['punkte'] ?>
					</td>
				</tr>
	<?php 
			endforeach; 
		}
	?>
</table>