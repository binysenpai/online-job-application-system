<?php
// Include database connection
include('db.php');

// Register user
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $name = $_POST['name'];
    $email = $_POST['email'];
    $password = password_hash($_POST['password'], PASSWORD_DEFAULT); // Secure password
    $phone = $_POST['phone'];
    $role = $_POST['role'];

    // SQL query to insert new user
    $sql = "INSERT INTO Users (name, email, password_hash, phone, role) 
            VALUES ('$name', '$email', '$password', '$phone', '$role')";
    
    if ($conn->query($sql) === TRUE) {
        echo "New record created successfully";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Register - Job Application System</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <header>
    <h1>Register</h1>
    <nav>
      <a href="index.php">Home</a>
      <a href="log_in.php">Login</a>
    </nav>
  </header>

  <section class="form-container">
    <form action="registered.php" method="POST">
      <label for="name">Full Name:</label>
      <input type="text" id="name" name="name" required>

      <label for="email">Email:</label>
      <input type="email" id="email" name="email" required>

      <label for="password">Password:</label>
      <input type="password" id="password" name="password" required>

      <label for="phone">Phone Number:</label>
      <input type="text" id="phone" name="phone" required>

      <label for="role">I am a:</label>
      <select id="role" name="role" required>
        <option value="job_seeker">Job Seeker</option>
        <option value="employer">Employer</option>
      </select>

      <button type="submit" class="btn">Register</button>
    </form>
  </section>

  <footer>
    <p>&copy; 2025 Online Job Application System</p>
  </footer>
</body>
</html>
