<h2>Gruppe erstellen / bearbeiten</h2>
<?php require_once('Layout/infos.tpl'); ?>
<?php require_once('Layout/errors.tpl'); ?>
<form action="index.php?go=ranking&action=savegroup" name="formular" method="POST">
<?php if(isset($this->gruppeid) && $this->gruppeid != ''){ ?>
	 <input type="hidden" name="gruppeid" value="<?php echo $this->gruppeid ?>" />
<?php } ?>

	Gruppenname:
	<input type="text" style="width: 150px;" value="<?php echo $this->gruppenname; ?>" name="gruppenname" maxLength="30" />
	<?php if(isset($this->gruppeid)){ ?>
		 <input type="button" value="Gruppe l&ouml;schen" onclick="document.forms['deletegroup'].submit()"/>
	<?php } ?>
<table>
	<tr>
		<td>
			<b>&nbsp;</b>
		</td>
		<td style="padding-left: 20px">
			<b>Nachname</b>
		</td>
		<td style="padding-left: 20px">
			<b>Vorname</b>
		</td>
	</tr>
	<tr />
	<?php 
		if($this->rankingArray != null){
			foreach($this->rankingArray as $ranking): 
	?>
				<tr style="background-color: <?php if($_SESSION['userid'] == $ranking['userid']){ echo 'yellow'; } ?>;">
					<td>
						<?php if(array_search($ranking['userid'], $this->currentUsers)){ ?>
							 <input type="checkbox" name="users_group[]" value="<?php echo $ranking['userid']; ?>" checked />
						<?php } else{ ?>
							 <input type="checkbox" name="users_group[]" value="<?php echo $ranking['userid']; ?>" />
					 	<?php } ?>
					</td>
					<td style="padding-left: 20px;">
						<?php echo $ranking['nachname']?>
					</td>
					<td style="padding-left: 20px;">
						<?php echo $ranking['vorname']?>
					</td>
				</tr>
	<?php 
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
<form action="index.php?go=ranking&action=deletegroup&gruppeid=<?php echo $this->gruppeid; ?>" name="deletegroup" method="POST" />