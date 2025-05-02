<?php
    include_once("connection.php");
    $id = $_GET["id"];
    $sql = "SELECT name, email FROM tbl_users WHERE id = $id";

    $result = $conn->query($sql);
    $row = $result->fetch_assoc();
    if ($row) {
        $name = $row["name"];
        $email = $row["email"];
    }else{
        echo "No record found for this ID.";

    }

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $name = htmlspecialchars(trim($_POST['name']));
        $email = htmlspecialchars(trim($_POST['email']));

        if(!empty($name) && !empty($email)) {
            $sql = "UPDATE tbl_users SET name ='$name', email = '$email' WHERE id = $id";
            if ($conn->query($sql) === TRUE) {
                echo "Record updated successfully!";
            }else{

            }
            $conn->close();
        }else{
            echo "<p>Please fill in all fields.</p>";
        }

    }


?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PHP Form Update</title>
</head>
<body>
    <h2>PHP Form Update<h2>
        <a href="index.php">Home</a>
        <br/><br/>

        <form action="" method="POST">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" value="<?php echo $name;?>" required><br><br>
            <label for="name">Email:</label>
            <input type="email" id="email" name="email" value="<?php echo $email;?>" required><br><br>
            <input type="submit" value="Submit">
        </form>
    </body>
</html>