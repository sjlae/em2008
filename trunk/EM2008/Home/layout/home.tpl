<h2 id="cont">Startseite</h2>
<?php require_once('Layout/infos.tpl'); ?>

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