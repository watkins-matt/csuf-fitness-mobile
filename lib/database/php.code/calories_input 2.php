<?php

$servername = "localhost";
$username = "root "; 
$password = "";
$dbname = "TestDb";
$table = "CalorieIntake"; //this will be created now

$action = $_POST["action"]; //this will get actions from the app to update database

//creating the connection 

$conn = new mysqli($servername, $username, $password, $dbname);


if($conn->connection_error) //if connection failed 
{
    die("Connection Failed: " . $conn->connection_error);
    return;
}

//if connection is okay 
if ("CREATE_TABLE" == $action)
{
    $sql = "CREATE TABLE IF NOT EXISTS $table 
    (id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL )";

    if ($conn->query($sql)==TRUE)
    {
        //send back success message
        echo "success"; 
    }   
    else
    {
        echo "error";
    }
    $conn->close();
    return;
}

//getting records from the database
if ("GET_ALL"==$action)
{
    $db_data = array();
    $sql = "SELECT id, first_name, last_name from $table ORDER BY id DESC ";
    $result = $conn->query ($sql);
    if ($result->num_rows > 0)
    {
        while ($row = $result->fetch_assoc())
        {
            $db_data[]= $row;

        }

        echo json_encode ($db_data);
        //sending back record as a json   
    }
    else 
    {
        echo "error";
    }
    $conn->close();
    return;


}

if ("ADD_EMP "== $action)
{
    $first_name = $_POST["first_name"];
    $last_name = $_POST["last_name"];
    $sql = "INSERT INTO $table (first_name, last_name) VALUES ('$first_name','$last_name',)";
    $result = $conn->query($sql);
    echo "success";
}

//app will be posting these values to the server 
if ("UPDATE_EMP" == $action )
{
   $emp_id = $_POST['$emp_id'];
   $first_name = $_POST ['first_name'];
   $last_name = $_POST ['last_name '];
   $sql = "UPDATE $table SET first_name = '$first_name', last_name = '$last_name' WHERE id = '$emp_id'";

   if ($conn->query($sql)== TRUE)
   {
       echo "success ";
   }
   else {
       echo "error";
   }
   $conn->close();
   return;

}

if ('DELETE_EMP '==$action)
{
    $emp_id = $_POST ['emp_id'];
    $sql = "DELETE FROM $table WHERE id = emp_id";
}
?>