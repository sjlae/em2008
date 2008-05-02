<?php require_once('Layout/infos.tpl'); ?>

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