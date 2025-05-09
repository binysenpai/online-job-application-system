<?php
// connection.php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "db_arellano_b6";  // Make sure this matches your database name

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Fetch jobs
$sql = "SELECT * FROM Jobs";
$result = $conn->query($sql);

// Check if any jobs exist
if ($result->num_rows > 0) {
    // Output jobs
    while($row = $result->fetch_assoc()) {
        echo "<div class='job-listing'>";
        echo "<h2>" . $row['title'] . "</h2>";
        echo "<p><strong>Company:</strong> " . $row['company'] . "</p>";
        echo "<p><strong>Location:</strong> " . $row['location'] . "</p>";
        echo "<p><strong>Description:</strong> " . $row['description'] . "</p>";
        echo "<a href='apply.php?job_id=" . $row['id'] . "' class='apply-btn'>Apply Now</a>";
        echo "</div>";
    }
} else {
    echo "No job listings available.";
}

$conn->close();
?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Listings</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>

<header>
    <h1>Job Listings</h1>
</header>

<main>
    <?php include 'apply.php'; ?>
</main>

<footer>
    <p>&copy; 2025 Online Job Application System</p>
</footer>

</body>
</html>
