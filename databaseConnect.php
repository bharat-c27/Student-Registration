<?php

    $servername = "localhost";
    $username = "root";
    $password = "<your-password>";
    $database = "<your-database-name>";

    $connection = new mysqli($servername, $username, $password, $database);

    if($connection->connect_error) {
        die("Connection failed : " . $connection->connect_error);
    }

?>