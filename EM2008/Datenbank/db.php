<?php

class Db {
	static function getConnection() {
		/*
	    $link = mysql_connect("localhost", "root", "") OR die(mysql_error());
		mysql_select_db("em2008") OR die(mysql_error());
		
		return $link;
		*/
	    $mysqli = mysqli_connect("localhost", "root", "", "em2008");
		if ($mysqli->connect_errno) {
		    echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
		}
		return $mysqli;
	}
}
?>