<!-- Section Title -->
<div class="section-title" style="background:url(img/slide/1.jpg)">
	<div class="container">
		<div class="row">
			<div class="col-md-8">
				<h1>Meine Tipps</h1>
			</div>
		</div>
	</div>
</div>
<!-- End Section Title -->

<!-- Section Area - Content Central -->
<section class="content-info">

	<!--<div class="container paddings-mini">-->
	<div class="single-player-tabs">
		<div class="container">

<?php require_once('Layout/Tabs.php'); ?>
<?php require_once('Constants.php'); ?>

<?php $tabs = new Tabs("MyTipps"); ?>
<?php $tabs->start("Gruppenspiele"); ?>
			<?php require_once('Layout/infos.tpl'); ?>
			<?php require_once('Layout/errors.tpl'); ?>

	<form action="index.php?go=myTipps&action=setTipps" name="formular" method="POST">
		<input type="hidden" name="page" value="groups" id="page"/>
		<table class="table-striped table-responsive table-hover result-point">
			<thead class="point-table-head">
			<tr>
				<th style="white-space: nowrap; width: 20px;"><b>Datum</b></th>
				<th style="white-space: nowrap; "><b>Team 1</b></th>
				<th style="white-space: nowrap; "><b>Team 2</b></th>
				<th style="white-space: nowrap; width: 20px;"><b>Tipp 1</b></th>
				<th style="width: 10px;"/>
				<th style="white-space: nowrap; width: 20px;"><b>Tipp 2</b></th>
				<th style="white-space:nowrap; width: 20px;"><b>High Risk</b></th>
				<th style="white-space: nowrap; "><b>Punkte</b></th>
			</tr>
			</thead>
			<?php
				$counter = 0;
				foreach($this->vorrunde as $spiel):
					$counter++;
					if($counter <= (Constants::$isWM ? 48 : 36)){
			?>
						<tr>
							<td valign="top" style="white-space: nowrap;"><?php echo $spiel['start']; ?></td>
							<td valign="top" style="padding-left: 5px"><?php echo $spiel['team1']; ?></td>
							<td valign="top" style="padding-left: 5px"><?php echo $spiel['team2']; ?></td>
							<td align="center" valign="top">
								<input type="text" style="width: 30px" value="<?php echo $spiel['result1']; ?>" <?php echo $spiel['disabled']; ?> name="result1<?php echo $spiel['id']; ?>" maxLength="2" /></td>
							<td valign="top">:</td>
							<td align="center" valign="top"><input type="text" style="width: 30px" value="<?php echo $spiel['result2']; ?>"	<?php echo $spiel['disabled']; ?> name="result2<?php echo $spiel['id']; ?>" maxLength="2" />
							</td>
							<td align="center" valign="top">
								<?php if($spiel['highrisk'] == 1){ ?>
									<input type="checkbox" name="games_highrisk<?php echo $spiel['id']; ?>" value="<?php echo $spiel['id']; ?>" <?php echo $spiel['disabled']; ?> checked/>
								<?php } else{ ?>
									<input type="checkbox" name="games_highrisk<?php echo $spiel['id']; ?>" value="<?php echo $spiel['id']; ?>" <?php echo $spiel['disabled']; ?>/>
								<?php } ?>
							</td>
							<?php if($spiel['realresult1'] != ''){ ?>
								<td align="center" valign="top" style="white-space: nowrap;" title="<?php echo 'Korrektes Resultat: '; echo $spiel['realresult1']; echo ':'; echo $spiel['realresult2']; ?>">
									<img class="points" src="Layout/<?php echo Constants::getPointsPng($spiel['result1'],$spiel['result2'],$spiel['realresult1'],$spiel['realresult2'],$spiel['highrisk']);  ?>" width="27px" />
									<?php echo $spiel['realresult1'] .':'. + $spiel['realresult2']; ?>
								</td>
							<?php } else{ ?>
								<td>&nbsp;</td>
							<?php } ?>
						</tr>
			<?php 	}
				endforeach;
			?>
		</table>
		<div style="text-align: right;"><input type="submit" value="Speichern" onclick="document.formular.page.value='groups'" class="bnt btn-iw"/></div>

