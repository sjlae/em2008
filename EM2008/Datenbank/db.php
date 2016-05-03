<?php

class Db {
	static function getConnection() {
		$link = @mysql_connect("localhost:8889", "root", "root") OR die(mysql_error());
		mysql_select_db("em2008") OR die(mysql_error());
		
		return $link;
	}
}
?>