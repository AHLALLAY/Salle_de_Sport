<?php
require_once 'db.php';

function display_data()
{
    global $con;
    $query = "select * from membre";
    $result = mysqli_query($con, $query);
    return $result;
}


function get_activities()
{
    global $con;
    $sql = "SELECT * FROM activite";
    return mysqli_query($con, $sql);
}
