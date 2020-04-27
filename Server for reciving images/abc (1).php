<?php
  $image = $_POST['image'];
  $name = $_POST['name'];
  $realImage = base64_decode($image);
  
  file_put_contents('Mcchs_image/'.$name,$realImage);
  echo "OK";
?>