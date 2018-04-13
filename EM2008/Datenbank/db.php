<?php

class Db {
	static function getConnection() {
		$link = mysql_connect("db", "root", "") OR die(mysql_error());
		mysql_select_db("em2008") OR die(mysql_error());
		
		return $link;
	}
}
?>