<?php require_once('Layout/Tabs.php'); ?>
<?php require_once('Constants.php'); ?>

<h2>Tipps von <?php echo $this->players[$this->realid]['nachname']; ?> <?php echo $this->players[$this->realid]['vorname']; ?></h2>

<?php $tabs = new Tabs("OtherTipps"); ?>
<?php $tabs->start("Gruppenspiele"); ?>

	<table border="0">
		<tr>
			<td style="white-space: nowrap; padding-bottom: 5px" width="10px"><b>Datum</b></td>
			<td style="white-space: nowrap; padding-bottom: 5px; padding-left: 5px"><b>Team 1</b></td>
			<td style="white-space: nowrap; padding-bottom: 5px"><b>Team 2</b></td>
			<td style="white-space: nowrap; padding-bottom: 5px"><b>Tipp 1</b></td>
			<td padding-bottom: 5px/>
			<td style="white-space: nowrap; padding-bottom: 5px"><b>Tipp 2</b></td>
			<td style="white-space: nowrap; padding-bottom: 5px; padding-left: 5px"><b>Res. 1</b></td>
			<td padding-bottom: 5px/>
			<td style="white-space: nowrap; padding-bottom: 5px"><b>Res. 2</b></td>
			<td>&nbsp;</td>
		</tr>
		<?php 
			$counter = 0;
			foreach($this->vorrunde as $spiel): 
				$counter++;
				if($counter <= (Constants::$isWM ? 48 : 36)){
		?>
		<tr>
			<td valign="top"><?php echo $spiel['start']; ?></td>
			<td valign="top" style="padding-left: 5px"><?php echo $spiel['team1']; ?></td>
			<td valign="top"><?php echo $spiel['team2']; ?></td>
			<td align="center" valign="top"><input type="text" style="width: 15px"
				value="<?php echo $spiel['result1']; ?>"
				<?php echo $spiel['disabled']; ?>
				name="result1<?php echo $spiel['id']; ?>" maxLength="2" /></td>
			<td valign="top">:</td>
			<td align="center" valign="top"><input type="text" style="width: 15px"
				value="<?php echo $spiel['result2']; ?>"
				<?php echo $spiel['disabled']; ?>
				name="result2<?php echo $spiel['id']; ?>" maxLength="2" />
			</td>				
			<td align="center" valign="top" style="padding-left: 5px"><b><?php echo $spiel['realresult1']; ?></b></td>
			<td align="center" valign="top"><b>:</b></td>
			<td align="center" valign="top"><b><?php echo $spiel['realresult2']; ?></b></td>
			<td valign="top" style="white-space: nowrap;">
				<?php
					echo Constants::getPointsPng($spiel['result1'],$spiel['result2'],$spiel['realresult1'],$spiel['realresult2']);
				?>
			</td>
		</tr>
		<?php 	}
				endforeach; 
			?>
	</table>

<?php $tabs->end(); ?>
<?php $tabs->start("Finalspiele"); ?>
	<table border="0">
		<tr>
			<td style="white-space: nowrap; padding-bottom: 5px" width="10px"><b>Datum</b></td>
			<td style="white-space: nowrap; padding-bottom: 5px; padding-left: 5px"><b>Team 1</b></td>
			<td style="white-space: nowrap; padding-bottom: 5px"><b>Team 2</b></td>
			<td style="white-space: nowrap; padding-bottom: 5px"><b>Tipp 1</b></td>
			<td padding-bottom: 5px/>
			<td style="white-space: nowrap; padding-bottom: 5px"><b>Tipp 2</b></td>
			<td style="white-space: nowrap; padding-bottom: 5px; padding-left: 5px"><b>Res. 1</b></td>
			<td padding-bottom: 5px/>
			<td style="white-space: nowrap; padding-bottom: 5px"><b>Res. 2</b></td>
			<td>&nbsp;</td>
		</tr>
		<?php 
			foreach($this->vorrunde as $spiel): 
				if($spiel['id'] > (Constants::$isWM ? 48 : 36)){
		?>
					<tr>
						<td valign="top"><?php echo $spiel['start']; ?></td>
						<td valign="top" style="padding-left: 5px"><?php echo $spiel['team1']; ?></td>
						<td valign="top"><?php echo $spiel['team2']; ?></td>
						<td align="center" valign="top"><input type="text" style="width: 15px"
							value="<?php echo $spiel['result1']; ?>"
							<?php echo $spiel['disabled']; ?>
							name="result1<?php echo $spiel['id']; ?>" maxLength="2" /></td>
						<td valign="top">:</td>
						<td align="center" valign="top"><input type="text" style="width: 15px"
							value="<?php echo $spiel['result2']; ?>"
							<?php echo $spiel['disabled']; ?>
							name="result2<?php echo $spiel['id']; ?>" maxLength="2" />
						</td>				
						<td align="center" valign="top" style="padding-left: 5px"><b><?php echo $spiel['realresult1']; ?></b></td>
						<td align="center" valign="top"><b>:</b></td>
						<td align="center" valign="top"><b><?php echo $spiel['realresult2']; ?></b></td>
						<td valign="top" style="white-space: nowrap;">
							<?php
								echo Constants::getPointsPng($spiel['result1'],$spiel['result2'],$spiel['realresult1'],$spiel['realresult2']);
							?>
						</td>
					</tr>
		<?php 	}
			endforeach; 
		?>
	</table>
