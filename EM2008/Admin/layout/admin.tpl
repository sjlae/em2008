<?php require_once('Layout/errors.tpl'); ?>
<?php require_once('Layout/Tabs.php'); ?>
<?php require_once('Constants.php'); ?>

<h2>Admin</h2>

<?php $tabs = new Tabs("Tabs"); ?>
<?php $tabs->start("Zahlungen"); ?>

	<form action="index.php?go=admin&action=nnb" method="POST">
		<table>
			<tr>
				<td></td>
				<td style="padding-left: 5px"><b>Nachname</b></td>
				<td style="padding-left: 5px"><b>Vorname</b></td>
				<td style="padding-left: 5px"><b>Email</b></td>
			</tr>
			<?php $i=0; ?>
			<?php foreach($this->nnb as $nnbUser): ?>
			<tr>
				<td><input type="checkbox" name="users_nnb[]" value="<?php echo $nnbUser['userid']; ?>" /></td>
				<td style="padding-left: 5px"><?php echo $nnbUser['nachname']; ?></td>
				<td style="padding-left: 5px"><?php echo $nnbUser['vorname']; ?></td>
				<td style="padding-left: 5px"><a href="mailto:<?php echo $nnbUser['email']; ?>"><?php echo $nnbUser['email']; ?></a></td>
			</tr>
			<?php $i++; ?>
			<?php endforeach; ?>
		</table>
		<input type="submit" value="Erfassen" />
	</form>
	<?php if($_GET['action'] == 'nnb'){ $tabs->active = "Zahlungen"; } ?>
	
