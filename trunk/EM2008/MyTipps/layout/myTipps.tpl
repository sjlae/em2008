<h2>Meine Tipps</h2>
<form action="index.php?go=myTipps&action=setTipps" method="POST">
<table border="0">
	<tr>
		<td align="center" style="white-space: nowrap"><b>#</b></td>
		<td style="white-space: nowrap"><b>Datum</b></td>
		<td style="white-space: nowrap"><b>Team 1</b></td>
		<td style="white-space: nowrap"><b>Team 2</b></td>
		<td style="white-space: nowrap"><b>Tipp 1</b></td>
		<td />
		
		
		<td style="white-space: nowrap"><b>Tipp 2</b></td>
		<td style="white-space: nowrap"><b>Res. 1</b></td>
		<td />
		
		
		<td style="white-space: nowrap"><b>Res. 2</b></td>
	</tr>
	<?php foreach($this->vorrunde as $spiel): ?>
	<tr>
		<td align="center"><?php echo $spiel['id']; ?></td>
		<td><?php echo $spiel['start']; ?></td>
		<td><?php echo $spiel['team1']; ?></td>
		<td><?php echo $spiel['team2']; ?></td>
		<td align="center"><input type="text" style="width: 15px"
			value="<?php echo $spiel['result1']; ?>"
			<?php echo $spiel['disabled']; ?>
			name="result1<?php echo $spiel['id']; ?>" /></td>
		<td>:</td>
		<td align="center"><input type="text" style="width: 15px"
			value="<?php echo $spiel['result2']; ?>"
			<?php echo $spiel['disabled']; ?>
			name="result2<?php echo $spiel['id']; ?>" /></td>
		<td align="center"><?php echo $spiel['realresult1']; ?></td>
		<td>:</td>
		<td align="center"><?php echo $spiel['realresult2']; ?></td>
	</tr>
	<?php endforeach; ?>
</table>
<h3>Viertelfinalteilnehmer</h3>
<table>
	<tr>
		<td>Team 1</td>
		<td>Team 2</td>
		<td>Team 3</td>
		<td>Team 4</td>
	</tr>
	<tr>
		<td><select name="viertelfinal1">
			<option value=''></option>
			<?foreach($this->countries as $country): ?>
			<?php if($this->userViertelfinal[1] == $country['id']): ?>
			<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
			<?php else:?>
			<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
			<?php endif; ?>
			<?endforeach; ?>
		</select></td>
		<td><select name="viertelfinal2">
			<option value=''></option>
			<?foreach($this->countries as $country): ?>
			<?php if($this->userViertelfinal[2] == $country['id']): ?>
			<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
			<?php else:?>
			<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
			<?php endif; ?>
			<?endforeach; ?>
		</select></td>
		<td><select name="viertelfinal3">
			<option value=''></option>
			<?foreach($this->countries as $country): ?>
			<?php if($this->userViertelfinal[3] == $country['id']): ?>
			<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
			<?php else:?>
			<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
			<?php endif; ?>
			<?endforeach; ?>
		</select></td>
		<td><select name="viertelfinal4">
			<option value=''></option>
			<?foreach($this->countries as $country): ?>
			<?php if($this->userViertelfinal[4] == $country['id']): ?>
			<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
			<?php else:?>
			<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
			<?php endif; ?>
			<?php endforeach; ?>
		</select></td>
	</tr>
	<tr>
		<td>Team 5</td>
		<td>Team 6</td>
		<td>Team 7</td>
		<td>Team 8</td>
	</tr>
	<tr>
		<td><select name="viertelfinal5">
			<option value=''></option>
			<?foreach($this->countries as $country): ?>
			<?php if($this->userViertelfinal[5] == $country['id']): ?>
			<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
			<?php else:?>
			<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
			<?php endif; ?>
			<?php endforeach; ?>
		</select></td>
		<td><select name="viertelfinal6">
			<option value=''></option>
			<?foreach($this->countries as $country): ?>
			<?php if($this->userViertelfinal[6] == $country['id']): ?>
			<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
			<?php else:?>
			<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
			<?php endif; ?>
			<?php endforeach; ?>
		</select></td>
		<td><select name="viertelfinal7">
			<option value=''></option>
			<?foreach($this->countries as $country): ?>
			<?php if($this->userViertelfinal[7] == $country['id']): ?>
			<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
			<?php else:?>
			<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
			<?php endif; ?>
			<?php endforeach; ?>
		</select></td>
		<td><select name="viertelfinal8">
			<option value=''></option>
			<?foreach($this->countries as $country): ?>
			<?php if($this->userViertelfinal[8] == $country['id']): ?>
			<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
			<?php else:?>
			<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
			<?php endif; ?>
			<?php endforeach; ?>
		</select></td>
	</tr>
</table>
<h3>Halbfinalteilnehmer</h3>
<table>
	<tr>
		<td>Team 1</td>
		<td>Team 2</td>
		<td>Team 3</td>
		<td>Team 4</td>
	</tr>
	<tr>
		<td><select name="halbfinal1">
			<option value=''></option>
			<?foreach($this->countries as $country): ?>
			<?php if($this->userHalbfinal[1] == $country['id']): ?>
			<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
			<?php else:?>
			<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
			<?php endif; ?>
			<?php endforeach; ?>
		</select></td>
		<td><select name="halbfinal2">
			<option value=''></option>
			<?foreach($this->countries as $country): ?>
			<?php if($this->userHalbfinal[2] == $country['id']): ?>
			<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
			<?php else:?>
			<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
			<?php endif; ?>
			<?php endforeach; ?>
		</select></td>
		<td><select name="halbfinal3">
			<option value=''></option>
			<?foreach($this->countries as $country): ?>
			<?php if($this->userHalbfinal[3] == $country['id']): ?>
			<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
			<?php else:?>
			<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
			<?php endif; ?>
			<?php endforeach; ?>
		</select></td>
		<td><select name="halbfinal4">
			<option value=''></option>
			<?foreach($this->countries as $country): ?>
			<?php if($this->userHalbfinal[4] == $country['id']): ?>
			<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
			<?php else:?>
			<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
			<?php endif; ?>
			<?php endforeach; ?>
		</select></td>
	</tr>
</table>
<h3>Finateilnehmer</h3>
<table>
	<tr>
		<td>Team 1</td>
		<td>Team 2</td>
	</tr>
	<tr>
		<td><select name="final1">
			<option value=''></option>
			<?foreach($this->countries as $country): ?>
		<?php if($this->userFinal[1] == $country['id']): ?>
			<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
			<?php else:?>
			<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
			<?php endif; ?>
			<?php endforeach; ?>
		</select></td>
		<td><select name="final2">
		<option value=''></option>
		<?foreach($this->countries as $country): ?>
		<?php if($this->userFinal[2] == $country['id']): ?>
			<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
			<?php else:?>
			<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
			<?php endif; ?>
			<?php endforeach; ?>
		</select></td>
	</tr>
</table>
<h3>Europameister</h3>
<div><select name="europameister">
	<option value=''></option>
	<?foreach($this->countries as $country): ?>
	<?php if($this->userEuropameister == $country['id']): ?>
	<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
	<?php else:?>
	<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
	<?php endif; ?>
	<?php endforeach; ?>
</select></div>
<div style="text-align: right;"><input type="submit" value="Speichern" /></div>
</form>