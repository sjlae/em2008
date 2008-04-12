<?php
@mysql_connect("localhost:8888", "root", "root") OR die(mysql_error());
mysql_select_db("em2008") OR die(mysql_error());
?>