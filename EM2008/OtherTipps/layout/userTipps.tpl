<h2>Tipps von <?php echo $this->players[$this->realid]['nachname']; ?> <?php echo $this->players[$this->realid]['vorname']; ?></h2>
<table border="0">
	<tr>
		<td align="center" style="white-space: nowrap; padding-bottom: 5px"><b>#</b></td>
		<td style="white-space: nowrap; padding-bottom: 5px"><b>Datum</b></td>
		<td style="white-space: nowrap; padding-bottom: 5px"><b>Team 1</b></td>
		<td style="white-space: nowrap; padding-bottom: 5px"><b>Team 2</b></td>
		<td style="white-space: nowrap; padding-bottom: 5px"><b>Tipp 1</b></td>
		<td padding-bottom: 5px/>
		<td style="white-space: nowrap; padding-bottom: 5px"><b>Tipp 2</b></td>
		<td style="white-space: nowrap; padding-bottom: 5px"><b>Res. 1</b></td>
		<td padding-bottom: 5px/>
		<td style="white-space: nowrap; padding-bottom: 5px"><b>Res. 2</b></td>
	</tr>
	<?php foreach($this->vorrunde as $spiel): ?>
	<tr>
		<td align="center" valign="top"><?php echo $spiel['id']; ?></td>
		<td valign="top"><?php echo $spiel['start']; ?></td>
		<td valign="top"><?php echo $spiel['team1']; ?></td>
		<td valign="top"><?php echo $spiel['team2']; ?></td>
		<td align="center" valign="top"><input type="text" style="width: 15px"
			value="<?php echo $spiel['result1']; ?>"
			<?php echo $spiel['disabled']; ?>
			name="result1<?php echo $spiel['id']; ?>" maxLength="2" /></td>
		<td valign="top">:</td>
		<td align="center" valign="top"><input type="text" style="width: 15px"
			value="<?php echo $spiel['result2']; ?>"
			<?php echo $spiel['disabled']; ?>
			name="result2<?php echo $spiel['id']; ?>" maxLength="2" /></td>
		<td align="center" valign="top"><?php echo $spiel['realresult1']; ?></td>
		<td valign="top">:</td>
		<td align="center" valign="top"><?php echo $spiel['realresult2']; ?></td>
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
		<td><select name="viertelfinal1" <?php echo $this->isDisabledHauptrunde(); ?>>
			<option value=''></option>
			<?foreach($this->countries as $country): ?>
			<?php if($this->userViertelfinal[1] == $country['id']): ?>
			<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
			<?php else:?>
			<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
			<?php endif; ?>
			<?endforeach; ?>
		</select></td>
		<td><select name="viertelfinal2" <?php echo $this->isDisabledHauptrunde(); ?>>
			<option value=''></option>
			<?foreach($this->countries as $country): ?>
			<?php if($this->userViertelfinal[2] == $country['id']): ?>
			<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
			<?php else:?>
			<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
			<?php endif; ?>
			<?endforeach; ?>
		</select></td>
		<td><select name="viertelfinal3" <?php echo $this->isDisabledHauptrunde(); ?>>
			<option value=''></option>
			<?foreach($this->countries as $country): ?>
			<?php if($this->userViertelfinal[3] == $country['id']): ?>
			<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
			<?php else:?>
			<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
			<?php endif; ?>
			<?endforeach; ?>
		</select></td>
		<td><select name="viertelfinal4" <?php echo $this->isDisabledHauptrunde(); ?>>
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
		<td><select name="viertelfinal5" <?php echo $this->isDisabledHauptrunde(); ?>>
			<option value=''></option>
			<?foreach($this->countries as $country): ?>
			<?php if($this->userViertelfinal[5] == $country['id']): ?>
			<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
			<?php else:?>
			<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
			<?php endif; ?>
			<?php endforeach; ?>
		</select></td>
		<td><select name="viertelfinal6" <?php echo $this->isDisabledHauptrunde(); ?>>
			<option value=''></option>
			<?foreach($this->countries as $country): ?>
			<?php if($this->userViertelfinal[6] == $country['id']): ?>
			<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
			<?php else:?>
			<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
			<?php endif; ?>
			<?php endforeach; ?>
		</select></td>
		<td><select name="viertelfinal7" <?php echo $this->isDisabledHauptrunde(); ?>>
			<option value=''></option>
			<?foreach($this->countries as $country): ?>
			<?php if($this->userViertelfinal[7] == $country['id']): ?>
			<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
			<?php else:?>
			<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
			<?php endif; ?>
			<?php endforeach; ?>
		</select></td>
		<td><select name="viertelfinal8" <?php echo $this->isDisabledHauptrunde(); ?>>
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
	<?php if($this->realhauptrunde[0] != ''){ ?>
		<tr>
			<td colspan="4" style="padding-top: 5px"><b>Tats&auml;chlich qualifizierte L&auml;nder:</b></td>
		</tr>
		<tr>
			<td style="color: red"><?php echo $this->realhauptrunde[0]; ?></td>
			<td style="color: red"><?php echo $this->realhauptrunde[1]; ?></td>
			<td style="color: red"><?php echo $this->realhauptrunde[2]; ?></td>
			<td style="color: red"><?php echo $this->realhauptrunde[3]; ?></td>
		</tr>
		<tr>
			<td style="color: red"><?php echo $this->realhauptrunde[4]; ?></td>
			<td style="color: red"><?php echo $this->realhauptrunde[5]; ?></td>
			<td style="color: red"><?php echo $this->realhauptrunde[6]; ?></td>
			<td style="color: red"><?php echo $this->realhauptrunde[7]; ?></td>
		</tr>
	<?php } ?>
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
		<td><select name="halbfinal1" <?php echo $this->isDisabledHauptrunde(); ?>>
			<option value=''></option>
			<?foreach($this->countries as $country): ?>
			<?php if($this->userHalbfinal[1] == $country['id']): ?>
			<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
			<?php else:?>
			<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
			<?php endif; ?>
			<?php endforeach; ?>
		</select></td>
		<td><select name="halbfinal2" <?php echo $this->isDisabledHauptrunde(); ?>>
			<option value=''></option>
			<?foreach($this->countries as $country): ?>
			<?php if($this->userHalbfinal[2] == $country['id']): ?>
			<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
			<?php else:?>
			<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
			<?php endif; ?>
			<?php endforeach; ?>
		</select></td>
		<td><select name="halbfinal3" <?php echo $this->isDisabledHauptrunde(); ?>>
			<option value=''></option>
			<?foreach($this->countries as $country): ?>
			<?php if($this->userHalbfinal[3] == $country['id']): ?>
			<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
			<?php else:?>
			<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
			<?php endif; ?>
			<?php endforeach; ?>
		</select></td>
		<td><select name="halbfinal4" <?php echo $this->isDisabledHauptrunde(); ?>>
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
	<?php if($this->realhauptrunde[8] != ''){ ?>
		<tr>
			<td colspan="4" style="padding-top: 5px"><b>Tats&auml;chlich qualifizierte L&auml;nder:</b></td>
		</tr>
		<tr>
			<td style="color: red"><?php echo $this->realhauptrunde[8]; ?></td>
			<td style="color: red"><?php echo $this->realhauptrunde[9]; ?></td>
			<td style="color: red"><?php echo $this->realhauptrunde[10]; ?></td>
			<td style="color: red"><?php echo $this->realhauptrunde[11]; ?></td>
		</tr>
	<?php } ?>
