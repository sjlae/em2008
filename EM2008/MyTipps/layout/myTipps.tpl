<h2>Meine Tipps</h2>
<?php require_once('Layout/infos.tpl'); ?>
<?php require_once('Layout/errors.tpl'); ?>
<?php require_once('Layout/Tabs.php'); ?>
<?php require_once('Constants.php'); ?>

<?php $tabs = new Tabs("MyTipps"); ?>
<?php $tabs->start("Gruppenspiele"); ?>

	<form action="index.php?go=myTipps&action=setTipps" name="formular" method="POST">
		<input type="hidden" name="page" value="groups" id="page"/>
		<table border="0">
			<tr>
				<td style="white-space: nowrap; padding-bottom: 5px" width="10px;"><b>Datum</b></td>
				<td style="white-space: nowrap; padding-bottom: 5px; padding-left: 5px;"><b>Team 1</b></td>
				<td style="white-space: nowrap; padding-bottom: 5px; padding-left: 5px;"><b>Team 2</b></td>
				<td style="white-space: nowrap; padding-bottom: 5px; padding-left: 5px;"><b>Tipp 1</b></td>
				<td padding-bottom: 5px/>
				<td style="white-space: nowrap; padding-bottom: 5px"><b>Tipp 2</b></td>
				<td style="white-space: nowrap; padding-bottom: 5px; padding-left: 10px;"><b>High Risk</b></td>
				<td style="white-space: nowrap; padding-bottom: 5px; padding-left: 10px;"><b>Punkte</b></td>
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
							<td valign="top" style="padding-left: 5px"><?php echo $spiel['team2']; ?></td>
							<td align="center" valign="top">
								<input type="text" style="width: 15px" value="<?php echo $spiel['result1']; ?>" <?php echo $spiel['disabled']; ?> name="result1<?php echo $spiel['id']; ?>" maxLength="2" /></td>
							<td valign="top">:</td>
							<td align="center" valign="top"><input type="text" style="width: 15px" value="<?php echo $spiel['result2']; ?>"	<?php echo $spiel['disabled']; ?> name="result2<?php echo $spiel['id']; ?>" maxLength="2" />
							</td>
							<td align="center" valign="top">
								<?php if($spiel['highrisk'] == 1){ ?>
									<input type="checkbox" name="games_highrisk<?php echo $spiel['id']; ?>" value="<?php echo $spiel['id']; ?>" <?php echo $spiel['disabled']; ?> checked/>
								<?php } else{ ?>
									<input type="checkbox" name="games_highrisk<?php echo $spiel['id']; ?>" value="<?php echo $spiel['id']; ?>" <?php echo $spiel['disabled']; ?>/>
								<?php } ?>
							</td>
							<td align="center" valign="top" style="white-space: nowrap;" title="<?php echo 'Korrektes Resultat: '; echo $spiel['realresult1']; echo ':'; echo $spiel['realresult2']; ?>">
								<img alt="" src="Layout/<?php echo Constants::getPointsPng($spiel['result1'],$spiel['result2'],$spiel['realresult1'],$spiel['realresult2'],$spiel['highrisk']);  ?>" width="22px" />
							</td>
						</tr>
			<?php 	}
				endforeach;
			?>
		</table>
		<div style="text-align: right;"><input type="submit" value="Speichern" onclick="document.formular.page.value='groups'"/></div>

