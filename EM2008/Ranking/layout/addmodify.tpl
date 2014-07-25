<h2>Gruppe erstellen / bearbeiten</h2>
<?php require_once('Layout/infos.tpl'); ?>
<?php require_once('Layout/errors.tpl'); ?>
<form action="index.php?go=ranking&action=savegroup" name="formular" method="POST">
<? if(isset($this->gruppeid) && $this->gruppeid != ''){ ?>
	 <input type="hidden" name="gruppeid" value="<? echo $this->gruppeid ?>" />
<? } ?>

	Gruppenname:
	<input type="text" style="width: 150px;" value="<?php echo $this->gruppenname; ?>" name="gruppenname" maxLength="30" />
	<? if(isset($this->gruppeid)){ ?>
		 <input type="button" value="Gruppe l&ouml;schen" onclick="document.forms['deletegroup'].submit()"/>
	<? } ?>
<table>
	<tr>
		<td>
			<b>&nbsp;</b>
		</td>
		<td style="padding-left: 20px">
			<b>Vorname</b>
		</td>
		<td style="padding-left: 20px">
			<b>Nachname</b>
		</td>
	</tr>
	<tr />
	<? 
		if($this->rankingArray != null){
			foreach($this->rankingArray as $ranking): 
	?>
				<tr style="background-color: <? if($_SESSION['userid'] == $ranking['userid']){ echo 'yellow'; } ?>;">
					<td>
						<? if(array_search($ranking['userid'], $this->currentUsers)){ ?>
							 <input type="checkbox" name="users_group[]" value="<?php echo $ranking['userid']; ?>" checked />
						<? } else{ ?>
							 <input type="checkbox" name="users_group[]" value="<?php echo $ranking['userid']; ?>" />
					 	<? } ?>
					</td>
					<td style="padding-left: 20px;">
						<?echo $ranking['vorname']?>
					</td>
					<td style="padding-left: 20px;">
						<?echo $ranking['nachname']?>
					</td>
				</tr>
	<? 
			endforeach; 
		}
	?>
</table>
<br>
<input type="submit" value="Gruppe speichern" />
	
<script type="text/javascript">
	$(document).ready(function() {
		$('input[name="gruppenname"]').focus();
	});
</script>
</form>
<form action="index.php?go=ranking&action=deletegroup&gruppeid=<? echo $this->gruppeid; ?>" name="deletegroup" method="POST" />