<?php

    if ( !isset($_GET["roll"])) {

        $roll = $_GET["id"];

        include('databaseConnect.php');
        
        $sql = "DELETE FROM students WHERE roll=$roll";
        $connection->query($sql);
    }

    header("location: /Student_Registration_Form/index.php");
    exit;
?>