<?php $tabs->end(); ?>
<?php $tabs->start("Finalspiele"); ?>
	<table border="0">
		<tr>
			<td style="white-space: nowrap; padding-bottom: 5px" width="10px;"><b>Datum</b></td>
			<td style="white-space: nowrap; padding-bottom: 5px; padding-left: 5px;"><b>Team 1</b></td>
			<td style="white-space: nowrap; padding-bottom: 5px; padding-left: 5px;"><b>Team 2</b></td>
			<td style="white-space: nowrap; padding-bottom: 5px; padding-left: 5px;"><b>Tipp 1</b></td>
			<td padding-bottom: 5px/>
			<td style="white-space: nowrap; padding-bottom: 5px"><b>Tipp 2</b></td>
			<td style="white-space: nowrap; padding-bottom: 5px; padding-left: 10px;"><b>High Risk</b></td>
			<td style="white-space: nowrap; padding-bottom: 5px; padding-left: 10px;"><b>Punkte</b></td>
		</tr>
		<?php
			foreach($this->vorrunde as $spiel):
				if($spiel['id'] > (Constants::$isWM ? 48 : 36)){
		?>
					<tr>
						<td valign="top"><?php echo $spiel['start']; ?></td>
						<td valign="top" style="padding-left: 5px"><?php echo $spiel['team1']; ?></td>
						<td valign="top" style="padding-left: 5px"><?php echo $spiel['team2']; ?></td>
						<td align="center" valign="top">
							<input type="text" style="width: 15px" value="<?php echo $spiel['result1']; ?>" <?php echo $spiel['disabled']; ?> name="result1<?php echo $spiel['id']; ?>" maxLength="2" /></td>
						<td valign="top">:</td>
						<td align="center" valign="top"><input type="text" style="width: 15px" value="<?php echo $spiel['result2']; ?>"	<?php echo $spiel['disabled']; ?> name="result2<?php echo $spiel['id']; ?>" maxLength="2" />
						</td>
						<td align="center" valign="top">
							<?php if($spiel['highrisk'] == 1){ ?>
								<input type="checkbox" name="games_highrisk<?php echo $spiel['id']; ?>" value="<?php echo $spiel['id']; ?>" <?php echo $spiel['disabled']; ?> checked/>
							<?php } else{ ?>
								<input type="checkbox" name="games_highrisk<?php echo $spiel['id']; ?>" value="<?php echo $spiel['id']; ?>" <?php echo $spiel['disabled']; ?>/>
							<?php } ?>
						</td>
						<td align="center" valign="top" style="white-space: nowrap;" title="<?php echo 'Korrektes Resultat: '; echo $spiel['realresult1']; echo ':'; echo $spiel['realresult2']; ?>">
							<img alt="" src="Layout/<?php echo Constants::getPointsPng($spiel['result1'],$spiel['result2'],$spiel['realresult1'],$spiel['realresult2'],$spiel['highrisk']);  ?>" width="22px" />
						</td>
					</tr>
		<?php 	}
			endforeach;
		?>
	</table>
	<div style="text-align: right;"><input type="submit" value="Speichern" onclick="document.formular.page.value='finals'"/></div>

