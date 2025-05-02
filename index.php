<?php
    include_once("connection.php");

    $sql = "SELECT id, name, email FROM tbl_users";
    $result = $conn->query($sql);

?>
<html>
<body>
    <h2>PHP Form Index</h2>
    <a href="index.php">Home</a> || <a href="insert.php">Add</a>
    <br/><br/>
    <?php
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            echo "ID: " . $row["id"] .
            " . Name: " . $row["name"] .
            " . Email: " . $row["email"] .
            " . <a href='update.php?id=" . $row["id"] . "'>Edit</a>" .
            " . <a href='delete.php?id=" . $row["id"] . "' " .
            " onClick=\"return confirm('Are you sure you want to delete?');\"" .
            ">Delete</a>" .
            "<br>";
        }
    }else{
        echo "0 result";
    }
    $conn->close();
?>
</body>
</html>