<?php $tabs->end(); ?>
<?php $tabs->start("Finalteilnehmer"); ?>

			<h3>Achtelfinalteilnehmer</h3>
			<table>
				<tr>
					<td>Sieger Gruppe A</td>
					<td>Zweiter Gruppe A</td>
					<td>Sieger Gruppe B</td>
					<td>Zweiter Gruppe B</td>
				</tr>
				<tr>
				
					<?php $isDisabled = $this->isDisabledHauptrunde(); ?>
				
					<td><select name="achtelfinal1" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[1], 1); ?>">
						<option value=''></option>
						<?php foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[1] == $country['id']): ?>
						<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
						<?php endif; ?>
						<?php endforeach; ?>
					</select></td>
					<td><select name="achtelfinal2" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[2], 1); ?>">
						<option value=''></option>
						<?php foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[2] == $country['id']): ?>
						<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
						<?php endif; ?>
						<?php endforeach; ?>
					</select></td>
					<td><select name="achtelfinal3" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[3], 1); ?>">
						<option value=''></option>
						<?php foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[3] == $country['id']): ?>
						<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
						<?php endif; ?>
						<?php endforeach; ?>
					</select></td>
					<td><select name="achtelfinal4" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[4], 1); ?>">
						<option value=''></option>
						<?php foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[4] == $country['id']): ?>
						<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
						<?php endif; ?>
						<?php endforeach; ?>
					</select></td>
				</tr>
				<tr>
					<td>Sieger Gruppe C</td>
					<td>Zweiter Gruppe C</td>
					<td>Sieger Gruppe D</td>
					<td>Zweiter Gruppe D</td>
				</tr>
				<tr>
					<td><select name="achtelfinal5" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[5], 1); ?>">
						<option value=''></option>
						<?php foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[5] == $country['id']): ?>
						<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
						<?php endif; ?>
						<?php endforeach; ?>
					</select></td>
					<td><select name="achtelfinal6" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[6], 1); ?>">
						<option value=''></option>
						<?php foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[6] == $country['id']): ?>
						<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
						<?php endif; ?>
						<?php endforeach; ?>
					</select></td>
					<td><select name="achtelfinal7" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[7], 1); ?>">
						<option value=''></option>
						<?php foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[7] == $country['id']): ?>
						<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
						<?php endif; ?>
						<?php endforeach; ?>
					</select></td>
					<td><select name="achtelfinal8" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[8], 1); ?>">
						<option value=''></option>
						<?php foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[8] == $country['id']): ?>
						<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
						<?php endif; ?>
						<?php endforeach; ?>
					</select></td>
				</tr>
				<tr>
					<td>Sieger Gruppe E</td>
					<td>Zweiter Gruppe E</td>
					<td>Sieger Gruppe F</td>
					<td>Zweiter Gruppe F</td>
				</tr>
				<tr>
				
					<?php $isDisabled = $this->isDisabledHauptrunde(); ?>
				
					<td><select name="achtelfinal9" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[9], 1); ?>">
						<option value=''></option>
						<?php foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[9] == $country['id']): ?>
						<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
						<?php endif; ?>
						<?php endforeach; ?>
					</select></td>
					<td><select name="achtelfinal10" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[10], 1); ?>">
						<option value=''></option>
						<?php foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[10] == $country['id']): ?>
						<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
						<?php endif; ?>
						<?php endforeach; ?>
					</select></td>
					<td><select name="achtelfinal11" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[11], 1); ?>">
						<option value=''></option>
						<?php foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[11] == $country['id']): ?>
						<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
						<?php endif; ?>
						<?php endforeach; ?>
					</select></td>
					<td><select name="achtelfinal12" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[12], 1); ?>">
						<option value=''></option>
						<?php foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[12] == $country['id']): ?>
						<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
						<?php endif; ?>
						<?php endforeach; ?>
					</select></td>
				</tr>
				<tr>
					<td>Beste 3. Platzierte</td>
					<td>Beste 3. Platzierte</td>
					<td>Beste 3. Platzierte</td>
					<td>Beste 3. Platzierte</td>
				</tr>
				<tr>
					<td><select name="achtelfinal13" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[13], 1); ?>">
						<option value=''></option>
						<?php foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[13] == $country['id']): ?>
						<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
						<?php endif; ?>
						<?php endforeach; ?>
					</select></td>
					<td><select name="achtelfinal14" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[14], 1); ?>">
						<option value=''></option>
						<?php foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[14] == $country['id']): ?>
						<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
						<?php endif; ?>
						<?php endforeach; ?>
					</select></td>
					<td><select name="achtelfinal15" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[15], 1); ?>">
						<option value=''></option>
						<?php foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[15] == $country['id']): ?>
						<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
						<?php endif; ?>
						<?php endforeach; ?>
					</select></td>
					<td><select name="achtelfinal16" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[16], 1); ?>">
						<option value=''></option>
						<?php foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[16] == $country['id']): ?>
						<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
						<?php endif; ?>
						<?php endforeach; ?>
					</select></td>
				</tr>
			</table>

	<h3>Viertelfinalteilnehmer</h3>
	<table>
		<tr>
				<td>2A - 2C = VF1</td>
				<td>1B - 3A/C/D = VF2</td>
				<td>1D - 3B/E/F = VF3</td>
				<td>1A - 3C/D/E = VF4</td>
		</tr>
		<tr>
			<td><select name="viertelfinal1" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px; <?php echo $this->getStyle($this->userViertelfinal[1], 2); ?>">
				<option value=''></option>
				<?php foreach($this->countries as $country): ?>
				<?php if($this->userViertelfinal[1] == $country['id']): ?>
				<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
				<?php else:?>
				<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
				<?php endif; ?>
				<?php endforeach; ?>
			</select></td>
			<td><select name="viertelfinal2" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px; <?php echo $this->getStyle($this->userViertelfinal[2], 2); ?>">
				<option value=''></option>
				<?php foreach($this->countries as $country): ?>
				<?php if($this->userViertelfinal[2] == $country['id']): ?>
				<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
				<?php else:?>
				<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
				<?php endif; ?>
				<?php endforeach; ?>
			</select></td>
			<td><select name="viertelfinal3" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px; <?php echo $this->getStyle($this->userViertelfinal[3], 2); ?>">
				<option value=''></option>
				<?php foreach($this->countries as $country): ?>
				<?php if($this->userViertelfinal[3] == $country['id']): ?>
				<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
				<?php else:?>
				<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
				<?php endif; ?>
				<?php endforeach; ?>
			</select></td>
			<td><select name="viertelfinal4" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px; <?php echo $this->getStyle($this->userViertelfinal[4], 2); ?>">
				<option value=''></option>
				<?php foreach($this->countries as $country): ?>
				<?php if($this->userViertelfinal[4] == $country['id']): ?>
				<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
				<?php else:?>
				<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
				<?php endif; ?>
				<?php endforeach; ?>
			</select></td>
		</tr>
		<tr>
			<td>1C - 3A/B/F = VF5</td>
			<td>1F - 2E = VF6</td>
			<td>1E - 2D = VF7</td>
			<td>2B - 2F = VF8</td>
		</tr>
		<tr>
			<td><select name="viertelfinal5" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px; <?php echo $this->getStyle($this->userViertelfinal[5], 2); ?>">
				<option value=''></option>
				<?php foreach($this->countries as $country): ?>
				<?php if($this->userViertelfinal[5] == $country['id']): ?>
				<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
				<?php else:?>
				<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
				<?php endif; ?>
				<?php endforeach; ?>
			</select></td>
			<td><select name="viertelfinal6" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px; <?php echo $this->getStyle($this->userViertelfinal[6], 2); ?>">
				<option value=''></option>
				<?php foreach($this->countries as $country): ?>
				<?php if($this->userViertelfinal[6] == $country['id']): ?>
				<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
				<?php else:?>
				<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
				<?php endif; ?>
				<?php endforeach; ?>
			</select></td>
			<td><select name="viertelfinal7" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px; <?php echo $this->getStyle($this->userViertelfinal[7], 2); ?>">
				<option value=''></option>
				<?php foreach($this->countries as $country): ?>
				<?php if($this->userViertelfinal[7] == $country['id']): ?>
				<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
				<?php else:?>
				<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
				<?php endif; ?>
				<?php endforeach; ?>
			</select></td>
			<td><select name="viertelfinal8" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px; <?php echo $this->getStyle($this->userViertelfinal[8], 2); ?>">
				<option value=''></option>
				<?php foreach($this->countries as $country): ?>
				<?php if($this->userViertelfinal[8] == $country['id']): ?>
				<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
				<?php else:?>
				<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
				<?php endif; ?>
				<?php endforeach; ?>
			</select></td>
		</tr>
	</table>
	<h3>Halbfinalteilnehmer</h3>
	<table>
		<tr>
				<td>VF1 - VF3 = HF1</td>
				<td>VF2 - VF6 = HF2</td>
				<td>VF5 - VF7 = HF3</td>
				<td>VF4 - VF8 = HF4</td>
		</tr>
		<tr>
			<td><select name="halbfinal1" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px;<?php echo $this->getStyle($this->userHalbfinal[1], 3); ?>">
				<option value=''></option>
				<?php foreach($this->countries as $country): ?>
				<?php if($this->userHalbfinal[1] == $country['id']): ?>
				<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
				<?php else:?>
				<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
				<?php endif; ?>
				<?php endforeach; ?>
			</select></td>
			<td><select name="halbfinal2" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px;<?php echo $this->getStyle($this->userHalbfinal[2], 3); ?>">
				<option value=''></option>
				<?php foreach($this->countries as $country): ?>
				<?php if($this->userHalbfinal[2] == $country['id']): ?>
				<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
				<?php else:?>
				<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
				<?php endif; ?>
				<?php endforeach; ?>
			</select></td>
			<td><select name="halbfinal3" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px;<?php echo $this->getStyle($this->userHalbfinal[3], 3); ?>">
				<option value=''></option>
				<?php foreach($this->countries as $country): ?>
				<?php if($this->userHalbfinal[3] == $country['id']): ?>
				<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
				<?php else:?>
				<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
				<?php endif; ?>
				<?php endforeach; ?>
			</select></td>
			<td><select name="halbfinal4" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px;<?php echo $this->getStyle($this->userHalbfinal[4], 3); ?>">
				<option value=''></option>
				<?php foreach($this->countries as $country): ?>
				<?php if($this->userHalbfinal[4] == $country['id']): ?>
				<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
				<?php else:?>
				<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
				<?php endif; ?>
				<?php endforeach; ?>
			</select></td>
		</tr>
	</table>
	<h3>Finalteilnehmer</h3>
	<table>
		<tr>
				<td>HF1 - HF2 = F1</td>
				<td>HF3 - HF4 = F2</td>
		</tr>
		<tr>
			<td><select name="final1" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px;<?php echo $this->getStyle($this->userFinal[1], 4); ?>">
				<option value=''></option>
				<?php foreach($this->countries as $country): ?>
			<?php if($this->userFinal[1] == $country['id']): ?>
				<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
				<?php else:?>
				<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
				<?php endif; ?>
				<?php endforeach; ?>
			</select></td>
			<td><select name="final2" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px;<?php echo $this->getStyle($this->userFinal[2], 4); ?>">
			<option value=''></option>
			<?php foreach($this->countries as $country): ?>
			<?php if($this->userFinal[2] == $country['id']): ?>
				<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
				<?php else:?>
				<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
				<?php endif; ?>
				<?php endforeach; ?>
			</select></td>
		</tr>
	</table>
	<h3><?php echo Constants::getWinnerLabel() ?></h3>
	<div><select name="sieger" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px;<?php echo $this->getStyle($this->userSieger, 5); ?>">
		<option value=''></option>
		<?php foreach($this->countries as $country): ?>
		<?php if($this->userSieger == $country['id']): ?>
		<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
		<?php else:?>
		<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
		<?php endif; ?>
		<?php endforeach; ?>
	</select></div>
<?php $tabs->end(); ?>
<?php $tabs->active = $this->isAlreadyFinalround; $tabs->run(); ?>
