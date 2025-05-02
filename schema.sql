CREATE DATABASE db_arellano_project;

USE db_arellano_project;

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

<?php
$servername = "localhost";
$username = "root";
$password = ""; // your MySQL password if applicable
$database = "db_lastname_project";

$conn = new mysqli($servername, $username, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

session_start();
?>

<?php
include_once("connection.php");

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = htmlspecialchars(trim($_POST['email']));
    $password = htmlspecialchars(trim($_POST['password']));

    if (!empty($email) && !empty($password)) {
        $result = $conn->query("SELECT user_id, name, password FROM Users WHERE email = '$email'");

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            if (password_verify($password, $row['password'])) {
                $_SESSION["user_id"] = $row['user_id'];
                header("Location: dashboard.php");
                exit();
            } else {
                $error = "Invalid password.";
            }
        } else {
            $error = "No user found with that email.";
        }
    } else {
        echo "<p>Please fill in all fields.</p>";
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>
    <h2>Login</h2>
    <?php if (isset($error)) echo "<p style='color:red;'>$error</p>"; ?>
    <form method="POST">
        <label>Email:</label>
        <input type="email" name="email" required><br><br>
        <label>Password:</label>
        <input type="password" name="password" required><br><br>
        <button type="submit">Login</button>
    </form>
    <br>
    <a href="register.php">Register</a>
</body>
</html>

<?php
include_once("connection.php");

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name = htmlspecialchars(trim($_POST['name']));
    $email = htmlspecialchars(trim($_POST['email']));
    $password = password_hash(trim($_POST['password']), PASSWORD_DEFAULT);
    $phone = htmlspecialchars(trim($_POST['phone']));

    if (!empty($name) && !empty($email) && !empty($_POST['password'])) {
        $stmt = $conn->prepare("INSERT INTO Users (name, email, password, phone) VALUES (?, ?, ?, ?)");
        $stmt->bind_param("ssss", $name, $email, $password, $phone);
        
        if ($stmt->execute()) {
            echo "<script>alert('Registration successful! Please login.'); window.location.href='login.php';</script>";
        } else {
            echo "<p style='color:red;'>Error: " . $conn->error . "</p>";
        }
    } else {
        echo "<p style='color:red;'>Please fill in all required fields.</p>";
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
</head>
<body>
    <h2>User Registration</h2>
    <form method="POST">
        <label>Name:</label>
        <input type="text" name="name" required><br><br>
        <label>Email:</label>
        <input type="email" name="email" required><br><br>
        <label>Password:</label>
        <input type="password" name="password" required><br><br>
        <label>Phone:</label>
        <input type="text" name="phone"><br><br>
        <button type="submit">Register</button>
    </form>
    <br>
    <a href="login.php">Back to Login</a>
</body>
</html>

<?php
include_once("connection.php");

if (!isset($_SESSION["user_id"])) {
    header("Location: login.php");
    exit();
}

$user_id = $_SESSION["user_id"];
$result = $conn->query("SELECT name FROM Users WHERE user_id = $user_id");
$user = $result->fetch_assoc();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
</head>
<body style="text-align:center;">
    <h2>Welcome, <?php echo $user['name']; ?>!</h2>
    <nav>
        <a href="library.php">Library</a> |
        <a href="changepassword.php">Change Password</a> |
        <a href="logout.php">Logout</a>
    </nav>
    <div style="background-color:#e0e0e0; padding:10px;">
        <h1>Online Bookstore Management System</h1>
        <h3>Welcome Panel</h3>
        <p>This is a standard dashboard for our website project. You can manage your projects, view the library, and change your password.</p>
    </div>
</body>
</html>


<?php
include_once("connection.php");

if (!isset($_SESSION["user_id"])) {
    header("Location: login.php");
    exit();
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $new_pass = password_hash(trim($_POST['new_password']), PASSWORD_DEFAULT);
    $user_id = $_SESSION["user_id"];

    $stmt = $conn->prepare("UPDATE Users SET password = ? WHERE user_id = ?");
    $stmt->bind_param("si", $new_pass, $user_id);

    if ($stmt->execute()) {
        echo "<script>alert('Password changed successfully.');</script>";
    } else {
        echo "<p style='color:red;'>Failed to update password.</p>";
    }
}
?>

<!DOCTYPE html>
<html>
<head><title>Change Password</title></head>
<body>
    <h2>Change Password</h2>
    <form method="POST">
        <label>New Password:</label>
        <input type="password" name="new_password" required><br><br>
        <button type="submit">Update Password</button>
    </form>
    <br>
    <a href="dashboard.php">Back to Dashboard</a>
</body>
</html>

<?php
include_once("connection.php");

if (!isset($_SESSION["user_id"])) {
    header("Location: login.php");
    exit();
}
?>

<!DOCTYPE html>
<html>
<head><title>Library</title></head>
<body>
    <h2>Library</h2>
    <p>This is a placeholder for your library content. You can fill it with books, articles, or other resources.</p>
    <a href="dashboard.php">Back to Dashboard</a>
</body>
</html>


<?php
include_once("connection.php");

if (!isset($_SESSION["user_id"])) {
    header("Location: login.php");
    exit();
}
?>

<!DOCTYPE html>
<html>
<head><title>Library</title></head>
<body>
    <h2>Library</h2>
    <p>This is a placeholder for your library content. You can fill it with books, articles, or other resources.</p>
    <a href="dashboard.php">Back to Dashboard</a>
</body>
</html>

<?php
session_start();
session_unset();
session_destroy();
header("Location: login.php");
exit();
?>

ALTER TABLE Users ADD role ENUM('user', 'admin') DEFAULT 'user';

<?php
function isAdmin() {
    return isset($_SESSION['user_id']) && $_SESSION['role'] === 'admin';
}

function getUserById($conn, $user_id) {
    $stmt = $conn->prepare("SELECT * FROM Users WHERE user_id = ?");
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    return $stmt->get_result()->fetch_assoc();
}
?>

$result = $conn->query("SELECT user_id, name, password FROM Users WHERE email = '$email'");

$result = $conn->query("SELECT user_id, name, password, role FROM Users WHERE email = '$email'");

$_SESSION["role"] = $row['role'];


<?php
include_once("connection.php");
include_once("functions.php");

if (!isAdmin()) {
    header("Location: dashboard.php");
    exit();
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $user_id = $_POST['user_id'];
    $new_role = $_POST['role'];

    $stmt = $conn->prepare("UPDATE Users SET role = ? WHERE user_id = ?");
    $stmt->bind_param("si", $new_role, $user_id);
    $stmt->execute();
}

$users = $conn->query("SELECT user_id, name, email, role FROM Users");
?>

<!DOCTYPE html>
<html>
<head><title>Manage Users</title></head>
<body>
    <h2>User Role Management</h2>
    <table border="1" cellpadding="8">
        <tr><th>Name</th><th>Email</th><th>Role</th><th>Change Role</th></tr>
        <?php while ($user = $users->fetch_assoc()): ?>
            <tr>
                <form method="POST">
                    <td><?= htmlspecialchars($user['name']) ?></td>
                    <td><?= htmlspecialchars($user['email']) ?></td>
                    <td><?= htmlspecialchars($user['role']) ?></td>
                    <td>
                        <input type="hidden" name="user_id" value="<?= $user['user_id'] ?>">
                        <select name="role">
                            <option value="user" <?= $user['role'] == 'user' ? 'selected' : '' ?>>User</option>
                            <option value="admin" <?= $user['role'] == 'admin' ? 'selected' : '' ?>>Admin</option>
                        </select>
                        <button type="submit">Update</button>
                    </td>
                </form>
            </tr>
        <?php endwhile; ?>
    </table>
    <br>
    <a href="dashboard.php">Back to Dashboard</a>
</body>
</html>

<?php if (isAdmin()): ?>
    | <a href="manage_users.php">Manage Users</a>
<?php endif; ?>

ALTER TABLE Users ADD profile_picture VARCHAR(255) DEFAULT 'default.png';

<?php
include_once("connection.php");

if (!isset($_SESSION["user_id"])) {
    header("Location: login.php");
    exit();
}

$user_id = $_SESSION["user_id"];

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $target_dir = "uploads/";
    $file = $_FILES["profile_picture"];
    $filename = basename($file["name"]);
    $target_file = $target_dir . $filename;

    if (move_uploaded_file($file["tmp_name"], $target_file)) {
        $stmt = $conn->prepare("UPDATE Users SET profile_picture = ? WHERE user_id = ?");
        $stmt->bind_param("si", $filename, $user_id);
        $stmt->execute();
        echo "<p>Profile picture updated!</p>";
    } else {
        echo "<p>Upload failed.</p>";
    }
}
?>

<form method="POST" enctype="multipart/form-data">
    <label>Upload Profile Picture:</label><br>
    <input type="file" name="profile_picture"><br><br>
    <button type="submit">Upload</button>
</form>

$result = $conn->query("SELECT name, profile_picture FROM Users WHERE user_id = $user_id");
$user = $result->fetch_assoc();
echo "<img src='uploads/" . $user['profile_picture'] . "' width='100' height='100'><br>";

function logAction($conn, $user_id, $action) {
    $stmt = $conn->prepare("INSERT INTO AccessLogs (user_id, action) VALUES (?, ?)");
    $stmt->bind_param("is", $user_id, $action);
    $stmt->execute();
}

logAction($conn, $_SESSION['user_id'], "Logged in");
logAction($conn, $_SESSION['user_id'], "Changed role of user ID $user_id to $new_role");

<?php
include_once("connection.php");
include_once("functions.php");

if (!isAdmin()) {
    header("Location: dashboard.php");
    exit();
}

$logs = $conn->query("
    SELECT l.log_time, u.name, l.action 
    FROM AccessLogs l 
    JOIN Users u ON l.user_id = u.user_id 
    ORDER BY l.log_time DESC
");
?>

<h2>Access Logs</h2>
<table border="1">
    <tr><th>Time</th><th>User</th><th>Action</th></tr>
    <?php while ($log = $logs->fetch_assoc()): ?>
        <tr>
            <td><?= $log['log_time'] ?></td>
            <td><?= htmlspecialchars($log['name']) ?></td>
            <td><?= htmlspecialchars($log['action']) ?></td>
        </tr>
    <?php endwhile; ?>
</table>