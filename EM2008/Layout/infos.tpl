<? if(count($_SESSION['infos']) > 0): ?>
<p>Information/en:</p>
<ul>	
<?foreach($_SESSION['infos'] as $info):?>
	<li><?echo $info; ?></li>
<?endforeach ?>
<?unset($_SESSION['infos']); ?>
</ul>
<?endif?>