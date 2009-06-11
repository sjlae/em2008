<?php
	//Gib den Endzeitpunkt an!
	$endTime = mktime(16, 00, 0, 06, 11, 2010); //WM start: 16, 00, 0, 06, 11, 2010
	
	//Aktuellezeit des microtimestamps nach PHP5, für PHP4 muss eine andere Form genutzt werden.
	$timeNow = microtime(true);
	
	if($timeNow < $endTime){
		//Berechnet differenz von der Endzeit vom jetzigen Zeitpunkt aus.
		$diffTime = $endTime - $timeNow;
		
		//Zerlegt $diffTime am Dezimalpunkt, rundet vorher auf 2 Stellen nach dem Dezimalpunkt und gibt diese zurück.
		$milli = explode(".", round($diffTime, 2));
		$millisec = round($milli[1]);
		
		//Berechnung für Tage, Stunden, Minuten
		$day = floor($diffTime / (24*3600));
		$diffTime = $diffTime % (24*3600);
		$houre = floor($diffTime / (60*60));
		$diffTime = $diffTime % (60*60);
		$min = floor($diffTime / 60);
		$sec = $diffTime % 60;
		
		//Ausgabe von $day (Tage), $houre (Stunden), $sec (Sekunden), $millisec (Millisekunden)
		echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		echo "<span style='color: red;'>";
		echo "<b>Countdown:</b>  ";
		echo $day." Tage ";
		echo $houre." Stunden ";
		echo $min." Minuten ";
		echo $sec." Sec ";
		echo "</span>";
	}
?> 