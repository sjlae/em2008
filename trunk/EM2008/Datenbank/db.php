<?php
@mysql_connect("localhost", "root", "") OR die(mysql_error());
mysql_select_db("em2008") OR die(mysql_error());
?>