<?php $tabs->end(); ?>
<?php $tabs->start("Resultate"); ?>

	<?php 
		$achtel1 = $this->achtelfinal1; 
		$achtel2 = $this->achtelfinal2; 
		$achtel3 = $this->achtelfinal3; 
		$achtel4 = $this->achtelfinal4; 
		$achtel5 = $this->achtelfinal5; 
		$achtel6 = $this->achtelfinal6; 
		$achtel7 = $this->achtelfinal7; 
		$achtel8 = $this->achtelfinal8; 
		$achtel9 = $this->achtelfinal9; 
		$achtel10 = $this->achtelfinal10; 
		$achtel11 = $this->achtelfinal11; 
		$achtel12 = $this->achtelfinal12; 
		$achtel13 = $this->achtelfinal13; 
		$achtel14 = $this->achtelfinal14; 
		$achtel15 = $this->achtelfinal15; 
		$achtel16 = $this->achtelfinal16; 
	 	$winner = $this->winner;
	 	$best = $this->best;
	 	$worst = $this->worst;
	 	$switzerland = $this->switzerland;
	 	$lastwinner = $this->lastwinner;
	?>
	<form action="index.php?go=admin&action=results" method="POST">
		<table border="0">
			<tr>
				<td style="white-space: nowrap; padding-left: 5px"><b>Datum</b></td>
				<td style="white-space: nowrap; padding-left: 5px"><b>Team 1</b></td>
				<td style="white-space: nowrap; padding-left: 5px"><b>Team 2</b></td>
				<td style="white-space: nowrap; padding-left: 5px"><b>Res. 1</b></td>
				<td />
				<td style="white-space: nowrap; padding-left: 5px"><b>Res. 2</b></td>
			</tr>
			<?php foreach($this->vorrunde as $spiel): ?>
			<tr>
				<td style="white-space: nowrap; padding-left: 5px"><?php echo $spiel['start']; ?></td>
				<td style="white-space: nowrap; padding-left: 5px">
					<?php if(!is_numeric($spiel['team1id'])){ ?>
						<select name="<?php echo $spiel['id'] .'_1'; ?>">
							<option value="<?php echo $spiel['team1']; ?>"><?php echo $spiel['team1']; ?></option>
							<?php foreach($this->countries as $country): ?>
								<?php  
									if($spiel['team1id'] == $country['id']){
								?>
										<option value="<?php echo $country['id'] ?>" selected><?php echo $country['land'] ?></option>
								<?php 
									}
									else{
								?>
										<option value="<?php echo $country['id'] ?>"><?php echo $country['land'] ?></option>
								<?php 
									}
								?>
							<?php endforeach; ?>
						</select>
					<?php }
						else{ echo $spiel['team1']; } ?>
				</td>
				<td style="white-space: nowrap; padding-left: 5px">
					<?php if(!is_numeric($spiel['team2id'])){ ?>
						<select name="<?php echo $spiel['id'] .'_2'; ?>">
							<option value="<?php echo $spiel['team2']; ?>"><?php echo $spiel['team2']; ?></option>
							<?php foreach($this->countries as $country): ?>
								<?php  
									if($spiel['team2id'] == $country['id']){
								?>
										<option value="<?php echo $country['id'] ?>" selected><?php echo $country['land'] ?></option>
								<?php 
									}
									else{
								?>
										<option value="<?php echo $country['id'] ?>"><?php echo $country['land'] ?></option>
								<?php 
									}
								?>
							<?php endforeach; ?>
						</select>
					<?php }
						else{ echo $spiel['team2']; } ?>
				</td>
				<td align="center" style="white-space: nowrap; padding-left: 5px"><input type="text" style="width: 15px" value="<?php echo $spiel['realresult1']; ?>" name="result1_<?php echo $spiel['id']; ?>" /></td>
				<td>:</td>
				<td align="center" style="white-space: nowrap; padding-left: 5px"><input type="text" style="width: 15px" value="<?php echo $spiel['realresult2']; ?>" name="result2_<?php echo $spiel['id']; ?>" /></td>
			</tr>
			<?php endforeach; ?>
		</table>
		<br>
			<b>Achtelfinalteilnehmer</b>
			<table>
				<tr>
					<td>Team 1</td>
					<td>Team 2</td>
					<td>Team 3</td>
					<td>Team 4</td>
				</tr>
				<tr>
					<td>
						<select name="achtelfinal1">
							<option value=""></option>
							<?php foreach($this->countries as $country): ?>
								<?php  
									if($achtel1 == $country['id']){
								?>
										<option value="<?php echo $country['id'] ?>" selected><?php echo $country['land'] ?></option>
								<?php 
									}
									else{
								?>
										<option value="<?php echo $country['id'] ?>"><?php echo $country['land'] ?></option>
								<?php 
									}
								?>
							<?php endforeach; ?>
						</select>
					</td>
					<td>
						<select name="achtelfinal2">
							<option value=""></option>
							<?php foreach($this->countries as $country): ?>
								<?php  
									if($achtel2 == $country['id']){
								?>
										<option value="<?php echo $country['id'] ?>" selected><?php echo $country['land'] ?></option>
								<?php 
									}
									else{
								?>
										<option value="<?php echo $country['id'] ?>"><?php echo $country['land'] ?></option>
								<?php 
									}
								?>
							<?php endforeach; ?>
						</select>
					</td>
					<td>
						<select name="achtelfinal3">
							<option value=""></option>
							<?php foreach($this->countries as $country): ?>
								<?php  
									if($achtel3 == $country['id']){
								?>
										<option value="<?php echo $country['id'] ?>" selected><?php echo $country['land'] ?></option>
								<?php 
									}
									else{
								?>
										<option value="<?php echo $country['id'] ?>"><?php echo $country['land'] ?></option>
								<?php 
									}
								?>
							<?php endforeach; ?>
						</select>
					</td>
					<td>
						<select name="achtelfinal4">
							<option value=""></option>
							<?php foreach($this->countries as $country): ?>
								<?php  
									if($achtel4 == $country['id']){
								?>
										<option value="<?php echo $country['id'] ?>" selected><?php echo $country['land'] ?></option>
								<?php 
									}
									else{
								?>
										<option value="<?php echo $country['id'] ?>"><?php echo $country['land'] ?></option>
								<?php 
									}
								?>
							<?php endforeach; ?>
						</select>
					</td>
				</tr>
				<tr>
					<td>Team 5</td>
					<td>Team 6</td>
					<td>Team 7</td>
					<td>Team 8</td>
				</tr>
				<tr>
					<td>
						<select name="achtelfinal5">
							<option value=""></option>
							<?php foreach($this->countries as $country): ?>
								<?php  
									if($achtel5 == $country['id']){
								?>
										<option value="<?php echo $country['id'] ?>" selected><?php echo $country['land'] ?></option>
								<?php 
									}
									else{
								?>
										<option value="<?php echo $country['id'] ?>"><?php echo $country['land'] ?></option>
								<?php 
									}
								?>
							<?php endforeach; ?>
						</select>
					</td>
					<td>
						<select name="achtelfinal6">
							<option value=""></option>
							<?php foreach($this->countries as $country): ?>
								<?php  
									if($achtel6 == $country['id']){
								?>
										<option value="<?php echo $country['id'] ?>" selected><?php echo $country['land'] ?></option>
								<?php 
									}
									else{
								?>
										<option value="<?php echo $country['id'] ?>"><?php echo $country['land'] ?></option>
								<?php 
									}
								?>
							<?php endforeach; ?>
						</select>
					</td>
					<td>
						<select name="achtelfinal7">
							<option value=""></option>
							<?php foreach($this->countries as $country): ?>
								<?php  
									if($achtel7 == $country['id']){
								?>
										<option value="<?php echo $country['id'] ?>" selected><?php echo $country['land'] ?></option>
								<?php 
									}
									else{
								?>
										<option value="<?php echo $country['id'] ?>"><?php echo $country['land'] ?></option>
								<?php 
									}
								?>
							<?php endforeach; ?>
						</select>
					</td>
					<td>
						<select name="achtelfinal8">
							<option value=""></option>
							<?php foreach($this->countries as $country): ?>
								<?php  
									if($achtel8 == $country['id']){
								?>
										<option value="<?php echo $country['id'] ?>" selected><?php echo $country['land'] ?></option>
								<?php 
									}
									else{
								?>
										<option value="<?php echo $country['id'] ?>"><?php echo $country['land'] ?></option>
								<?php 
									}
								?>
							<?php endforeach; ?>
						</select>
					</td>
				</tr>
				<tr>
					<td>Team 9</td>
					<td>Team 10</td>
					<td>Team 11</td>
					<td>Team 12</td>
				</tr>
				<tr>
					<td>
						<select name="achtelfinal9">
							<option value=""></option>
							<?php foreach($this->countries as $country): ?>
								<?php  
									if($achtel9 == $country['id']){
								?>
										<option value="<?php echo $country['id'] ?>" selected><?php echo $country['land'] ?></option>
								<?php 
									}
									else{
								?>
										<option value="<?php echo $country['id'] ?>"><?php echo $country['land'] ?></option>
								<?php 
									}
								?>
							<?php endforeach; ?>
						</select>
					</td>
					<td>
						<select name="achtelfinal10">
							<option value=""></option>
							<?php foreach($this->countries as $country): ?>
								<?php  
									if($achtel10 == $country['id']){
								?>
										<option value="<?php echo $country['id'] ?>" selected><?php echo $country['land'] ?></option>
								<?php 
									}
									else{
								?>
										<option value="<?php echo $country['id'] ?>"><?php echo $country['land'] ?></option>
								<?php 
									}
								?>
							<?php endforeach; ?>
						</select>
					</td>
					<td>
						<select name="achtelfinal11">
							<option value=""></option>
							<?php foreach($this->countries as $country): ?>
								<?php  
									if($achtel11 == $country['id']){
								?>
										<option value="<?php echo $country['id'] ?>" selected><?php echo $country['land'] ?></option>
								<?php 
									}
									else{
								?>
										<option value="<?php echo $country['id'] ?>"><?php echo $country['land'] ?></option>
								<?php 
									}
								?>
							<?php endforeach; ?>
						</select>
					</td>
					<td>
						<select name="achtelfinal12">
							<option value=""></option>
							<?php foreach($this->countries as $country): ?>
								<?php  
									if($achtel12 == $country['id']){
								?>
										<option value="<?php echo $country['id'] ?>" selected><?php echo $country['land'] ?></option>
								<?php 
									}
									else{
								?>
										<option value="<?php echo $country['id'] ?>"><?php echo $country['land'] ?></option>
								<?php 
									}
								?>
							<?php endforeach; ?>
						</select>
					</td>
				</tr>
				<tr>
					<td>Team 13</td>
					<td>Team 14</td>
					<td>Team 15</td>
					<td>Team 16</td>
				</tr>
				<tr>
					<td>
						<select name="achtelfinal13">
							<option value=""></option>
							<?php foreach($this->countries as $country): ?>
								<?php  
									if($achtel13 == $country['id']){
								?>
										<option value="<?php echo $country['id'] ?>" selected><?php echo $country['land'] ?></option>
								<?php 
									}
									else{
								?>
										<option value="<?php echo $country['id'] ?>"><?php echo $country['land'] ?></option>
								<?php 
									}
								?>
							<?php endforeach; ?>
						</select>
					</td>
					<td>
						<select name="achtelfinal14">
							<option value=""></option>
							<?php foreach($this->countries as $country): ?>
								<?php  
									if($achtel14 == $country['id']){
								?>
										<option value="<?php echo $country['id'] ?>" selected><?php echo $country['land'] ?></option>
								<?php 
									}
									else{
								?>
										<option value="<?php echo $country['id'] ?>"><?php echo $country['land'] ?></option>
								<?php 
									}
								?>
							<?php endforeach; ?>
						</select>
					</td>
					<td>
						<select name="achtelfinal15">
							<option value=""></option>
							<?php foreach($this->countries as $country): ?>
								<?php  
									if($achtel15 == $country['id']){
								?>
										<option value="<?php echo $country['id'] ?>" selected><?php echo $country['land'] ?></option>
								<?php 
									}
									else{
								?>
										<option value="<?php echo $country['id'] ?>"><?php echo $country['land'] ?></option>
								<?php 
									}
								?>
							<?php endforeach; ?>
						</select>
					</td>
					<td>
						<select name="achtelfinal16">
							<option value=""></option>
							<?php foreach($this->countries as $country): ?>
								<?php  
									if($achtel16 == $country['id']){
								?>
										<option value="<?php echo $country['id'] ?>" selected><?php echo $country['land'] ?></option>
								<?php 
									}
									else{
								?>
										<option value="<?php echo $country['id'] ?>"><?php echo $country['land'] ?></option>
								<?php 
									}
								?>
							<?php endforeach; ?>
						</select>
					</td>
				</tr>
			</table>
			<br>	
		
			<h4>Welches wird das <i>beste</i> Team der Vorrunde?</h4>
			<select name="best" id="best" style="width: 110px;">
				<option value=''></option>
				<?php foreach($this->countries as $country): ?>
					<?php if($this->best == $country['id']): ?>
						<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
					<?php else:?>
						<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
					<?php endif; ?>
				<?php endforeach; ?>
			</select>
			
			<h4>Welches wird das <i>schlechteste</i> Team der Vorrunde?</h4>
			<select name="worst" id="worst" style="width: 110px;">
				<option value=''></option>
				<?php foreach($this->countries as $country): ?>
					<?php if($this->worst == $country['id']): ?>
						<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
					<?php else:?>
						<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
					<?php endif; ?>
				<?php endforeach; ?>
			</select>
			
			<h4>Wie weit kommt die <i>Schweiz</i> im Turnier?</h4>
			<select name="switzerland" id="switzerland" style="width: 200px;">
				<option value=''></option>
				<?php foreach($this->phases as $phase): ?>
					<?php if($this->switzerland == $phase['id']): ?>
						<option value="<?php echo $phase['id']; ?>" selected><?php echo $phase['beschreibung']; ?></option>
					<?php else:?>
						<option value="<?php echo $phase['id']; ?>"><?php echo $phase['beschreibung']; ?></option>
					<?php endif; ?>
				<?php endforeach; ?>
			</select>
			
			<h4>Wie weit kommt der Titelverteidiger <i>Deutschland</i> im Turnier?</h4>
			<select name="lastwinner" id="lastwinner" style="width: 200px;">
				<option value=''></option>
				<?php foreach($this->phases as $phase): ?>
					<?php if($this->lastwinner == $phase['id']): ?>
						<option value="<?php echo $phase['id']; ?>" selected><?php echo $phase['beschreibung']; ?></option>
					<?php else:?>
						<option value="<?php echo $phase['id']; ?>"><?php echo $phase['beschreibung']; ?></option>
					<?php endif; ?>
				<?php endforeach; ?>
			</select>
			
			<h4>Wer wird <?php echo Constants::$winnerLabel; ?>?</h4>
			<select name="winner" id="winner" style="width: 110px;">
				<option value=''></option>
				<?php foreach($this->countries as $country): ?>
					<?php if($this->winner == $country['id']): ?>
						<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
					<?php else:?>
						<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
					<?php endif; ?>
				<?php endforeach; ?>
			</select>
		
		<div style="padding-top: 5px"><input type="submit" value="Aktualisieren" /></div>
	</form>
	<?php if($_GET['action'] == 'results'){ $tabs->active = "Resultate"; } ?>
	
