<?php
// Include database connection
include('db.php');

// Start session
session_start();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $email = $_POST['email'];
    $password = $_POST['password'];

    // SQL query to find user by email
    $sql = "SELECT * FROM Users WHERE email = '$email'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();
        // Verify password
        if (password_verify($password, $user['password_hash'])) {
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['role'] = $user['role'];
            header('Location: jobs.php');
        } else {
            echo "Invalid credentials!";
        }
    } else {
        echo "User not found!";
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login - Job Application System</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <header>
    <h1>Login</h1>
    <nav>
      <a href="index.php">Home</a>
      <a href="registered.php">Register</a>
    </nav>
  </header>

  <section class="form-container">
    <form action="log_in.php" method="POST">
      <label for="email">Email:</label>
      <input type="email" id="email" name="email" required>

      <label for="password">Password:</label>
      <input type="password" id="password" name="password" required>

      <button type="submit" class="btn">Login</button>
    </form>
  </section>

  <footer>
    <p>&copy; 2025 Online Job Application System</p>
  </footer>
</body>
</html>
