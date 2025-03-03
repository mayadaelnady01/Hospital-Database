<?php 
$connection= mysqli_connect("localhost","root","straykids","hospital");
$hostname = 'localhost';
$username = 'root';
$password = 'straykids';
$database = 'hospital';

// Create a connection
$mysqli = new mysqli($hostname, $username, $password, $database);

// Check the connection
if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error);
}
//
// SQL query
$sql = "select p.patient_name,d.doctor_name from patient p  right join doctor d on p.doctor_id=d.doctor_id;";
// Execute the query
$result = $mysqli->query($sql);
// Check if the query was successful

echo'             All the names of the doctors and their patients if they have:<br>';
if ($result) {
    // Fetch the results and display them
    while ($row = $result->fetch_assoc()) {
        echo "Patient Name: " . $row['patient_name'] . "<br>";
        echo "Doctor Name: " . $row['doctor_name'] . "<br>";
        echo "------------------------<br>";
    }
    // Free the result set
    $result->free();
} else {
    // Display an error message if the query fails
    echo "Error: " . $mysqli->error;
}
// Close the connection
echo'--------------------------------------------------------------------------<br>';
//------------------------------------------------------------------------------

$sqll = "SELECT p.patient_name, mr.disease FROM patient p JOIN medical_record mr ON p.record_id = mr.record_id";
// Execute the query
$resultt = $mysqli->query($sqll);
echo'       The patients and their diseases:<br>';
// Check if the query was successful
if ($resultt) {
    // Fetch the results and display them
    while ($row = $resultt->fetch_assoc()) {
        echo "Patient Name: " . $row['patient_name'] . "<br>";
        echo "Disease: " . $row['disease'] . "<br>";
        echo "------------------------<br>";
    }
    // Free the result set
    $resultt->free();
} else {
    // Display an error message if the query fails
    echo "Error: " . $mysqli->error;
}
// Close the connection
$mysqli->close();
 //$query = "select*from patient";
 //stmt=mysqli_query($connection,$query);
  //while($row=mysqli_fetch_array($stmt,MYSQLI_ASSOC)){
    //echo $row['patient_name'].'</br>';}
?>


 





