<? if(count($this->errors) > 0): ?>
	<div style="background-color: #FF0000; padding-top: 5px; padding-bottom: 5px">
		<p><b>Fehler:</b></p>
		<ul>	
			<?foreach($this->errors as $error):?>
				<li><?echo $error; ?></li>
			<?endforeach ?>
		</ul>
	</div>
<?endif?>