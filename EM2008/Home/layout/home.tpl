<h2 id="cont">Startseite</h2>
<?php require_once('Layout/infos.tpl'); ?>

<div style="color:red"><b>WICHTIG!!!</b></div>
Falls Sie den Internet Explorer als Webbrowser ben&uuml;tzen und nicht einloggen k&ouml;nnen, 
dann m&uuml;ssen Sie im Webbrowser unter Extras die <b>Internetoptionen</b> &ouml;ffnen, auf den 
Tab <b>Datenschutz</b> navigieren und dann auf den Button 'Sites' klicken. Dort die Seite <b>gabathuler.de</b> 
hinzuf&uuml;gen (als 'zulassen') und den Webbrowser neu starten.Danach sollte alles einwandfrei funktionieren.

<table>
	<?php
		foreach($this->news as $article): 
	?>
			<tr>
				<td>
					<h3>
						<?php
							echo $article['date'];
						?>
						-
						<?php
							echo $article['title'];
						?>
					</h3>
				</td>
			</tr>
			<tr>
				<td>
					<?php
						echo $article['text'];
					?>				
				</td>
			</tr>
	<?php		
		endforeach;
	?>
</table>