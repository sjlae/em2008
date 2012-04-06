<?php require_once('Layout/Tabs.php'); ?>
<?php require_once('Constants.php'); ?>

<h2>Tipps von <?php echo $this->players[$this->realid]['nachname']; ?> <?php echo $this->players[$this->realid]['vorname']; ?></h2>

<?php $tabs = new Tabs("OtherTipps"); ?>
<?php $tabs->start("Gruppenspiele"); ?>

	<table border="0">
		<tr>
			<td align="center" style="white-space: nowrap; padding-bottom: 5px"><b>#</b></td>
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
		<?php foreach($this->vorrunde as $spiel): ?>
		<tr>
			<td align="center" valign="top"><?php echo $spiel['id']; ?></td>
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
					$points = Constants::getPointsPng($spiel['result1'],$spiel['result2'],$spiel['realresult1'],$spiel['realresult2']);
				
					if($points != ""){
				?>
						<img alt="" src="Layout/<?php echo $points ?>" width="15px"/>
				<?php
					}
				?>
			</td>
		</tr>
		<?php endforeach; ?>
	</table>

<?php $tabs->end(); ?>
<?php $tabs->start("Finalspiele"); ?>

	<?php 
		if(Constants::$isWM){
	?>
			<h3>Achtelfinalteilnehmer</h3>
			<table>
				<tr>
					<td>Team 1</td>
					<td>Team 2</td>
					<td>Team 3</td>
					<td>Team 4</td>
				</tr>
				<tr>
				
					<?php $isDisabled = $this->isDisabledHauptrunde(); ?>
				
					<td><select name="achtelfinal1" <?php echo $isDisabled; ?>>
						<option value=''></option>
						<?foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[1] == $country['id']): ?>
						<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
						<?php endif; ?>
						<?endforeach; ?>
					</select></td>
					<td><select name="achtelfinal2" <?php echo $isDisabled; ?>>
						<option value=''></option>
						<?foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[2] == $country['id']): ?>
						<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
						<?php endif; ?>
						<?endforeach; ?>
					</select></td>
					<td><select name="achtelfinal3" <?php echo $isDisabled; ?>>
						<option value=''></option>
						<?foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[3] == $country['id']): ?>
						<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
						<?php endif; ?>
						<?endforeach; ?>
					</select></td>
					<td><select name="achtelfinal4" <?php echo $isDisabled; ?>>
						<option value=''></option>
						<?foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[4] == $country['id']): ?>
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
					<td><select name="achtelfinal5" <?php echo $isDisabled; ?>>
						<option value=''></option>
						<?foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[5] == $country['id']): ?>
						<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
						<?php endif; ?>
						<?php endforeach; ?>
					</select></td>
					<td><select name="achtelfinal6" <?php echo $isDisabled; ?>>
						<option value=''></option>
						<?foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[6] == $country['id']): ?>
						<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
						<?php endif; ?>
						<?php endforeach; ?>
					</select></td>
					<td><select name="achtelfinal7" <?php echo $isDisabled; ?>>
						<option value=''></option>
						<?foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[7] == $country['id']): ?>
						<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
						<?php endif; ?>
						<?php endforeach; ?>
					</select></td>
					<td><select name="achtelfinal8" <?php echo $isDisabled; ?>>
						<option value=''></option>
						<?foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[8] == $country['id']): ?>
						<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
						<?php endif; ?>
						<?php endforeach; ?>
					</select></td>
				</tr>
				<tr>
					<td>Team 9</td>
					<td>Team 10</td>
					<td>Team 11</td>
					<td>Team 12</td>
				</tr>
				<tr>
				
					<?php $isDisabled = $this->isDisabledHauptrunde(); ?>
				
					<td><select name="achtelfinal9" <?php echo $isDisabled; ?>>
						<option value=''></option>
						<?foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[9] == $country['id']): ?>
						<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
						<?php endif; ?>
						<?endforeach; ?>
					</select></td>
					<td><select name="achtelfinal10" <?php echo $isDisabled; ?>>
						<option value=''></option>
						<?foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[10] == $country['id']): ?>
						<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
						<?php endif; ?>
						<?endforeach; ?>
					</select></td>
					<td><select name="achtelfinal11" <?php echo $isDisabled; ?>>
						<option value=''></option>
						<?foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[11] == $country['id']): ?>
						<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
						<?php endif; ?>
						<?endforeach; ?>
					</select></td>
					<td><select name="achtelfinal12" <?php echo $isDisabled; ?>>
						<option value=''></option>
						<?foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[12] == $country['id']): ?>
						<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
						<?php endif; ?>
						<?php endforeach; ?>
					</select></td>
				</tr>
				<tr>
					<td>Team 13</td>
					<td>Team 14</td>
					<td>Team 15</td>
					<td>Team 16</td>
				</tr>
				<tr>
					<td><select name="achtelfinal13" <?php echo $isDisabled; ?>>
						<option value=''></option>
						<?foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[13] == $country['id']): ?>
						<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
						<?php endif; ?>
						<?php endforeach; ?>
					</select></td>
					<td><select name="achtelfinal14" <?php echo $isDisabled; ?>>
						<option value=''></option>
						<?foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[14] == $country['id']): ?>
						<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
						<?php endif; ?>
						<?php endforeach; ?>
					</select></td>
					<td><select name="achtelfinal15" <?php echo $isDisabled; ?>>
						<option value=''></option>
						<?foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[15] == $country['id']): ?>
						<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
						<?php endif; ?>
						<?php endforeach; ?>
					</select></td>
					<td><select name="achtelfinal16" <?php echo $isDisabled; ?>>
						<option value=''></option>
						<?foreach($this->countries as $country): ?>
						<?php if($this->userAchtelfinal[16] == $country['id']): ?>
						<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
						<?php else:?>
						<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
						<?php endif; ?>
						<?php endforeach; ?>
					</select></td>
				</tr>
			</table>
	<?php
		}
	?>

	<h3>Viertelfinalteilnehmer</h3>
	<table>
		<tr>
			<td>Team 1</td>
			<td>Team 2</td>
			<td>Team 3</td>
			<td>Team 4</td>
		</tr>
		<tr>
			<td><select name="viertelfinal1" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px; <?php echo $this->getStyle($this->userViertelfinal[1], 2); ?>">
				<option value=''></option>
				<?foreach($this->countries as $country): ?>
				<?php if($this->userViertelfinal[1] == $country['id']): ?>
				<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
				<?php else:?>
				<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
				<?php endif; ?>
				<?endforeach; ?>
			</select></td>
			<td><select name="viertelfinal2" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px; <?php echo $this->getStyle($this->userViertelfinal[2], 2); ?>">
				<option value=''></option>
				<?foreach($this->countries as $country): ?>
				<?php if($this->userViertelfinal[2] == $country['id']): ?>
				<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
				<?php else:?>
				<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
				<?php endif; ?>
				<?endforeach; ?>
			</select></td>
			<td><select name="viertelfinal3" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px; <?php echo $this->getStyle($this->userViertelfinal[3], 2); ?>">
				<option value=''></option>
				<?foreach($this->countries as $country): ?>
				<?php if($this->userViertelfinal[3] == $country['id']): ?>
				<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
				<?php else:?>
				<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
				<?php endif; ?>
				<?endforeach; ?>
			</select></td>
			<td><select name="viertelfinal4" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px; <?php echo $this->getStyle($this->userViertelfinal[4], 2); ?>">
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
			<td><select name="viertelfinal5" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px; <?php echo $this->getStyle($this->userViertelfinal[5], 2); ?>">
				<option value=''></option>
				<?foreach($this->countries as $country): ?>
				<?php if($this->userViertelfinal[5] == $country['id']): ?>
				<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
				<?php else:?>
				<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
				<?php endif; ?>
				<?php endforeach; ?>
			</select></td>
			<td><select name="viertelfinal6" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px; <?php echo $this->getStyle($this->userViertelfinal[6], 2); ?>">
				<option value=''></option>
				<?foreach($this->countries as $country): ?>
				<?php if($this->userViertelfinal[6] == $country['id']): ?>
				<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
				<?php else:?>
				<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
				<?php endif; ?>
				<?php endforeach; ?>
			</select></td>
			<td><select name="viertelfinal7" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px; <?php echo $this->getStyle($this->userViertelfinal[7], 2); ?>">
				<option value=''></option>
				<?foreach($this->countries as $country): ?>
				<?php if($this->userViertelfinal[7] == $country['id']): ?>
				<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
				<?php else:?>
				<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
				<?php endif; ?>
				<?php endforeach; ?>
			</select></td>
			<td><select name="viertelfinal8" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px; <?php echo $this->getStyle($this->userViertelfinal[8], 2); ?>">
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
			<td><select name="halbfinal1" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px;<?php echo $this->getStyle($this->userHalbfinal[1], 3); ?>">
				<option value=''></option>
				<?foreach($this->countries as $country): ?>
				<?php if($this->userHalbfinal[1] == $country['id']): ?>
				<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
				<?php else:?>
				<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
				<?php endif; ?>
				<?php endforeach; ?>
			</select></td>
			<td><select name="halbfinal2" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px;<?php echo $this->getStyle($this->userHalbfinal[2], 3); ?>">
				<option value=''></option>
				<?foreach($this->countries as $country): ?>
				<?php if($this->userHalbfinal[2] == $country['id']): ?>
				<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
				<?php else:?>
				<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
				<?php endif; ?>
				<?php endforeach; ?>
			</select></td>
			<td><select name="halbfinal3" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px;<?php echo $this->getStyle($this->userHalbfinal[3], 3); ?>">
				<option value=''></option>
				<?foreach($this->countries as $country): ?>
				<?php if($this->userHalbfinal[3] == $country['id']): ?>
				<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
				<?php else:?>
				<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
				<?php endif; ?>
				<?php endforeach; ?>
			</select></td>
			<td><select name="halbfinal4" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px;<?php echo $this->getStyle($this->userHalbfinal[4], 3); ?>">
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
	<h3>Finalteilnehmer</h3>
	<table>
		<tr>
			<td>Team 1</td>
			<td>Team 2</td>
		</tr>
		<tr>
			<td><select name="final1" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px;<?php echo $this->getStyle($this->userFinal[1], 4); ?>">
				<option value=''></option>
				<?foreach($this->countries as $country): ?>
			<?php if($this->userFinal[1] == $country['id']): ?>
				<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
				<?php else:?>
				<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
				<?php endif; ?>
				<?php endforeach; ?>
			</select></td>
			<td><select name="final2" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px;<?php echo $this->getStyle($this->userFinal[2], 4); ?>">
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
	<h3><?php echo Constants::getWinnerLabel() ?></h3>
	<div><select name="sieger" <?php echo $this->isDisabledHauptrunde(); ?> style="width: 110px;<?php echo $this->getStyle($this->userSieger, 5); ?>">
		<option value=''></option>
		<?foreach($this->countries as $country): ?>
		<?php if($this->userSieger == $country['id']): ?>
		<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
		<?php else:?>
		<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
		<?php endif; ?>
		<?php endforeach; ?>
	</select></div>
<?php $tabs->end(); ?>
<?php $tabs->run(); ?>
