<? if(count($this->errors) > 0): ?>
<p>Fehler</p>
<ul>	
<?foreach($this->errors as $error):?>
	<li><?echo $error; ?></li>
<?endforeach ?>
</ul>
<?endif?>