</table>
<h3>Finalteilnehmer</h3>
<table>
	<tr>
		<td>Team 1</td>
		<td>Team 2</td>
	</tr>
	<tr>
		<td><select name="final1" <?php echo $this->isDisabledHauptrunde(); ?>>
			<option value=''></option>
			<?foreach($this->countries as $country): ?>
		<?php if($this->userFinal[1] == $country['id']): ?>
			<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
			<?php else:?>
			<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
			<?php endif; ?>
			<?php endforeach; ?>
		</select></td>
		<td><select name="final2" <?php echo $this->isDisabledHauptrunde(); ?>>
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
	<?php if($this->realhauptrunde[12] != ''){ ?>
		<tr>
			<td colspan="4" style="padding-top: 5px"><b>Tats&auml;chlich qualifizierte L&auml;nder:</b></td>
		</tr>
		<tr>
			<td style="color: red"><?php echo $this->realhauptrunde[12]; ?></td>
			<td style="color: red"><?php echo $this->realhauptrunde[13]; ?></td>
		</tr>
	<?php }?>
</table>
<h3>Europameister</h3>
<div><select name="europameister" <?php echo $this->isDisabledHauptrunde(); ?>>
	<option value=''></option>
	<?foreach($this->countries as $country): ?>
	<?php if($this->userEuropameister == $country['id']): ?>
	<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
	<?php else:?>
	<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
	<?php endif; ?>
	<?php endforeach; ?>
</select></div>
<?php if($this->realhauptrunde[14] != ''){ ?>
	<div style="padding-top: 5px">
		<b>Tats&auml;chlicher Europameister:</b>
	</div>
	<div style="color: red">
	<?php echo $this->realhauptrunde[14]; ?>
	</div>
<?php } ?>