<?php $tabs->end(); ?>
<?php $tabs->start("Weitere Tipps"); ?>
<?php $allCountries = array(); ?>
		
				<h3>Wer &uuml;bersteht die Gruppenphase?</h3>
				<table>
					<tr>
						<td>Sieger Gruppe A</td>
						<td>Zweiter Gruppe A</td>
						<td>Sieger Gruppe B</td>
						<td>Zweiter Gruppe B</td>
					</tr>
					<tr>

						<?php $isDisabled = $this->isDisabledWeitereTipps(); ?>

						<td><select name="achtelfinal1" id="achtelfinal1" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[1], 1); ?>">
							<option value=''></option>
							<?php foreach($this->getGroupTeams('A') as $country): ?>
							<?php if($this->userAchtelfinal[1] == $country['id']): ?>
							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal2" id="achtelfinal2" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[2], 1); ?>">
							<option value=''></option>
							<?php foreach($this->getGroupTeams('A') as $country): ?>
							<?php if($this->userAchtelfinal[2] == $country['id']): ?>
							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal3" id="achtelfinal3" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[3], 1); ?>">
							<option value=''></option>
							<?php foreach($this->getGroupTeams('B') as $country): ?>
							<?php if($this->userAchtelfinal[3] == $country['id']): ?>
							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal4" id="achtelfinal4" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[4], 1); ?>">
							<option value=''></option>
							<?php foreach($this->getGroupTeams('B') as $country): ?>
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
						<td><select name="achtelfinal5" id="achtelfinal5" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[5], 1); ?>">
							<option value=''></option>
							<?php foreach($this->getGroupTeams('C') as $country): ?>
							<?php if($this->userAchtelfinal[5] == $country['id']): ?>
							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal6" id="achtelfinal6" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[6], 1); ?>">
							<option value=''></option>
							<?php foreach($this->getGroupTeams('C') as $country): ?>
							<?php if($this->userAchtelfinal[6] == $country['id']): ?>
							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal7" id="achtelfinal7" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[7], 1); ?>">
							<option value=''></option>
							<?php foreach($this->getGroupTeams('D') as $country): ?>
							<?php if($this->userAchtelfinal[7] == $country['id']): ?>
							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal8" id="achtelfinal8" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[8], 1); ?>">
							<option value=''></option>
							<?php foreach($this->getGroupTeams('D') as $country): ?>
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

						<td><select name="achtelfinal9" id="achtelfinal9" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[9], 1); ?>">
							<option value=''></option>
							<?php foreach($this->getGroupTeams('E') as $country): ?>
							<?php if($this->userAchtelfinal[9] == $country['id']): ?>
							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal10" id="achtelfinal10" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[10], 1); ?>">
							<option value=''></option>
							<?php foreach($this->getGroupTeams('E') as $country): ?>
							<?php if($this->userAchtelfinal[10] == $country['id']): ?>
							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal11" id="achtelfinal11" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[11], 1); ?>">
							<option value=''></option>
							<?php foreach($this->getGroupTeams('F') as $country): ?>
							<?php if($this->userAchtelfinal[11] == $country['id']): ?>
							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal12" id="achtelfinal12" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[12], 1); ?>">
							<option value=''></option>
							<?php foreach($this->getGroupTeams('F') as $country): ?>
							<?php if($this->userAchtelfinal[12] == $country['id']): ?>
							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
					</tr>
          <?php if(Constants::$isWM): ?>
					<tr>
						<td>Sieger Gruppe G</td>
						<td>Zweiter Gruppe G</td>
						<td>Sieger Gruppe H</td>
						<td>Zweiter Gruppe H</td>
					</tr>
					<tr>
						<td><select name="achtelfinal13" id="achtelfinal13" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[13], 1); ?>">
							<option value=''></option>
							<?php foreach($this->getGroupTeams('G') as $country): ?>
							<?php if($this->userAchtelfinal[13] == $country['id']): ?>
							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal14" id="achtelfinal14" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[14], 1); ?>">
							<option value=''></option>
							<?php foreach($this->getGroupTeams('G') as $country): ?>
							<?php if($this->userAchtelfinal[14] == $country['id']): ?>
							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal15" id="achtelfinal15" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[15], 1); ?>">
							<option value=''></option>
							<?php foreach($this->getGroupTeams('H') as $country): ?>
							<?php if($this->userAchtelfinal[15] == $country['id']): ?>
							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal16" id="achtelfinal16" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[16], 1); ?>">
							<option value=''></option>
							<?php foreach($this->getGroupTeams('H') as $country): ?>
							<?php if($this->userAchtelfinal[16] == $country['id']): ?>
							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
					</tr>
        <?php else: ?>  
					<tr>
						<td>Beste 3. Platzierte</td>
						<td>Beste 3. Platzierte</td>
						<td>Beste 3. Platzierte</td>
						<td>Beste 3. Platzierte</td>
					</tr>
					<tr>
						<td><select name="achtelfinal13" id="achtelfinal13" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[13], 1); ?>">
							<option value=''></option>
							<?php foreach($allCountries as $key=>$value): ?>
                <optgroup label="<?php echo $key; ?>">
  							<?php foreach($value as $country): ?>
  							<?php if($this->userAchtelfinal[13] == $country['id']): ?>
  							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
  							<?php else:?>
  							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
  							<?php endif; ?>
							<?php endforeach; ?>
              </optgroup>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal14" id="achtelfinal14" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[14], 1); ?>">
							<option value=''></option>
							<?php foreach($allCountries as $key=>$value): ?>
                <optgroup label="<?php echo $key; ?>">
  							<?php foreach($value as $country): ?>
  							<?php if($this->userAchtelfinal[14] == $country['id']): ?>
  							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
  							<?php else:?>
  							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
  							<?php endif; ?>
							<?php endforeach; ?>
              </optgroup>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal15" id="achtelfinal15" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[15], 1); ?>">
							<option value=''></option>
							<?php foreach($allCountries as $key=>$value): ?>
                <optgroup label="<?php echo $key; ?>">
  							<?php foreach($value as $country): ?>
  							<?php if($this->userAchtelfinal[15] == $country['id']): ?>
  							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
  							<?php else:?>
  							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
  							<?php endif; ?>
							<?php endforeach; ?>
              </optgroup>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal16" id="achtelfinal16" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->userAchtelfinal[16], 1); ?>">
							<option value=''></option>
							<?php foreach($allCountries as $key=>$value): ?>
                <optgroup label="<?php echo $key; ?>">
  							<?php foreach($value as $country): ?>
  							<?php if($this->userAchtelfinal[16] == $country['id']): ?>
  							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
  							<?php else:?>
  							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
  							<?php endif; ?>
							<?php endforeach; ?>
              </optgroup>
							<?php endforeach; ?>
						</select></td>
					</tr>
        <?php endif; ?>
				</table>
		
	<h3>Welches wird das <i>beste</i> Team der Vorrunde?</h3>
	<table>
		<tr>
			<td><select name="best" id="best" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->best, 17); ?>">
				<option value=''></option>
				<?php foreach($this->countries as $country): ?>
					<?php if($this->best == $country['id']): ?>
						<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
					<?php else:?>
						<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
					<?php endif; ?>
				<?php endforeach; ?>
			</select></td>
		</tr>
	</table>
	
	<h3>Welches wird das <i>schlechteste</i> Team der Vorrunde?</h3>
	<table>
		<tr>
			<td><select name="worst" id="worst" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->worst, 18); ?>">
				<option value=''></option>
				<?php foreach($this->countries as $country): ?>
					<?php if($this->worst == $country['id']): ?>
						<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
					<?php else:?>
						<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
					<?php endif; ?>
				<?php endforeach; ?>
			</select></td>
		</tr>
	</table>
	
	<h3>Wie weit kommt die <i>Schweiz</i> im Turnier?</h3>
	<table>
		<tr>
			<td><select name="switzerland" id="switzerland" <?php echo $isDisabled; ?> style="width: 200px; <?php echo $this->getStyle($this->switzerland, 19); ?>">
				<option value=''></option>
				<?php foreach($this->phases as $phase): ?>
					<?php if($this->switzerland == $phase['id']): ?>
						<option value="<?php echo $phase['id']; ?>" selected><?php echo $phase['beschreibung']; ?></option>
					<?php else:?>
						<option value="<?php echo $phase['id']; ?>"><?php echo $phase['beschreibung']; ?></option>
					<?php endif; ?>
				<?php endforeach; ?>
			</select></td>
		</tr>
	</table>
	
	<h3>Wie weit kommt der Titelverteidiger <i>Deutschland</i> im Turnier?</h3>
	<table>
		<tr>
			<td><select name="lastwinner" id="lastwinner" <?php echo $isDisabled; ?> style="width: 200px; <?php echo $this->getStyle($this->lastwinner, 20); ?>">
				<option value=''></option>
				<?php foreach($this->phases as $phase): ?>
					<?php if($this->lastwinner == $phase['id']): ?>
						<option value="<?php echo $phase['id']; ?>" selected><?php echo $phase['beschreibung']; ?></option>
					<?php else:?>
						<option value="<?php echo $phase['id']; ?>"><?php echo $phase['beschreibung']; ?></option>
					<?php endif; ?>
				<?php endforeach; ?>
			</select></td>
		</tr>
	</table>
	
	<h3>Wer wird <?php echo Constants::$winnerLabel; ?>?</h3>
	<table>
		<tr>
			<td><select name="winner" id="winner" <?php echo $isDisabled; ?> style="width: 110px; <?php echo $this->getStyle($this->winner, 16); ?>">
				<option value=''></option>
				<?php foreach($this->countries as $country): ?>
					<?php if($this->winner == $country['id']): ?>
						<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
					<?php else:?>
						<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
					<?php endif; ?>
				<?php endforeach; ?>
			</select></td>
		</tr>
	</table>
		
	<div style="text-align: right;"><input type="submit" value="Speichern" onclick="document.formular.page.value='countries'"/></div>
	</form>
<?php $tabs->end(); ?>
<?php $tabs->active = Constants::isAlreadyFinalround(); $tabs->run(); ?>
