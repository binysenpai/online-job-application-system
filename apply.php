<?php
// Include database connection
include('db.php');

// Get job ID from URL
$job_id = $_GET['job_id'];

// Check if user is logged in
session_start();
if (!isset($_SESSION['user_id'])) {
    header('Location: log_in.php');
}

// Submit application
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $cover_letter = $_POST['cover_letter'];
    $user_id = $_SESSION['user_id'];

    // Insert application into database
    $sql = "INSERT INTO Applications (job_id, user_id, cover_letter) 
            VALUES ('$job_id', '$user_id', '$cover_letter')";
    
    if ($conn->query($sql) === TRUE) {
        echo "Application submitted successfully!";
    } else {
        echo "Error: " . $conn->error;
    }
}

// Get job details
$sql = "SELECT * FROM Jobs WHERE id = '$job_id'";
$result = $conn->query($sql);
$job = $result->fetch_assoc();
?>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Apply - Job Application System</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <header>
    <h1>Apply for <?php echo $job['title']; ?></h1>
    <nav>
      <a href="index.php">Home</a>
      <a href="log_in.php">Login</a>
      <a href="registered.php">Register</a>
    </nav>
  </header>

  <section class="form-container">
    <form action="apply.php?job_id=<?php echo $job['id']; ?>" method="POST">
      <label for="cover_letter">Cover Letter:</label>
      <textarea id="cover_letter" name="cover_letter" required></textarea>

      <button type="submit" class="btn">Submit Application</button>
    </form>
  </section>

  <footer>
    <p>&copy; 2025 Online Job Application System</p>
  </footer>
</body>
</html>
