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
	 	$viertel1 = $this->viertelfinal1; 
	 	$viertel2 = $this->viertelfinal2; 
	 	$viertel3 = $this->viertelfinal3; 
	 	$viertel4 = $this->viertelfinal4; 
	 	$viertel5 = $this->viertelfinal5; 
	 	$viertel6 = $this->viertelfinal6; 
	 	$viertel7 = $this->viertelfinal7; 
	 	$viertel8 = $this->viertelfinal8; 
	 	$halb1 = $this->halbfinal1; 
	 	$halb2 = $this->halbfinal2; 
	 	$halb3 = $this->halbfinal3; 
	 	$halb4 = $this->halbfinal4; 
	 	$final1 = $this->final1; 
	 	$final2 = $this->final2; 
	 	$sieger = $this->sieger; 
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
		
		<b>Viertelfinalteilnehmer</b>
		<table>
			<tr>
				<td>Team 1</td>
				<td>Team 2</td>
				<td>Team 3</td>
				<td>Team 4</td>
			</tr>
			<tr>
				<td>
					<select name="viertelfinal1">
						<option value=""></option>
						<?php foreach($this->countries as $country): ?>
							<?php  
								if($viertel1 == $country['id']){
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
					<select name="viertelfinal2">
						<option value=""></option>
						<?php foreach($this->countries as $country): ?>
							<?php  
								if($viertel2 == $country['id']){
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
					<select name="viertelfinal3">
						<option value=""></option>
						<?php foreach($this->countries as $country): ?>
							<?php  
								if($viertel3 == $country['id']){
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
					<select name="viertelfinal4">
						<option value=""></option>
						<?php foreach($this->countries as $country): ?>
							<?php  
								if($viertel4 == $country['id']){
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
					<select name="viertelfinal5">
						<option value=""></option>
						<?php foreach($this->countries as $country): ?>
							<?php  
								if($viertel5 == $country['id']){
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
					<select name="viertelfinal6">
						<option value=""></option>
						<?php foreach($this->countries as $country): ?>
							<?php  
								if($viertel6 == $country['id']){
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
					<select name="viertelfinal7">
						<option value=""></option>
						<?php foreach($this->countries as $country): ?>
							<?php  
								if($viertel7 == $country['id']){
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
					<select name="viertelfinal8">
						<option value=""></option>
						<?php foreach($this->countries as $country): ?>
							<?php  
								if($viertel8 == $country['id']){
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
		<b>Halbfinalteilnehmer</b>
		<table>
			<tr>
				<td>Team 1</td>
				<td>Team 2</td>
				<td>Team 3</td>
				<td>Team 4</td>
			</tr>
			<tr>
				<td>
					<select name="halbfinal1">
						<option value=""></option>
						<?php foreach($this->countries as $country): ?>
							<?php  
								if($halb1 == $country['id']){
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
					<select name="halbfinal2">
						<option value=""></option>
						<?php foreach($this->countries as $country): ?>
							<?php  
								if($halb2 == $country['id']){
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
					<select name="halbfinal3">
						<option value=""></option>
						<?php foreach($this->countries as $country): ?>
							<?php  
								if($halb3 == $country['id']){
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
					<select name="halbfinal4">
						<option value=""></option>
						<?php foreach($this->countries as $country): ?>
							<?php  
								if($halb4 == $country['id']){
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
		<b>Finalteilnehmer</b>
		<table>
			<tr>
				<td>Team 1</td>
				<td>Team 2</td>
			</tr>
			<tr>
				<td>
					<select name="final1">
						<option value=""></option>
						<?php foreach($this->countries as $country): ?>
							<?php  
								if($final1 == $country['id']){
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
					<select name="final2">
						<option value=""></option>
						<?php foreach($this->countries as $country): ?>
							<?php  
								if($final2 == $country['id']){
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
		<b><?php echo Constants::getWinnerLabel() ?></b>
		<table>
			<tr>
				<td>Team 1</td>
			</tr>
			<tr>
				<td>
					<select name="sieger">
						<option value=""></option>
						<?php foreach($this->countries as $country): ?>
							<?php  
								if($sieger == $country['id']){
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