<?php $tabs->end(); ?>
<?php $tabs->start("News"); ?>
	
	<form action="index.php?go=admin&action=news" method="POST">
		<table width="100%">
			<tr>
				<td>Titel</td>
			</tr>
			<tr>
				<td>
					<input type="text" name="newsTitle" style="width: 100%;"/>
				</td>
			</tr>
			<tr>
				<td>Text</td>
			</tr>
			<tr>
				<td>
					<textarea name="newsText" cols="50" rows="10" style="width: 100%;"></textarea>
				</td>
			</tr>
			
		</table>
		<input type="submit" value="Erfassen" />
	</form>
	<?php if($_GET['action'] == 'news'){ $tabs->active = "News"; } ?>
	
<?php $tabs->end(); ?>
<?php $tabs->start("Loeschen"); ?>
	
	<form action="index.php?go=admin&action=delete" method="POST">
		<table>
			<tr>
				<td></td>
				<td style="padding-left: 5px"><b>Nachname</b></td>
				<td style="padding-left: 5px"><b>Vorname</b></td>
				<td style="padding-left: 5px"><b>Email</b></td>
			</tr>
			<?php $i=0; ?>
			<?php foreach($this->all as $allUser): ?>
			<tr>
				<td><input type="checkbox" name="users_delete[]" value="<?php echo $allUser['userid']; ?>" /></td>
				<td style="padding-left: 5px"><?php echo $allUser['nachname']; ?></td>
				<td style="padding-left: 5px"><?php echo $allUser['vorname']; ?></td>
				<td style="padding-left: 5px"><a href="mailto:<?php echo $allUser['email']; ?>"><?php echo $allUser['email']; ?></a></td>
			</tr>
			<?php $i++; ?>
			<?php endforeach; ?>
		</table>
		<input type="submit" value="L&ouml;schen" />
	</form>
	<?php if($_GET['action'] == 'delete'){ $tabs->active = "Loeschen"; } ?>
	
<?php $tabs->end(); ?>
<?php $tabs->start("Not Tipped"); ?>
	
	<form action="index.php?go=admin&action=notTipped" method="POST">
		<table>
			<tr>
				<td><b>Email</b></td>
			</tr>
			<?php $i=0; ?>
			<?php foreach($this->notTipped as $user): ?>
				<tr>
					<td><?php echo $user['email']; ?></td>
				</tr>
				<?php $i++; ?>
			<?php endforeach; ?>
		</table>
	</form>
	
<?php $tabs->end(); ?>
<?php $tabs->run(); ?>