<?php $tabs->end(); ?>
<?php $tabs->start("Finalspiele"); ?>
		<?php require_once('Layout/infos.tpl'); ?>
		<?php require_once('Layout/errors.tpl'); ?>

	<table  class="table-striped table-responsive table-hover result-point">
		<thead>
			<tr>
				<th style="white-space: nowrap; width: 20px;"><b>Datum</b></th>
				<th style="white-space: nowrap; "><b>Team 1</b></th>
				<th style="white-space: nowrap; "><b>Team 2</b></th>
				<th style="white-space: nowrap; width: 20px;"><b>Tipp 1</b></th>
				<th style="width: 10px;"/>
				<th style="white-space: nowrap; width: 20px;"><b>Tipp 2</b></th>
				<th style="white-space:nowrap; width: 20px;"><b>High Risk</b></th>
				<th style="white-space: nowrap; "><b>Punkte</b></th>
			</tr>
		</thead>
		<?php
			foreach($this->vorrunde as $spiel):
				if($spiel['id'] > (Constants::$isWM ? 48 : 36)){
		?>
					<tr>
						<td valign="top" style="white-space: nowrap; "><?php echo $spiel['start']; ?></td>
						<td valign="top" style="padding-left: 5px"><?php echo $spiel['team1']; ?></td>
						<td valign="top" style="padding-left: 5px"><?php echo $spiel['team2']; ?></td>
						<td align="center" valign="top">
							<input type="text" style="width: 30px" value="<?php echo $spiel['result1']; ?>" <?php echo $spiel['disabled']; ?> name="result1<?php echo $spiel['id']; ?>" maxLength="2" /></td>
						<td valign="top">:</td>
						<td align="center" valign="top"><input type="text" style="width: 30px" value="<?php echo $spiel['result2']; ?>"	<?php echo $spiel['disabled']; ?> name="result2<?php echo $spiel['id']; ?>" maxLength="2" />
						</td>
						<td align="center" valign="top">
							<?php if($spiel['highrisk'] == 1){ ?>
								<input type="checkbox" name="games_highrisk<?php echo $spiel['id']; ?>" value="<?php echo $spiel['id']; ?>" <?php echo $spiel['disabled']; ?> checked/>
							<?php } else{ ?>
								<input type="checkbox" name="games_highrisk<?php echo $spiel['id']; ?>" value="<?php echo $spiel['id']; ?>" <?php echo $spiel['disabled']; ?>/>
							<?php } ?>
						</td>
						<?php if($spiel['realresult1'] != ''){ ?>
							<td align="center" valign="top" style="white-space: nowrap;" title="<?php echo 'Korrektes Resultat: '; echo $spiel['realresult1']; echo ':'; echo $spiel['realresult2']; ?>">
								<img class="points" src="Layout/<?php echo Constants::getPointsPng($spiel['result1'],$spiel['result2'],$spiel['realresult1'],$spiel['realresult2'],$spiel['highrisk']);  ?>" width="27px" />
								<?php echo $spiel['realresult1'] .':'. + $spiel['realresult2']; ?>
							</td>
						<?php } else{ ?>
							<td>&nbsp;</td>
						<?php } ?>
					</tr>
		<?php 	}
			endforeach;
		?>
	</table>
	<div style="text-align: right;"><input type="submit" value="Speichern" onclick="document.formular.page.value='finals'" class="bnt btn-iw"/></div>

