<h2>Passwort &auml;ndern</h2>
<?php require_once('Layout/infos.tpl'); ?>
<?php require_once('Layout/errors.tpl'); ?>
<?php require_once('Layout/Tabs.php'); ?>

<?php $tabs = new Tabs("Profil"); ?>
<?php $tabs->start("Passwort"); ?>

<form action="index.php?go=changePassword&action=change" method="POST">
	<table>
		<tr>
			<td style="padding-top: 5px">	
				Altes Passwort:
			</td>
			<td>
				<input type="password" name="oldPassword" value="<?php echo htmlentities($this->oldPassword, ENT_COMPAT, 'UTF-8'); ?>" style="width: 150px" />
			</td>
		</tr>
		<tr> 
			<td style="padding-top: 5px">	
				Neues Passwort:
			</td>
			<td>
				<input type="password" name="newPassword1" value="<?php echo htmlentities($this->newPassword1, ENT_COMPAT, 'UTF-8'); ?>" style="width: 150px" />
			</td>
		</tr>
		<tr>
			<td style="padding-top: 5px">	
				Neues Passwort wiederholen:
			</td>
			<td>
				<input type="password" name="newPassword2" value="<?php echo htmlentities($this->newPassword2, ENT_COMPAT, 'UTF-8'); ?>" style="width: 150px" />
			</td>
		</tr>
		<tr>
			<td style="padding-top: 10px">
				<input type="submit" value="Speichern" />
			</td
		</tr>
	</table>
</form>

<?php $tabs->end(); ?>
<?php $tabs->start("Reminder"); ?>

<form action="index.php?go=changePassword&action=reminder" method="POST">
	<table>
		<tr>
			<td style="padding-top: 5px; colspan="2">	
				<?php 
					$color = $this->reminder == '1' ? 'green' : 'red'; 
					$text = $this->reminder == '1' ? 'EIN' : 'AUS';
				?>
				Aktuelle Remindereinstellung: <b style="color: <?php echo $color;?>;"><?php echo $text; ?></b>
			</td>
		</tr>
		<tr>
			<td style="padding-top: 5px">	
				Anw&auml;hlen sofern t&auml;glicher Reminder per Mail erw&uuml;nscht.
			</td>
			<td>
				<input type="checkbox" name="reminder" <?php echo $this->reminder == '1' ? 'checked' : ''; ?>/>
			</td>
		</tr>
		<tr>
			<td style="padding-top: 10px">
				<input type="submit" value="Speichern" />
			</td
		</tr>
	</table>
</form>
<?php $tabs->active = $this->action != 'reminder' ? "Passwort" : "Reminder"; ?>
<?php $tabs->end(); ?>
<?php $tabs->run(); ?>