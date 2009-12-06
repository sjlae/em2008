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
				<td style="white-space: nowrap; padding-bottom: 5px; padding-left: 10px"><b>Res. 1</b></td>
				<td padding-bottom: 5px/>
				<td style="white-space: nowrap; padding-bottom: 5px"><b>Res. 2</b></td>
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
					name="result2<?php echo $spiel['id']; ?>" maxLength="2" /></td>
				
				<?php
					$points = Constants::getPointsPng($spiel['result1'],$spiel['result2'],$spiel['realresult1'],$spiel['realresult2']);
				?>
				
				<td align="right" valign="top" style="padding-left: 10px"><b><?php echo $spiel['realresult1']; ?>&nbsp;&nbsp;&nbsp;&nbsp;</b></td>
				<td align="center" valign="top"><b>:</b></td>
				<td align="left" valign="top"><b>&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $spiel['realresult2']; ?></b>
					<?php
						if($points != ""){
					?>
							&nbsp;&nbsp;<img alt="" src="Layout/<?php echo $points ?>" width="12px"/>
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
		Dieser Link --> <a href="http://de.fifa.com/worldcup/standings/index.html" target="_blank">Gruppen</a>
		soll dir bei der Benennung der 16 Achtelfinalisten weiter helfen.<br/><br/>
		Unter diesem Link --> <a href="http://de.fifa.com/worldcup/matches/kostage.html" target="_blank">Finalrunden</a>
		siehst du, welche Teams ab den Achtelfinalspielen aufeinander treffen k&ouml;nnten.
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
						<tr>
							<td style="color: red"><?php echo $this->realhauptrunde[8]; ?></td>
							<td style="color: red"><?php echo $this->realhauptrunde[9]; ?></td>
							<td style="color: red"><?php echo $this->realhauptrunde[10]; ?></td>
							<td style="color: red"><?php echo $this->realhauptrunde[11]; ?></td>
						</tr>
						<tr>
							<td style="color: red"><?php echo $this->realhauptrunde[12]; ?></td>
							<td style="color: red"><?php echo $this->realhauptrunde[13]; ?></td>
							<td style="color: red"><?php echo $this->realhauptrunde[14]; ?></td>
							<td style="color: red"><?php echo $this->realhauptrunde[15]; ?></td>
						</tr>
					<?php } ?>
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
			
				<?php $isDisabled = $this->isDisabledHauptrunde(); ?>
			
				<td><select name="viertelfinal1" <?php echo $isDisabled; ?>>
					<option value=''></option>
					<?foreach($this->countries as $country): ?>
					<?php if($this->userViertelfinal[1] == $country['id']): ?>
					<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
					<?php else:?>
					<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
					<?php endif; ?>
					<?endforeach; ?>
				</select></td>
				<td><select name="viertelfinal2" <?php echo $isDisabled; ?>>
					<option value=''></option>
					<?foreach($this->countries as $country): ?>
					<?php if($this->userViertelfinal[2] == $country['id']): ?>
					<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
					<?php else:?>
					<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
					<?php endif; ?>
					<?endforeach; ?>
				</select></td>
				<td><select name="viertelfinal3" <?php echo $isDisabled; ?>>
					<option value=''></option>
					<?foreach($this->countries as $country): ?>
					<?php if($this->userViertelfinal[3] == $country['id']): ?>
					<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
					<?php else:?>
					<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
					<?php endif; ?>
					<?endforeach; ?>
				</select></td>
				<td><select name="viertelfinal4" <?php echo $isDisabled; ?>>
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
				<td><select name="viertelfinal5" <?php echo $isDisabled; ?>>
					<option value=''></option>
					<?foreach($this->countries as $country): ?>
					<?php if($this->userViertelfinal[5] == $country['id']): ?>
					<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
					<?php else:?>
					<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
					<?php endif; ?>
					<?php endforeach; ?>
				</select></td>
				<td><select name="viertelfinal6" <?php echo $isDisabled; ?>>
					<option value=''></option>
					<?foreach($this->countries as $country): ?>
					<?php if($this->userViertelfinal[6] == $country['id']): ?>
					<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
					<?php else:?>
					<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
					<?php endif; ?>
					<?php endforeach; ?>
				</select></td>
				<td><select name="viertelfinal7" <?php echo $isDisabled; ?>>
					<option value=''></option>
					<?foreach($this->countries as $country): ?>
					<?php if($this->userViertelfinal[7] == $country['id']): ?>
					<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
					<?php else:?>
					<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
					<?php endif; ?>
					<?php endforeach; ?>
				</select></td>
				<td><select name="viertelfinal8" <?php echo $isDisabled; ?>>
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
			<?php if(Constants::$isWM ? $this->realhauptrunde[16] : $this->realhauptrunde[0] != ''){ ?>
				<tr>
					<td colspan="4" style="padding-top: 5px"><b>Tats&auml;chlich qualifizierte L&auml;nder:</b></td>
				</tr>
				<?php 
					if(Constants::$isWM){
				?>
						<tr>
							<td style="color: red"><?php echo $this->realhauptrunde[16]; ?></td>
							<td style="color: red"><?php echo $this->realhauptrunde[17]; ?></td>
							<td style="color: red"><?php echo $this->realhauptrunde[18]; ?></td>
							<td style="color: red"><?php echo $this->realhauptrunde[19]; ?></td>
						</tr>
						<tr>
							<td style="color: red"><?php echo $this->realhauptrunde[20]; ?></td>
							<td style="color: red"><?php echo $this->realhauptrunde[21]; ?></td>
							<td style="color: red"><?php echo $this->realhauptrunde[22]; ?></td>
							<td style="color: red"><?php echo $this->realhauptrunde[23]; ?></td>
						</tr>
				<?php
					} else{
				?>
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
			<?php 
					}
				} 
			?>
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
				<td><select name="halbfinal1" <?php echo $isDisabled; ?>>
					<option value=''></option>
					<?foreach($this->countries as $country): ?>
					<?php if($this->userHalbfinal[1] == $country['id']): ?>
					<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
					<?php else:?>
					<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
					<?php endif; ?>
					<?php endforeach; ?>
				</select></td>
				<td><select name="halbfinal2" <?php echo $isDisabled; ?>>
					<option value=''></option>
					<?foreach($this->countries as $country): ?>
					<?php if($this->userHalbfinal[2] == $country['id']): ?>
					<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
					<?php else:?>
					<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
					<?php endif; ?>
					<?php endforeach; ?>
				</select></td>
				<td><select name="halbfinal3" <?php echo $isDisabled; ?>>
					<option value=''></option>
					<?foreach($this->countries as $country): ?>
					<?php if($this->userHalbfinal[3] == $country['id']): ?>
					<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
					<?php else:?>
					<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
					<?php endif; ?>
					<?php endforeach; ?>
				</select></td>
				<td><select name="halbfinal4" <?php echo $isDisabled; ?>>
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
			<?php if(Constants::$isWM ? $this->realhauptrunde[24] : $this->realhauptrunde[8] != ''){ ?>
				<tr>
					<td colspan="4" style="padding-top: 5px"><b>Tats&auml;chlich qualifizierte L&auml;nder:</b></td>
				</tr>
				<?php 
					if(Constants::$isWM){
				?>
						<tr>
							<td style="color: red"><?php echo $this->realhauptrunde[24]; ?></td>
							<td style="color: red"><?php echo $this->realhauptrunde[25]; ?></td>
							<td style="color: red"><?php echo $this->realhauptrunde[26]; ?></td>
							<td style="color: red"><?php echo $this->realhauptrunde[27]; ?></td>
						</tr>
				<?php
					} else{
				?>
				<tr>
					<td style="color: red"><?php echo $this->realhauptrunde[8]; ?></td>
					<td style="color: red"><?php echo $this->realhauptrunde[9]; ?></td>
					<td style="color: red"><?php echo $this->realhauptrunde[10]; ?></td>
					<td style="color: red"><?php echo $this->realhauptrunde[11]; ?></td>
				</tr>
			<?php 
					}
				} 
			?>
		</table>
		<h3>Finalteilnehmer</h3>
		<table>
			<tr>
				<td>Team 1</td>
				<td>Team 2</td>
			</tr>
			<tr>
				<td><select name="final1" <?php echo $isDisabled; ?>>
					<option value=''></option>
					<?foreach($this->countries as $country): ?>
				<?php if($this->userFinal[1] == $country['id']): ?>
					<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
					<?php else:?>
					<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
					<?php endif; ?>
					<?php endforeach; ?>
				</select></td>
				<td><select name="final2" <?php echo $isDisabled; ?>>
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
			<?php if(Constants::$isWM ? $this->realhauptrunde[28] : $this->realhauptrunde[12] != ''){ ?>
				<tr>
					<td colspan="4" style="padding-top: 5px"><b>Tats&auml;chlich qualifizierte L&auml;nder:</b></td>
				</tr>
				<?php 
					if(Constants::$isWM){
				?>
						<tr>
							<td style="color: red"><?php echo $this->realhauptrunde[28]; ?></td>
							<td style="color: red"><?php echo $this->realhauptrunde[29]; ?></td>
						</tr>
				<?php
					} else{
				?>
				<tr>
					<td style="color: red"><?php echo $this->realhauptrunde[12]; ?></td>
					<td style="color: red"><?php echo $this->realhauptrunde[13]; ?></td>
				</tr>
			<?php 
					}
				}
			?>
		</table>
		<h3><?php echo Constants::getWinnerLabel() ?></h3>
		<div><select name="sieger" <?php echo $isDisabled; ?>>
			<option value=''></option>
			<?foreach($this->countries as $country): ?>
			<?php if($this->userSieger == $country['id']): ?>
			<option value="<?echo $country['id']; ?>" selected><?echo $country['land']; ?></option>
			<?php else:?>
			<option value="<?echo $country['id']; ?>"><?echo $country['land']; ?></option>
			<?php endif; ?>
			<?php endforeach; ?>
		</select></div>
		<?php if(Constants::$isWM ? $this->realhauptrunde[30] : $this->realhauptrunde[14] != ''){ ?>
			<div style="padding-top: 5px">
				<b>Tats&auml;chlicher <?php echo Constants::getWinnerLabel() ?>:</b>
			</div>
			<div style="color: red">
			<?php echo Constants::$isWM ? $this->realhauptrunde[30] : $this->realhauptrunde[14]; ?>
			</div>
		<?php } ?>
		<div style="text-align: right;"><input type="submit" value="Speichern" onclick="document.formular.page.value='finals'"/></div>
		<?php if($_POST['page'] == 'finals'){ $tabs->active = "Finalspiele"; } ?>
	</form>
	
<?php $tabs->end(); ?>
<?php $tabs->run(); ?>