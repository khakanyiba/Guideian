<?php
session_start();

if (!isset($_SESSION['email'])) {
    header("Location: sign-in.html");
    exit();
}

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

$email = $_SESSION['email'];

// Fetch user data from the Users table
$query = "SELECT * FROM Users WHERE Email = '$email'";
$result = pg_query($conn, $query);

if ($result) {
    $user = pg_fetch_assoc($result);
} else {
    echo "Error: " . pg_last_error($conn);
}

// Close the database connection
pg_close($conn);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Profile - Guideian</title>
</head>
<body>
    <header>
        <div class="header-container">
            <div class="header-img-container">
                <a href="index.html" id="logo-img"><img src="./assets/logo.png" alt="logo"></a> 
            </div> 
            <nav>
                <ul class="nav-ul">
                    <li><a href="index.html">Home</a></li>
                    <li><a href="apply.html">Apply</a></li>
                    <li><a href="courses.html">Courses</a></li>
                    <li><a href="contact.html">Contact Us</a></li>
                    <li><a href="about.html">About Us</a></li>
                </ul>
                <div class="auth-buttons">
                    <button class="btn sign-out-btn" onclick="location.href='sign-out.php'">Sign Out</button>
                </div>
            </nav>
        </div>
    </header>

    <main>
        <section id="profile-section">
            <h2 class="center-text">Profile</h2>
            <div class="profile-container">
                <p><strong>First Name:</strong> <?php echo $user['FirstName']; ?></p>
                <p><strong>Surname:</strong> <?php echo $user['Surname']; ?></p>
                <p><strong>Date of Birth:</strong> <?php echo $user['DateOfBirth']; ?></p>
                <p><strong>Age:</strong> <?php echo $user['Age']; ?></p>
                <p><strong>Gender:</strong> <?php echo $user['Gender']; ?></p>
                <p><strong>Email:</strong> <?php echo $user['Email']; ?></p>
                <p><strong>Phone Number:</strong> <?php echo $user['PhoneNumber']; ?></p>
                <p><strong>Subscription:</strong> <?php echo $user['Subscription']; ?></p>
            </div>
        </section>
    </main>

    <footer>
        <div class="footer-container">
            <div class="info general-info"> 
                <p><img src="./assets/email icon.png" alt="email icon"> hello@Guideian.com</p>
                <p><img src="./assets/phone icon.png" alt="phone icon"> 0123456789</p>
                <p><img src="./assets/location icon.png" alt="location icon"> Somewhere in the world</p>
            </div>
        </div>
        <p class="footer-p">&copy; 2024 Guideian. All rights reserved</p>
    </footer>
</body>
</html>