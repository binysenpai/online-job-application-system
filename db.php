<?php
$host = "localhost";  // Your database host
$username = "root";   // Your database username
$password = "";       // Your database password
$dbname = "db_arellano_b6"; // Your database name

// Create a connection
$conn = new mysqli($host, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
