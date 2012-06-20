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
		<div style="text-align: right;"><input type="submit" value="Speichern" onclick="document.formular.page.value='groups'"/></div>
		<?php if($_GET['page'] == 'groups'){ $tabs->active = "Gruppenspiele"; } ?>

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
					
						<td><select name="achtelfinal1" id="achtelfinal1" <?php echo $isDisabled; ?> style="width: 110px;">
							<option value=''></option>
							<?foreach($this->getGroupTeams('A') as $country): ?>
							<?php if($this->userAchtelfinal[1] == $country['id']): ?>
							<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
							<?php endif; ?>
							<?endforeach; ?>
						</select></td>
						<td><select name="achtelfinal2" id="achtelfinal2" <?php echo $isDisabled; ?> style="width: 110px;">
							<option value=''></option>
							<?foreach($this->getGroupTeams('A') as $country): ?>
							<?php if($this->userAchtelfinal[2] == $country['id']): ?>
							<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
							<?php endif; ?>
							<?endforeach; ?>
						</select></td>
						<td><select name="achtelfinal3" id="achtelfinal3" <?php echo $isDisabled; ?> style="width: 110px;">
							<option value=''></option>
							<?foreach($this->getGroupTeams('B') as $country): ?>
							<?php if($this->userAchtelfinal[3] == $country['id']): ?>
							<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
							<?php endif; ?>
							<?endforeach; ?>
						</select></td>
						<td><select name="achtelfinal4" id="achtelfinal4" <?php echo $isDisabled; ?> style="width: 110px;">
							<option value=''></option>
							<?foreach($this->getGroupTeams('B') as $country): ?>
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
						<td><select name="achtelfinal5" id="achtelfinal5" <?php echo $isDisabled; ?> style="width: 110px;">
							<option value=''></option>
							<?foreach($this->getGroupTeams('C') as $country): ?>
							<?php if($this->userAchtelfinal[5] == $country['id']): ?>
							<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal6" id="achtelfinal6" <?php echo $isDisabled; ?> style="width: 110px;">
							<option value=''></option>
							<?foreach($this->getGroupTeams('C') as $country): ?>
							<?php if($this->userAchtelfinal[6] == $country['id']): ?>
							<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal7" id="achtelfinal7" <?php echo $isDisabled; ?> style="width: 110px;">
							<option value=''></option>
							<?foreach($this->getGroupTeams('D') as $country): ?>
							<?php if($this->userAchtelfinal[7] == $country['id']): ?>
							<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal8" id="achtelfinal8" <?php echo $isDisabled; ?> style="width: 110px;">
							<option value=''></option>
							<?foreach($this->getGroupTeams('D') as $country): ?>
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
					
						<td><select name="achtelfinal9" id="achtelfinal9" <?php echo $isDisabled; ?> style="width: 110px;">
							<option value=''></option>
							<?foreach($this->getGroupTeams('E') as $country): ?>
							<?php if($this->userAchtelfinal[9] == $country['id']): ?>
							<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
							<?php endif; ?>
							<?endforeach; ?>
						</select></td>
						<td><select name="achtelfinal10" id="achtelfinal10" <?php echo $isDisabled; ?> style="width: 110px;">
							<option value=''></option>
							<?foreach($this->getGroupTeams('E') as $country): ?>
							<?php if($this->userAchtelfinal[10] == $country['id']): ?>
							<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
							<?php endif; ?>
							<?endforeach; ?>
						</select></td>
						<td><select name="achtelfinal11" id="achtelfinal11" <?php echo $isDisabled; ?> style="width: 110px;">
							<option value=''></option>
							<?foreach($this->getGroupTeams('F') as $country): ?>
							<?php if($this->userAchtelfinal[11] == $country['id']): ?>
							<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
							<?php endif; ?>
							<?endforeach; ?>
						</select></td>
						<td><select name="achtelfinal12" id="achtelfinal12" <?php echo $isDisabled; ?> style="width: 110px;">
							<option value=''></option>
							<?foreach($this->getGroupTeams('F') as $country): ?>
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
						<td><select name="achtelfinal13" id="achtelfinal13" <?php echo $isDisabled; ?> style="width: 110px;">
							<option value=''></option>
							<?foreach($this->getGroupTeams('G') as $country): ?>
							<?php if($this->userAchtelfinal[13] == $country['id']): ?>
							<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal14" id="achtelfinal14" <?php echo $isDisabled; ?> style="width: 110px;">
							<option value=''></option>
							<?foreach($this->getGroupTeams('G') as $country): ?>
							<?php if($this->userAchtelfinal[14] == $country['id']): ?>
							<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal15" id="achtelfinal15" <?php echo $isDisabled; ?> style="width: 110px;">
							<option value=''></option>
							<?foreach($this->getGroupTeams('H') as $country): ?>
							<?php if($this->userAchtelfinal[15] == $country['id']): ?>
							<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
							<?php else:?>
							<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
							<?php endif; ?>
							<?php endforeach; ?>
						</select></td>
						<td><select name="achtelfinal16" id="achtelfinal16" <?php echo $isDisabled; ?> style="width: 110px;">
							<option value=''></option>
							<?foreach($this->getGroupTeams('H') as $country): ?>
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
				<td>Sieger Gruppe A</td>
				<td>Zweiter Gruppe A</td>
				<td>Sieger Gruppe B</td>
				<td>Zweiter Gruppe B</td>
			</tr>
			<tr>
			
				<?php $isDisabled = $this->isDisabledHauptrunde(); ?>
			
				<td><select name="viertelfinal1" id="viertelfinal1" <?php echo $isDisabled; ?> style="width: 110px; <?php if($this->realhauptrunde[0] != ''){echo $this->getStyle($this->userViertelfinal[1], 2);} ?>">
					<option value=''></option>
					<?foreach($this->getGroupTeams('A') as $country): ?>
						<?php if($this->userViertelfinal[1] == $country['id']): ?>
							<option value="<?echo $country['id']; ?>" selected="selected"><?echo $country['land']; ?></option>
						<?php else:?>
							<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
						<?php endif; ?>
					<?endforeach; ?>
				</select></td>
				<td><select name="viertelfinal2" id="viertelfinal2" <?php echo $isDisabled; ?> style="width: 110px;<?php if($this->realhauptrunde[1] != ''){echo $this->getStyle($this->userViertelfinal[2], 2);} ?>">
					<option value=''></option>
					<?foreach($this->getGroupTeams('A') as $country): ?>
					<?php if($this->userViertelfinal[2] == $country['id']): ?>
					<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
					<?php else:?>
					<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
					<?php endif; ?>
					<?endforeach; ?>
				</select></td>
				<td><select name="viertelfinal3" id="viertelfinal3" <?php echo $isDisabled; ?> style="width: 110px;<?php if($this->realhauptrunde[2] != ''){echo $this->getStyle($this->userViertelfinal[3], 2);} ?>">
					<option value=''></option>
					<?foreach($this->getGroupTeams('B') as $country): ?>
					<?php if($this->userViertelfinal[3] == $country['id']): ?>
					<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
					<?php else:?>
					<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
					<?php endif; ?>
					<?endforeach; ?>
				</select></td>
				<td><select name="viertelfinal4" id="viertelfinal4" <?php echo $isDisabled; ?> style="width: 110px;<?php if($this->realhauptrunde[3] != ''){echo $this->getStyle($this->userViertelfinal[4], 2);} ?>">
					<option value=''></option>
					<?foreach($this->getGroupTeams('B') as $country): ?>
					<?php if($this->userViertelfinal[4] == $country['id']): ?>
					<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
					<?php else:?>
					<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
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
				<td><select name="viertelfinal5" id="viertelfinal5" <?php echo $isDisabled; ?> style="width: 110px;<?php if($this->realhauptrunde[4] != ''){echo $this->getStyle($this->userViertelfinal[5], 2);} ?>">
					<option value=''></option>
					<?foreach($this->getGroupTeams('C') as $country): ?>
					<?php if($this->userViertelfinal[5] == $country['id']): ?>
					<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
					<?php else:?>
					<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
					<?php endif; ?>
					<?php endforeach; ?>
				</select></td>
				<td><select name="viertelfinal6" id="viertelfinal6" <?php echo $isDisabled; ?> style="width: 110px;<?php if($this->realhauptrunde[5] != ''){echo $this->getStyle($this->userViertelfinal[6], 2);} ?>">
					<option value=''></option>
					<?foreach($this->getGroupTeams('C') as $country): ?>
					<?php if($this->userViertelfinal[6] == $country['id']): ?>
					<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
					<?php else:?>
					<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
					<?php endif; ?>
					<?php endforeach; ?>
				</select></td>
				<td><select name="viertelfinal7" id="viertelfinal7" <?php echo $isDisabled; ?> style="width: 110px;<?php if($this->realhauptrunde[6] != ''){echo $this->getStyle($this->userViertelfinal[7], 2);} ?>">
					<option value=''></option>
					<?foreach($this->getGroupTeams('D') as $country): ?>
					<?php if($this->userViertelfinal[7] == $country['id']): ?>
					<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
					<?php else:?>
					<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
					<?php endif; ?>
					<?php endforeach; ?>
				</select></td>
				<td><select name="viertelfinal8" id="viertelfinal8" <?php echo $isDisabled; ?> style="width: 110px;<?php if($this->realhauptrunde[7] != ''){echo $this->getStyle($this->userViertelfinal[8], 2);} ?>">
					<option value=''></option>
					<?foreach($this->getGroupTeams('D') as $country): ?>
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
				<td>1A - 2B</td>
				<td>1B - 2A</td>
				<td>1C - 2D</td>
				<td>1D - 2C</td>
			</tr>
			<tr>
				<td><select name="halbfinal1" id="halbfinal1" <?php echo $isDisabled; ?> style="width: 110px;<?php if($this->realhauptrunde[9] != ''){echo $this->getStyle($this->userHalbfinal[1], 3);} ?>">
					<option value=''></option>
				</select></td>
				<td><select name="halbfinal2" id="halbfinal2" <?php echo $isDisabled; ?> style="width: 110px;<?php if($this->realhauptrunde[9] != ''){echo $this->getStyle($this->userHalbfinal[2], 3);} ?>">
					<option value=''></option>
				</select></td>
				<td><select name="halbfinal3" id="halbfinal3" <?php echo $isDisabled; ?> style="width: 110px;<?php if($this->realhauptrunde[11] != ''){echo $this->getStyle($this->userHalbfinal[3], 3);} ?>">
					<option value=''></option>
				</select></td>
				<td><select name="halbfinal4" id="halbfinal4" <?php echo $isDisabled; ?> style="width: 110px;<?php if($this->realhauptrunde[11] != ''){echo $this->getStyle($this->userHalbfinal[4], 3);} ?>">
					<option value=''></option>
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
				<td><select name="final1" id="final1" <?php echo $isDisabled; ?> style="width: 110px;<?php if($this->realhauptrunde[13] != ''){echo $this->getStyle($this->userFinal[1], 4);} ?>">
					<option value=''></option>
				</select></td>
				<td><select name="final2" id="final2" <?php echo $isDisabled; ?> style="width: 110px;<?php if($this->realhauptrunde[13] != ''){echo $this->getStyle($this->userFinal[2], 4);} ?>">
				<option value=''></option>
				</select></td>
			</tr>
		</table>
		<h3><?php echo Constants::getWinnerLabel() ?></h3>
		<div><select name="sieger" id="sieger" <?php echo $isDisabled; ?> style="width: 110px;<?php echo $this->getStyle($this->userSieger, 5); ?>">
			<option value=''></option>
		</select></div>
		<div style="text-align: right;"><input type="submit" value="Speichern" onclick="document.formular.page.value='finals'"/></div>
		<?php if($_POST['page'] == 'finals'){ $tabs->active = "Finalspiele"; } ?>
	</form>
	<script type="text/javascript">
		$(document).ready(function() {
			//VIERTELFINAL
			if($('#viertelfinal1').val() != '') {
				var selectedoption = $('option[value="' + $('#viertelfinal1').val() + '"]', $('#viertelfinal1'));
				selectedoption.clone().appendTo($('#halbfinal1'));
			}
			if($('#viertelfinal4').val() != '') {
				var selectedoption = $('option[value="' + $('#viertelfinal4').val() + '"]', $('#viertelfinal4'));
				selectedoption.clone().appendTo($('#halbfinal1'));
			}
			
			// start check which halbfinal1 to select
			var halbfinal1 = '';
			
			<?php if($this->userHalbfinal[1] != '') { ?>
				halbfinal1 = <? echo $this->userHalbfinal[1]; ?>;
			<? } ?>
			
			var halbfinal1Select = $('#halbfinal1');
			
			$('option', halbfinal1Select).each(function(){
				$(this).removeAttr('selected');
			});
			
			$('option[value="' + halbfinal1 + '"]', halbfinal1Select).attr("selected", "selected");
			//end
			
			if($('#viertelfinal2').val() != '') {
				var selectedoption = $('option[value="' + $('#viertelfinal2').val() + '"]', $('#viertelfinal2'));
				selectedoption.clone().appendTo($('#halbfinal2'));
			}
			if($('#viertelfinal3').val() != '') {
				var selectedoption = $('option[value="' + $('#viertelfinal3').val() + '"]', $('#viertelfinal3'));
				selectedoption.clone().appendTo($('#halbfinal2'));
			}
			
			// start check which halbfinal2 to select
			var halbfinal2 = '';
			
			<?php if($this->userHalbfinal[2] != '') { ?>
				halbfinal2 = <? echo $this->userHalbfinal[2]; ?>;
			<? } ?>
			
			var halbfinal2Select = $('#halbfinal2');
			
			$('option', halbfinal2Select).each(function(){
				$(this).removeAttr('selected');
			});
			
			$('option[value="' + halbfinal2 + '"]', halbfinal2Select).attr("selected", "selected");
			//end
			
			if($('#viertelfinal5').val() != '') {
				var selectedoption = $('option[value="' + $('#viertelfinal5').val() + '"]', $('#viertelfinal5'));
				selectedoption.clone().appendTo($('#halbfinal3'));
			}
			if($('#viertelfinal8').val() != '') {
				var selectedoption = $('option[value="' + $('#viertelfinal8').val() + '"]', $('#viertelfinal8'));
				selectedoption.clone().appendTo($('#halbfinal3'));
			}
			
			// start check which halbfinal3 to select
			var halbfinal3 = '';
			
			<?php if($this->userHalbfinal[3] != '') { ?>
				halbfinal3 = <? echo $this->userHalbfinal[3]; ?>;
			<? } ?>
			
			var halbfinal3Select = $('#halbfinal3');
			
			$('option', halbfinal3Select).each(function(){
				$(this).removeAttr('selected');
			});
			
			$('option[value="' + halbfinal3 + '"]', halbfinal3Select).attr("selected", "selected");
			//end
			
			if($('#viertelfinal6').val() != '') {
				var selectedoption = $('option[value="' + $('#viertelfinal6').val() + '"]', $('#viertelfinal6'));
				selectedoption.clone().appendTo($('#halbfinal4'));
			}
			if($('#viertelfinal7').val() != '') {
				var selectedoption = $('option[value="' + $('#viertelfinal7').val() + '"]', $('#viertelfinal7'));
				selectedoption.clone().appendTo($('#halbfinal4'));
			}
			
			// start check which halbfinal4 to select
			var halbfinal4 = '';
			
			<?php if($this->userHalbfinal[4] != '') { ?>
				halbfinal4 = <? echo $this->userHalbfinal[4]; ?>;
			<? } ?>
			
			var halbfinal4Select = $('#halbfinal4');
			
			$('option', halbfinal4Select).each(function(){
				$(this).removeAttr('selected');
			});
			
			$('option[value="' + halbfinal4 + '"]', halbfinal4Select).attr("selected", "selected");
			//end
			
			//HALBFINALE
			if($('#halbfinal1').val() != '') {
				var selectedoption = $('option[value="' + $('#halbfinal1').val() + '"]', $('#halbfinal1'));
				selectedoption.clone().appendTo($('#final1'));
			}
			if($('#halbfinal3').val() != '') {
				var selectedoption = $('option[value="' + $('#halbfinal3').val() + '"]', $('#halbfinal3'));
				selectedoption.clone().appendTo($('#final1'));
			}
			
			// start check which final1 to select
			var final1 = '';
			
			<?php if($this->userFinal[1] != '') { ?>
				final1 = <? echo $this->userFinal[1]; ?>;
			<? } ?>
			
			var final1Select = $('#final1');
			
			$('option', final1Select).each(function(){
				$(this).removeAttr('selected');
			});
			
			$('option[value="' + final1 + '"]', final1Select).attr("selected", "selected");
			//end
			
			if($('#halbfinal2').val() != '') {
				var selectedoption = $('option[value="' + $('#halbfinal2').val() + '"]', $('#halbfinal2'));
				selectedoption.clone().appendTo($('#final2'));
			}
			if($('#halbfinal4').val() != '') {
				var selectedoption = $('option[value="' + $('#halbfinal4').val() + '"]', $('#halbfinal4'));
				selectedoption.clone().appendTo($('#final2'));
			}
			
			// start check which final2 to select
			var final2 = '';
			
			<?php if($this->userFinal[2] != '') { ?>
				final2 = <? echo $this->userFinal[2]; ?>;
			<? } ?>
			
			var final2Select = $('#final2');
			
			$('option', final2Select).each(function(){
				$(this).removeAttr('selected');
			});
			
			$('option[value="' + final2 + '"]', final2Select).attr("selected", "selected");
			//end
			
			//Sieger
			if($('#final1').val() != '') {
				var selectedoption = $('option[value="' + $('#final1').val() + '"]', $('#final1'));
				selectedoption.clone().appendTo($('#sieger'));
			}
			if($('#final2').val() != '') {
				var selectedoption = $('option[value="' + $('#final2').val() + '"]', $('#final2'));
				selectedoption.clone().appendTo($('#sieger'));
			}
			
			// start check which sieger to select
			var sieger = '';
			
			<?php if($this->userSieger != '') { ?>
				sieger = <? echo $this->userSieger; ?>;
			<? } ?>
			
			var siegerSelect = $('#sieger');
			
			$('option', siegerSelect).each(function(){
				$(this).removeAttr('selected');
			});
			
			$('option[value="' + sieger + '"]', siegerSelect).attr("selected", "selected");
			//end
		});
		
		$('#viertelfinal1,#viertelfinal4').change(function () {
			var select = $(this);
			$('option', select).each(function(){
				var option = ($('option[value="' + $(this).val() + '"]'));
				if(option.val() != ''){
					$('option[value="' + $(this).val() + '"]', $('#halbfinal1')).remove();
					$('option[value="' + $(this).val() + '"]', $('#final1')).remove();
					$('option[value="' + $(this).val() + '"]', $('#sieger')).remove();
				}
			});
			if(select.val() != '') {
				var selectedoption = $('option[value="' + select.val() + '"]', select);
				selectedoption.clone().appendTo($('#halbfinal1'));
			}
		});
		$('#viertelfinal2,#viertelfinal3').change(function () {
			var select = $(this);
			$('option', select).each(function(){
				var option = ($('option[value="' + $(this).val() + '"]'));
				if(option.val() != ''){
					$('option[value="' + $(this).val() + '"]', $('#halbfinal2')).remove();
					$('option[value="' + $(this).val() + '"]', $('#final2')).remove();
					$('option[value="' + $(this).val() + '"]', $('#sieger')).remove();
				}
			});
			if(select.val() != '') {
				var selectedoption = $('option[value="' + select.val() + '"]', select);
				selectedoption.clone().appendTo($('#halbfinal2'));
			}
		});
		$('#viertelfinal5,#viertelfinal8').change(function () {
			var select = $(this);
			$('option', select).each(function(){
				var option = ($('option[value="' + $(this).val() + '"]'));
				if(option.val() != ''){
					$('option[value="' + $(this).val() + '"]', $('#halbfinal3')).remove();
					$('option[value="' + $(this).val() + '"]', $('#final1')).remove();
					$('option[value="' + $(this).val() + '"]', $('#sieger')).remove();
				}
			});
			if(select.val() != '') {
				var selectedoption = $('option[value="' + select.val() + '"]', select);
				selectedoption.clone().appendTo($('#halbfinal3'));
			}
		});
		$('#viertelfinal6,#viertelfinal7').change(function () {
			var select = $(this);
			$('option', select).each(function(){
				var option = ($('option[value="' + $(this).val() + '"]'));
				if(option.val() != ''){
					$('option[value="' + $(this).val() + '"]', $('#halbfinal4')).remove();
					$('option[value="' + $(this).val() + '"]', $('#final2')).remove();
					$('option[value="' + $(this).val() + '"]', $('#sieger')).remove();
				}
			});
			if(select.val() != '') {
				var selectedoption = $('option[value="' + select.val() + '"]', select);
				selectedoption.clone().appendTo($('#halbfinal4'));
			}
		});
		$('#halbfinal1,#halbfinal3').change(function () {
			var select = $(this);
			$('option', select).each(function(){
				var option = ($('option[value="' + $(this).val() + '"]'));
				if(option.val() != ''){
					$('option[value="' + $(this).val() + '"]', $('#final1')).remove();
					$('option[value="' + $(this).val() + '"]', $('#sieger')).remove();
				}
			});
			if(select.val() != '') {
				var selectedoption = $('option[value="' + select.val() + '"]', select);
				selectedoption.clone().appendTo($('#final1'));
			}
		});
		$('#halbfinal2,#halbfinal4').change(function () {
			var select = $(this);
			$('option', select).each(function(){
				var option = ($('option[value="' + $(this).val() + '"]'));
				if(option.val() != ''){
					$('option[value="' + $(this).val() + '"]', $('#final2')).remove();
					$('option[value="' + $(this).val() + '"]', $('#sieger')).remove();
				}
			});
			if(select.val() != '') {
				var selectedoption = $('option[value="' + select.val() + '"]', select);
				selectedoption.clone().appendTo($('#final2'));
			}
		});
		$('#final1,#final2').change(function () {
			var select = $(this);
			$('option', select).each(function(){
				var option = ($('option[value="' + $(this).val() + '"]'));
				if(option.val() != ''){
					$('option[value="' + $(this).val() + '"]', $('#sieger')).remove();
				}
			});
			if(select.val() != '') {
				var selectedoption = $('option[value="' + select.val() + '"]', select);
				selectedoption.clone().appendTo($('#sieger'));
			}
		});
	</script>
<?php $tabs->end(); ?>
<?php $tabs->run(); ?>