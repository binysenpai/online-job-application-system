<?php
include_once("connection.php");

$id = $_GET['id'];
$sql = "DELETE FROM tbl_users WHERE id = $id";
if ($conn->query($sql) === TRUE) {

    header("Location:index.php");
}else{
    echo "Error deleting record: " . $conn->error;

}
$conn->close();

?>