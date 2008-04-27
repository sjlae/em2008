<? if(count($_SESSION['infos']) > 0): ?>
	<div style="background-color: #7F99FF; padding-top: 5px; padding-bottom: 5px">
		<p><b>Information/en:</b></p>
		<ul>	
			<?foreach($_SESSION['infos'] as $info):?>
				<li><?echo $info; ?></li>
			<?endforeach ?>
			<?unset($_SESSION['infos']); ?>
		</ul>
	</div>
<?endif?>