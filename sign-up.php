<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
session_start();

// Database connection details
$host = 'localhost';
$db = 'your_database';
$user = 'your_username';
$pass = 'your_password';
$port = '5432';

// Create a connection to the PostgreSQL database
$conn = pg_connect("host=$host dbname=$db user=$user password=$pass port=$port");

if (!$conn) {
    die("Connection failed: " . pg_last_error());
}

// Get form data
$firstName = $_POST['firstName'];
$surname = $_POST['surname'];
$dateOfBirth = $_POST['dateOfBirth'];
$age = $_POST['age'];
$gender = $_POST['gender'];
$email = $_POST['email'];
$password = password_hash($_POST['password'], PASSWORD_BCRYPT); // Hash the password
$phoneNumber = $_POST['phoneNumber'];
$subscription = $_POST['subscription'];

// Insert user data into the Users table
$query = "INSERT INTO Users (FirstName, Surname, DateOfBirth, Age, Gender, Email, Password, PhoneNumber, Subscription) VALUES ('$firstName', '$surname', '$dateOfBirth', $age, '$gender', '$email', '$password', '$phoneNumber', '$subscription')";

$result = pg_query($conn, $query);

if ($result) {
    // Set session variables
    $_SESSION['email'] = $email;
    $_SESSION['firstName'] = $firstName;

    // Redirect to the home page
    header("Location: index.html");
    exit();
} else {
    echo "Error: " . pg_last_error($conn);
}

// Close the database connection
pg_close($conn);
?>