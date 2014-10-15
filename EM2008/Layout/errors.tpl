<?php if(count($this->errors) > 0): ?>
	<div style="background-color: #FF0000; padding-top: 5px; padding-bottom: 5px" id="errors">
		<p><b>Fehler:</b></p>
		<ul>	
			<?php foreach($this->errors as $error):?>
				<li><?php echo $error; ?></li>
			<?php endforeach ?>
		</ul>
	</div>
	<br/>
<?php endif?>