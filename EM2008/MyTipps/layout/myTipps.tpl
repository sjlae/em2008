<h2>Meine Tipps</h2>
<form action="index.php?go=myTipps&action=setTipps" method="POST">
<table border="0">
	<tr>
		<td align="center" style="white-space: nowrap"><b>#</b></td>
		<td style="white-space: nowrap"><b>Datum</b></td>
		<td style="white-space: nowrap"><b>Team 1</b></td>
		<td style="white-space: nowrap"><b>Team 2</b></td>
		<td style="white-space: nowrap"><b>Tore 1</b></td>
		<td style="white-space: nowrap"><b>Tore 2</b></td>
		<td style="white-space: nowrap"><b>Res. 1</b></td>
		<td style="white-space: nowrap"><b>Res. 2</b></td>
	</tr>
	<?php $i = 0; ?>
	<?php foreach($this->vorrunde as $spiel): ?>
	<tr>
		<td align="center"><?php echo $spiel['id']; ?></td>
		<td><?php echo $spiel['start']; ?></td>
		<td><?php echo $spiel['team1']; ?></td>
		<td><?php echo $spiel['team2']; ?></td>
		<td align="center"><input type="text" style="width: 15px" value="<?php echo $spiel['result1']; ?>" <?php echo $spiel['disabled']; ?> name="result1<?php echo $i; ?>" /></td>
		<td align="center"><input type="text" style="width: 15px" value="<?php echo $spiel['result2']; ?>" <?php echo $spiel['disabled']; ?> name="result2<?php echo $i; ?>" /></td>
		<td align="center"><?php echo $spiel['realresult1']; ?></td>
		<td align="center"><?php echo $spiel['realresult2']; ?></td>
	</tr>
	<?php $i++; ?>
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
		<td>
			<select name="viertelfinal1">
				<?$i=0; ?>
				<?foreach($this->countries as $country): ?>
					<option value="<?echo ++$i; ?>"><?echo $country ?></option>
				<?endforeach; ?>
			</select>
		</td>
		<td>
			<select name="viertelfinal2">
				<?$i=0; ?>
				<?foreach($this->countries as $country): ?>
					<option value="<?echo ++$i; ?>"><?echo $country ?></option>
				<?endforeach; ?>
			</select>
		</td>
		<td>
			<select name="viertelfinal3">
				<?$i=0; ?>
				<?foreach($this->countries as $country): ?>
					<option value="<?echo ++$i; ?>"><?echo $country ?></option>
				<?endforeach; ?>
			</select>
		</td>
		<td>
			<select name="viertelfinal4">
				<?$i=0; ?>
				<?foreach($this->countries as $country): ?>
					<option value="<?echo ++$i; ?>"><?echo $country ?></option>
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
				<?$i=0; ?>
				<?foreach($this->countries as $country): ?>
					<option value="<?echo ++$i; ?>"><?echo $country ?></option>
				<?endforeach; ?>
			</select>
		</td>
		<td>
			<select name="viertelfinal6">
				<?$i=0; ?>
				<?foreach($this->countries as $country): ?>
					<option value="<?echo ++$i; ?>"><?echo $country ?></option>
				<?endforeach; ?>
			</select>
		</td>
		<td>
			<select name="viertelfinal7">
				<?$i=0; ?>
				<?foreach($this->countries as $country): ?>
					<option value="<?echo ++$i; ?>"><?echo $country ?></option>
				<?endforeach; ?>
			</select>
		</td>
		<td>
			<select name="viertelfinal8">
				<?$i=0; ?>
				<?foreach($this->countries as $country): ?>
					<option value="<?echo ++$i; ?>"><?echo $country ?></option>
				<?endforeach; ?>
			</select>
		</td>
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
		<td>
			<select name="halbfinal1">
				<?$i=0; ?>
				<?foreach($this->countries as $country): ?>
					<option value="<?echo ++$i; ?>"><?echo $country ?></option>
				<?endforeach; ?>
			</select>
		</td>
		<td>
			<select name="halbfinal2">
				<?$i=0; ?>
				<?foreach($this->countries as $country): ?>
					<option value="<?echo ++$i; ?>"><?echo $country ?></option>
				<?endforeach; ?>
			</select>
		</td>
		<td>
			<select name="halbfinal3">
				<?$i=0; ?>
				<?foreach($this->countries as $country): ?>
					<option value="<?echo ++$i; ?>"><?echo $country ?></option>
				<?endforeach; ?>
			</select>
		</td>
		<td>
			<select name="halbfinal4">
				<?$i=0; ?>
				<?foreach($this->countries as $country): ?>
					<option value="<?echo ++$i; ?>"><?echo $country ?></option>
				<?endforeach; ?>
			</select>
		</td>
	</tr>
</table>
<h3>Finateilnehmer</h3>
<table>
<tr>
		<td>Team 1</td>
		<td>Team 2</td>
	</tr>
	<tr>
		<td>
			<select name="final1">
				<?$i=0; ?>
				<?foreach($this->countries as $country): ?>
					<option value="<?echo ++$i; ?>"><?echo $country ?></option>
				<?endforeach; ?>
			</select>
		</td>
		<td>
			<select name="final2">
				<?$i=0; ?>
				<?foreach($this->countries as $country): ?>
					<option value="<?echo ++$i; ?>"><?echo $country ?></option>
				<?endforeach; ?>
			</select>
		</td>
	</tr>
</table>
<h3>Europameister</h3>
<div>
	<select name="europameister">
		<?$i=0; ?>
		<?foreach($this->countries as $country): ?>
			<option value="<?echo ++$i; ?>"><?echo $country ?></option>
		<?endforeach; ?>
	</select>
</div>
<div style="text-align:right;"><input type="submit" value="Speichern" /></div>
</form>