<h2>Rangliste</h2>

<table>
	<tr>
		<td>
			<b>Rang</b>
		</td>
		<td style="padding-left: 10px">
			<b>Vorname</b>
		</td>
		<td style="padding-left: 10px">
			<b>Nachname</b>
		</td>
		<td style="padding-left: 10px">
			<b>Punkte</b>
		</td>
	</tr>
	<tr />
	<? 
		$rang = 1;
		$previousPoints = null;
		
		if($rankingArray != null){
			foreach($rankingArray as $ranking): 
	?>
				<tr>
					<td>
						<?
							if($previousPoints != $ranking['punkte']){
								echo $rang
						?>
								.
						<?
							}
						?>
					</td>
					<?
						if($ranking['bezahlt'] == 0){
					?>
							<td style="padding-left: 10px; color: red">
								<?echo $ranking['vorname']?>
							</td>
							<td style="padding-left: 10px; color:red">
								<?echo $ranking['nachname'] ?>
								(nnb)
							</td>
					<?
						}
						else{
					?>
							<td style="padding-left: 10px;">
								<?echo $ranking['vorname']?>
							</td>
							<td style="padding-left: 10px;">
								<?echo $ranking['nachname'] ?>
							</td>
					<?
						}
					?>
					<td style="padding-left: 10px">
						<?echo $ranking['punkte'] ?>
					</td>
				</tr>
	<? 
			$rang++;
			$previousPoints = $ranking['punkte'];
			endforeach; 
		}
	?>
</table>
<br><br>
<span style="color: red">nnb --> noch nicht bezahlt</span>