<?php $tabs->end(); ?>
<?php $tabs->start("Weitere Tipps"); ?>
<?php $allCountries = array(); ?>

		<?php require_once('Layout/infos.tpl'); ?>
		<?php require_once('Layout/errors.tpl'); ?>
				<h3>Wer &uuml;bersteht die Gruppenphase? -> w&auml;hle zwei Teams pro Gruppe</h3>
				<table class="table-striped table-responsive table-hover result-point">
					<tr>
						<td>Gruppe A</td>
						<td>Gruppe A</td>
						<td>Gruppe B</td>
						<td>Gruppe B</td>
					</tr>
					<tr>

						<?php $isDisabled = $this->isDisabledWeitereTipps(); ?>

						<td><select name="achtelfinal1" id="achtelfinal1" class="form-control" <?php echo $isDisabled; ?> style="width: 130px; <?php echo $this->getStyle($this->userAchtelfinal[1], 1); ?>">
							<option value=''></option>
							<?php foreach($this->getGroupTeams('A') as $country): ?>
							<?php if($this->userAchtelfinal[1] == $country['id']): ?>
							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal2" id="achtelfinal2" class="form-control" <?php echo $isDisabled; ?> style="width: 130px; <?php echo $this->getStyle($this->userAchtelfinal[2], 1); ?>">
							<option value=''></option>
							<?php foreach($this->getGroupTeams('A') as $country): ?>
							<?php if($this->userAchtelfinal[2] == $country['id']): ?>
							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal3" id="achtelfinal3" class="form-control" <?php echo $isDisabled; ?> style="width: 130px; <?php echo $this->getStyle($this->userAchtelfinal[3], 1); ?>">
							<option value=''></option>
							<?php foreach($this->getGroupTeams('B') as $country): ?>
							<?php if($this->userAchtelfinal[3] == $country['id']): ?>
							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal4" id="achtelfinal4" class="form-control" <?php echo $isDisabled; ?> style="width: 130px; <?php echo $this->getStyle($this->userAchtelfinal[4], 1); ?>">
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
						<td>Gruppe C</td>
						<td>Gruppe C</td>
						<td>Gruppe D</td>
						<td>Gruppe D</td>
					</tr>
					<tr>
						<td><select name="achtelfinal5" id="achtelfinal5" class="form-control" <?php echo $isDisabled; ?> style="width: 130px; <?php echo $this->getStyle($this->userAchtelfinal[5], 1); ?>">
							<option value=''></option>
							<?php foreach($this->getGroupTeams('C') as $country): ?>
							<?php if($this->userAchtelfinal[5] == $country['id']): ?>
							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal6" id="achtelfinal6" class="form-control" <?php echo $isDisabled; ?> style="width: 130px; <?php echo $this->getStyle($this->userAchtelfinal[6], 1); ?>">
							<option value=''></option>
							<?php foreach($this->getGroupTeams('C') as $country): ?>
							<?php if($this->userAchtelfinal[6] == $country['id']): ?>
							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal7" id="achtelfinal7" class="form-control" <?php echo $isDisabled; ?> style="width: 130px; <?php echo $this->getStyle($this->userAchtelfinal[7], 1); ?>">
							<option value=''></option>
							<?php foreach($this->getGroupTeams('D') as $country): ?>
							<?php if($this->userAchtelfinal[7] == $country['id']): ?>
							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal8" id="achtelfinal8" class="form-control" <?php echo $isDisabled; ?> style="width: 130px; <?php echo $this->getStyle($this->userAchtelfinal[8], 1); ?>">
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
						<td>Gruppe E</td>
						<td>Gruppe E</td>
						<td>Gruppe F</td>
						<td>Gruppe F</td>
					</tr>
					<tr>

						<td><select name="achtelfinal9" id="achtelfinal9" class="form-control" <?php echo $isDisabled; ?> style="width: 130px; <?php echo $this->getStyle($this->userAchtelfinal[9], 1); ?>">
							<option value=''></option>
							<?php foreach($this->getGroupTeams('E') as $country): ?>
							<?php if($this->userAchtelfinal[9] == $country['id']): ?>
							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal10" id="achtelfinal10" class="form-control" <?php echo $isDisabled; ?> style="width: 130px; <?php echo $this->getStyle($this->userAchtelfinal[10], 1); ?>">
							<option value=''></option>
							<?php foreach($this->getGroupTeams('E') as $country): ?>
							<?php if($this->userAchtelfinal[10] == $country['id']): ?>
							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal11" id="achtelfinal11" class="form-control" <?php echo $isDisabled; ?> style="width: 130px; <?php echo $this->getStyle($this->userAchtelfinal[11], 1); ?>">
							<option value=''></option>
							<?php foreach($this->getGroupTeams('F') as $country): ?>
							<?php if($this->userAchtelfinal[11] == $country['id']): ?>
							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal12" id="achtelfinal12" class="form-control" <?php echo $isDisabled; ?> style="width: 130px; <?php echo $this->getStyle($this->userAchtelfinal[12], 1); ?>">
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
						<td>Gruppe G</td>
						<td>Gruppe G</td>
						<td>Gruppe H</td>
						<td>Gruppe H</td>
					</tr>
					<tr>
						<td><select name="achtelfinal13" id="achtelfinal13" class="form-control" <?php echo $isDisabled; ?> style="width: 130px; <?php echo $this->getStyle($this->userAchtelfinal[13], 1); ?>">
							<option value=''></option>
							<?php foreach($this->getGroupTeams('G') as $country): ?>
							<?php if($this->userAchtelfinal[13] == $country['id']): ?>
							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal14" id="achtelfinal14" class="form-control" <?php echo $isDisabled; ?> style="width: 130px; <?php echo $this->getStyle($this->userAchtelfinal[14], 1); ?>">
							<option value=''></option>
							<?php foreach($this->getGroupTeams('G') as $country): ?>
							<?php if($this->userAchtelfinal[14] == $country['id']): ?>
							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal15" id="achtelfinal15" class="form-control" <?php echo $isDisabled; ?> style="width: 130px; <?php echo $this->getStyle($this->userAchtelfinal[15], 1); ?>">
							<option value=''></option>
							<?php foreach($this->getGroupTeams('H') as $country): ?>
							<?php if($this->userAchtelfinal[15] == $country['id']): ?>
							<option value="<?php echo $country['id']; ?>" selected><?php echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?php echo $country['id']; ?>"><?php echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal16" id="achtelfinal16" class="form-control" <?php echo $isDisabled; ?> style="width: 130px; <?php echo $this->getStyle($this->userAchtelfinal[16], 1); ?>">
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
						<td><select name="achtelfinal13" id="achtelfinal13" class="form-control" <?php echo $isDisabled; ?> style="width: 130px; <?php echo $this->getStyle($this->userAchtelfinal[13], 1); ?>">
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
						<td><select name="achtelfinal14" id="achtelfinal14" class="form-control" <?php echo $isDisabled; ?> style="width: 130px; <?php echo $this->getStyle($this->userAchtelfinal[14], 1); ?>">
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
						<td><select name="achtelfinal15" id="achtelfinal15" class="form-control" <?php echo $isDisabled; ?> style="width: 130px; <?php echo $this->getStyle($this->userAchtelfinal[15], 1); ?>">
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
						<td><select name="achtelfinal16" id="achtelfinal16" class="form-control" <?php echo $isDisabled; ?> style="width: 130px; <?php echo $this->getStyle($this->userAchtelfinal[16], 1); ?>">
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
			<td><select name="best" id="best" class="form-control" <?php echo $isDisabled; ?> style="width: 240px; <?php echo $this->getStyle($this->best, 17); ?>">
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
			<td><select name="worst" id="worst" class="form-control" <?php echo $isDisabled; ?> style="width: 240px; <?php echo $this->getStyle($this->worst, 18); ?>">
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
			<td><select name="switzerland" id="switzerland" class="form-control" <?php echo $isDisabled; ?> style="width: 240px; <?php echo $this->getStyle($this->switzerland, 19); ?>">
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
			<td><select name="lastwinner" id="lastwinner" class="form-control" <?php echo $isDisabled; ?> style="width: 240px; <?php echo $this->getStyle($this->lastwinner, 20); ?>">
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
			<td><select name="winner" id="winner" class="form-control" <?php echo $isDisabled; ?> style="width: 240px; <?php echo $this->getStyle($this->winner, 16); ?>">
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
		
	<div style="text-align: right;"><input type="submit" value="Speichern" onclick="document.formular.page.value='countries'" class="bnt btn-iw"/></div>
	</form>
<?php $tabs->end(); ?>
<?php $tabs->active = Constants::isAlreadyFinalround(); $tabs->run(); ?>

	</div>
	</div>
</section>