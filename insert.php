<?php
include_once("connection.php");
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name = htmlspecialchars(trim($_POST['name']));
    $email = htmlspecialchars(trim($_POST['email']));

    if (!empty($name) && !empty($email)) {

        $sql = "INSERT INTO tbl_users (name, email) VALUES ('$name', '$email')";
        if ($conn->query($sql) === TRUE) {
            echo "New record createdd successfully";
        }else{
            echo "Error: " .$sql . "<br>" . $conn->error;
        }
        $conn->close();
    }else{
        echo "<p>Please fill in all fields,</p>";

    }
}


?>
<html>
    <body>
        <h2>PHP Form Insert</h2>
        <a href="index.php">Home</a>
        <br/><br/>
        <form action="" method="POST">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required><br><br>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required><br><br>

            <input type="submit" value="Submit">
    </form>
</body>
</html>
