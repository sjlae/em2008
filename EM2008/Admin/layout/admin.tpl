<?php require_once('Layout/errors.tpl'); ?>

<h2>Admin</h2>
<h3>Zahlungen erfassen</h3>
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
				<td><input type="checkbox" name="user<?php echo $i; ?>" value="<?php echo $nnbUser['userid']; ?>" /></td>
				<td style="padding-left: 5px"><?php echo $nnbUser['nachname']; ?></td>
				<td style="padding-left: 5px"><?php echo $nnbUser['vorname']; ?></td>
				<td style="padding-left: 5px"><a href="mailto:<?php echo $nnbUser['email']; ?>"><?php echo $nnbUser['email']; ?></a></td>
			</tr>
			<?php $i++; ?>
			<?php endforeach; ?>
		</table>
		<input type="hidden" name="maxUser" value="<?php echo $i-1; ?>" />
		<input type="submit" value="Erfassen" />
	</form>
<h3>Resultate erfassen</h3>
	<? $viertel1 = $this->viertelfinal1; ?>
	<? $viertel2 = $this->viertelfinal2; ?>
	<? $viertel3 = $this->viertelfinal3; ?>
	<? $viertel4 = $this->viertelfinal4; ?>
	<? $viertel5 = $this->viertelfinal5; ?>
	<? $viertel6 = $this->viertelfinal6; ?>
	<? $viertel7 = $this->viertelfinal7; ?>
	<? $viertel8 = $this->viertelfinal8; ?>
	<? $halb1 = $this->halbfinal1; ?>
	<? $halb2 = $this->halbfinal2; ?>
	<? $halb3 = $this->halbfinal3; ?>
	<? $halb4 = $this->halbfinal4; ?>
	<? $final1 = $this->final1; ?>
	<? $final2 = $this->final2; ?>
	<? $europameister = $this->europameister; ?>
	<form action="index.php?go=admin&action=results" method="POST">
		<table border="0">
			<tr>
				<td align="center" style="white-space: nowrap"><b>#</b></td>
				<td style="white-space: nowrap; padding-left: 5px"><b>Datum</b></td>
				<td style="white-space: nowrap; padding-left: 5px"><b>Team 1</b></td>
				<td style="white-space: nowrap; padding-left: 5px"><b>Team 2</b></td>
				<td style="white-space: nowrap; padding-left: 5px"><b>Res. 1</b></td>
				<td />
				<td style="white-space: nowrap; padding-left: 5px"><b>Res. 2</b></td>
			</tr>
			<?php foreach($this->vorrunde as $spiel): ?>
			<tr>
				<td align="center"><?php echo $spiel['id']; ?></td>
				<td style="white-space: nowrap; padding-left: 5px"><?php echo $spiel['start']; ?></td>
				<td style="white-space: nowrap; padding-left: 5px"><?php echo $spiel['team1']; ?></td>
				<td style="white-space: nowrap; padding-left: 5px"><?php echo $spiel['team2']; ?></td>
				<td align="center" style="white-space: nowrap; padding-left: 5px"><input type="text" style="width: 15px" value="<?php echo $spiel['realresult1']; ?>" name="result1_<?php echo $spiel['id']; ?>" /></td>
				<td>:</td>
				<td align="center" style="white-space: nowrap; padding-left: 5px"><input type="text" style="width: 15px" value="<?php echo $spiel['realresult2']; ?>" name="result2_<?php echo $spiel['id']; ?>" /></td>
			</tr>
			<?php endforeach; ?>
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
						<?foreach($this->countries as $country): ?>
							<? 
								if($viertel1 == $country['id']){
							?>
									<option value="<?echo $country['id'] ?>" selected><?echo $country['land'] ?></option>
							<?
								}
								else{
							?>
									<option value="<?echo $country['id'] ?>"><?echo $country['land'] ?></option>
							<?
								}
							?>
						<?endforeach; ?>
					</select>
				</td>
				<td>
					<select name="viertelfinal2">
						<option value=""></option>
						<?foreach($this->countries as $country): ?>
							<? 
								if($viertel2 == $country['id']){
							?>
									<option value="<?echo $country['id'] ?>" selected><?echo $country['land'] ?></option>
							<?
								}
								else{
							?>
									<option value="<?echo $country['id'] ?>"><?echo $country['land'] ?></option>
							<?
								}
							?>
						<?endforeach; ?>
					</select>
				</td>
				<td>
					<select name="viertelfinal3">
						<option value=""></option>
						<?foreach($this->countries as $country): ?>
							<? 
								if($viertel3 == $country['id']){
							?>
									<option value="<?echo $country['id'] ?>" selected><?echo $country['land'] ?></option>
							<?
								}
								else{
							?>
									<option value="<?echo $country['id'] ?>"><?echo $country['land'] ?></option>
							<?
								}
							?>
						<?endforeach; ?>
					</select>
				</td>
				<td>
					<select name="viertelfinal4">
						<option value=""></option>
						<?foreach($this->countries as $country): ?>
							<? 
								if($viertel4 == $country['id']){
							?>
									<option value="<?echo $country['id'] ?>" selected><?echo $country['land'] ?></option>
							<?
								}
								else{
							?>
									<option value="<?echo $country['id'] ?>"><?echo $country['land'] ?></option>
							<?
								}
							?>
						<?endforeach; ?>
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
						<?foreach($this->countries as $country): ?>
							<? 
								if($viertel5 == $country['id']){
							?>
									<option value="<?echo $country['id'] ?>" selected><?echo $country['land'] ?></option>
							<?
								}
								else{
							?>
									<option value="<?echo $country['id'] ?>"><?echo $country['land'] ?></option>
							<?
								}
							?>
						<?endforeach; ?>
					</select>
				</td>
				<td>
					<select name="viertelfinal6">
						<option value=""></option>
						<?foreach($this->countries as $country): ?>
							<? 
								if($viertel6 == $country['id']){
							?>
									<option value="<?echo $country['id'] ?>" selected><?echo $country['land'] ?></option>
							<?
								}
								else{
							?>
									<option value="<?echo $country['id'] ?>"><?echo $country['land'] ?></option>
							<?
								}
							?>
						<?endforeach; ?>
					</select>
				</td>
				<td>
					<select name="viertelfinal7">
						<option value=""></option>
						<?foreach($this->countries as $country): ?>
							<? 
								if($viertel7 == $country['id']){
							?>
									<option value="<?echo $country['id'] ?>" selected><?echo $country['land'] ?></option>
							<?
								}
								else{
							?>
									<option value="<?echo $country['id'] ?>"><?echo $country['land'] ?></option>
							<?
								}
							?>
						<?endforeach; ?>
					</select>
				</td>
				<td>
					<select name="viertelfinal8">
						<option value=""></option>
						<?foreach($this->countries as $country): ?>
							<? 
								if($viertel8 == $country['id']){
							?>
									<option value="<?echo $country['id'] ?>" selected><?echo $country['land'] ?></option>
							<?
								}
								else{
							?>
									<option value="<?echo $country['id'] ?>"><?echo $country['land'] ?></option>
							<?
								}
							?>
						<?endforeach; ?>
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
						<?foreach($this->countries as $country): ?>
							<? 
								if($halb1 == $country['id']){
							?>
									<option value="<?echo $country['id'] ?>" selected><?echo $country['land'] ?></option>
							<?
								}
								else{
							?>
									<option value="<?echo $country['id'] ?>"><?echo $country['land'] ?></option>
							<?
								}
							?>
						<?endforeach; ?>
					</select>
				</td>
				<td>
					<select name="halbfinal2">
						<option value=""></option>
						<?foreach($this->countries as $country): ?>
							<? 
								if($halb2 == $country['id']){
							?>
									<option value="<?echo $country['id'] ?>" selected><?echo $country['land'] ?></option>
							<?
								}
								else{
							?>
									<option value="<?echo $country['id'] ?>"><?echo $country['land'] ?></option>
							<?
								}
							?>
						<?endforeach; ?>
					</select>
				</td>
				<td>
					<select name="halbfinal3">
						<option value=""></option>
						<?foreach($this->countries as $country): ?>
							<? 
								if($halb3 == $country['id']){
							?>
									<option value="<?echo $country['id'] ?>" selected><?echo $country['land'] ?></option>
							<?
								}
								else{
							?>
									<option value="<?echo $country['id'] ?>"><?echo $country['land'] ?></option>
							<?
								}
							?>
						<?endforeach; ?>
					</select>
				</td>
				<td>
					<select name="halbfinal4">
						<option value=""></option>
						<?foreach($this->countries as $country): ?>
							<? 
								if($halb4 == $country['id']){
							?>
									<option value="<?echo $country['id'] ?>" selected><?echo $country['land'] ?></option>
							<?
								}
								else{
							?>
									<option value="<?echo $country['id'] ?>"><?echo $country['land'] ?></option>
							<?
								}
							?>
						<?endforeach; ?>
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
						<?foreach($this->countries as $country): ?>
							<? 
								if($final1 == $country['id']){
							?>
									<option value="<?echo $country['id'] ?>" selected><?echo $country['land'] ?></option>
							<?
								}
								else{
							?>
									<option value="<?echo $country['id'] ?>"><?echo $country['land'] ?></option>
							<?
								}
							?>
						<?endforeach; ?>
					</select>
				</td>
				<td>
					<select name="final2">
						<option value=""></option>
						<?foreach($this->countries as $country): ?>
							<? 
								if($final2 == $country['id']){
							?>
									<option value="<?echo $country['id'] ?>" selected><?echo $country['land'] ?></option>
							<?
								}
								else{
							?>
									<option value="<?echo $country['id'] ?>"><?echo $country['land'] ?></option>
							<?
								}
							?>
						<?endforeach; ?>
					</select>
				</td>
			</tr>
		</table>
		<br>
		<b>Europameister</b>
		<table>
			<tr>
				<td>Team 1</td>
			</tr>
			<tr>
				<td>
					<select name="europameister">
						<option value=""></option>
						<?foreach($this->countries as $country): ?>
							<? 
								if($europameister == $country['id']){
							?>
									<option value="<?echo $country['id'] ?>" selected><?echo $country['land'] ?></option>
							<?
								}
								else{
							?>
									<option value="<?echo $country['id'] ?>"><?echo $country['land'] ?></option>
							<?
								}
							?>
						<?endforeach; ?>
					</select>
				</td>
			</tr>
		</table>
		<div style="padding-top: 5px"><input type="submit" value="Aktualisieren" /></div>
	</form>
<h3>News erfassen</h3>
	<form action="index.php?go=admin&action=news" method="POST">
		<table>
			<tr>
				<td>Titel</td>
			</tr>
			<tr>
				<td>
					<input type="text" name="newsTitle" size="60" />
				</td>
			</tr>
			<tr>
				<td>Text</td>
			</tr>
			<tr>
				<td>
					<textarea name="newsText" cols="50" rows="10"></textarea>
				</td>
			</tr>
			
		</table>
		<input type="submit" value="Erfassen" />
	</form>	
