<?php
$con = mysqli_connect("localhost","root","","salle_de_sport");
if(!$con){
    echo("<script>alert('access denied')</script>");
}
?>