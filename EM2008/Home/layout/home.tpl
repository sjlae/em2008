<?php require_once('Layout/infos.tpl'); ?>

<div style="color:#FF0000;padding-top:15px"><b>WICHTIG!!!</b></div>
<div style="background-color: #FFFF99">
Falls Sie den Internet Explorer als Webbrowser ben&uuml;tzen und nicht einloggen k&ouml;nnen, 
dann m&uuml;ssen Sie im Webbrowser unter Extras die <b>Internetoptionen</b> &ouml;ffnen, auf den 
Tab <b>Datenschutz</b> navigieren und dann auf den Button 'Sites' klicken. Dort die Seite <b>gabathuler.de</b> 
hinzuf&uuml;gen (als 'zulassen') und den Webbrowser neu starten.Danach sollte alles einwandfrei funktionieren.
</div>

<div style="padding-top: 20px">
	<h2>NEWS</h2>
</div>

<?php
	foreach($this->news as $article): 
?>
	<h3>
		<?php
			echo $article['date'];
		?>
		-
		<?php
			echo $article['title'];
		?>
	</h3>
	
	<?php
		echo $article['text'];
	?>	
<?php		
	endforeach;
?>