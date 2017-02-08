<?php
/*
 * Created on 17-okt-2011
 * author Paul Wolbers
 */

function database_connect() {
    global $obj_db;

    // get calendar database
     if($_SERVER["HTTP_HOST"] == 'localhost') {
    	DEFINE('DBHOST','localhost');
		DEFINE('DBUSER','root');
		DEFINE('DBPASS','peewee');
    	DEFINE('DBNAAM','multi-calendar');

    }else{
    	DEFINE('DBHOST','localhost');
		DEFINE('DBUSER','paulwolbers');
		DEFINE('DBPASS','peewee25');
    	DEFINE('DBNAAM','ews');

    }

    $obj_db = mysqli_connect(DBHOST, DBUSER, DBPASS, DBNAAM);
    if($obj_db === FALSE) {
        $error= "Database connection failed";
        printf("Connect failed: %s\n", mysqli_connect_error());
        exit();
    }
	mysqli_set_charset( $obj_db , 'utf8' );
}
?>
