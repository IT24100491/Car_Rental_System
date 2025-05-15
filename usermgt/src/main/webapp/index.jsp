<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Car Rental Dashboard</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f4f4;
            color: #333;
        }

        header {
            background-color: #2c3e50;
            color: white;
            padding: 20px;
            text-align: center;
        }

        nav {
            background-color: #34495e;
            padding: 15px;
            display: flex;
            justify-content: flex-end;
            gap: 15px;
        }

        nav a {
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            background-color: #2980b9;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        nav a:hover {
            background-color: #1abc9c;
        }

        .content {
            padding: 30px;
            text-align: center;
        }

        .content h2 {
            font-size: 2rem;
            margin-bottom: 10px;
        }

        .content p {
            font-size: 1.1rem;
            max-width: 600px;
            margin: 0 auto;
        }
    </style>
</head>
<body>
<header>
    <h1>Welcome to Car Rental Dashboard</h1>
</header>

<nav>
    <a href="login.html">Login</a>
    <a href="signup.html">Sign Up</a>
</nav>

<div class="content">
    <h2>Rent Your Dream Car</h2>
    <p>
        Explore a wide variety of vehicles available for rent at affordable prices.
        Login to manage your bookings or sign up to start your journey with us.
    </p>
</div>
</body>
</html>
