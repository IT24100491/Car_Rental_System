<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicle Rental System</title>
    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome CDN -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <!-- AOS (Animate On Scroll) CDN for scroll animations -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="css/style.css" rel="stylesheet">
    <style>
        .hero-section {
            height: 60vh;
            background: linear-gradient(rgba(0,0,0,0.6),rgba(0,0,0,0.5)), url('https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&w=1350&q=80') center/cover no-repeat;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .vehicle-card {
            transition: transform 0.4s, box-shadow 0.4s;
            cursor: pointer;
        }
        .vehicle-card:hover {
            transform: translateY(-10px) scale(1.03);
            box-shadow: 0 10px 20px rgba(0,0,0,0.15);
        }
        .price {
            color: #0d6efd;
            font-weight: 500;
            font-size: 1.1rem;
        }
    </style>
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top shadow">
    <div class="container">
        <a class="navbar-brand" href="#"><i class="fas fa-car-side"></i> VehicleRent</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="mainNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link active" href="#"><i class="fas fa-home"></i> Home</a></li>
                <li class="nav-item"><a class="nav-link" href="#vehicles"><i class="fas fa-car"></i> Vehicles</a></li>
                <li class="nav-item"><a class="nav-link" href="login.html"><i class="fas fa-sign-in-alt"></i> Login</a></li>
                <li class="nav-item"><a class="nav-link" href="signup.html"><i class="fas fa-user-plus"></i> Register</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<header class="hero-section d-flex align-items-center justify-content-center text-center text-white">
    <div>
        <h1 class="display-4 mb-3" data-aos="fade-up">Welcome to VehicleRent</h1>
        <p class="lead mb-4" data-aos="fade-up" data-aos-delay="200">
            Your trusted partner for fast and easy vehicle rentals.
        </p>
        <a href="#vehicles" class="btn btn-primary btn-lg" data-aos="zoom-in" data-aos-delay="400">
            <i class="fas fa-car"></i> Explore Vehicles
        </a>
    </div>
</header>

<!-- Vehicles Section -->
<section id="vehicles" class="py-5">
    <div class="container">
        <h2 class="text-center mb-5" data-aos="fade-up">Featured Vehicles</h2>
        <div class="row">
            <!-- Card 1 -->
            <div class="col-md-4 mb-4" data-aos="flip-left">
                <div class="card vehicle-card h-100">
                    <img src="https://images.unsplash.com/photo-1614328467603-0444b9fcfc47?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" class="card-img-top" alt="Sedan">
                    <div class="card-body">
                        <h5 class="card-title">Audi A4</h5>
                        <p class="card-text">Premium comfort for your trip.</p>
                        <p class="price">From $79/day</p>
                        <a href="login.html" class="btn btn-outline-primary">Rent Now</a>
                    </div>
                </div>
            </div>
            <!-- Card 2 -->
            <div class="col-md-4 mb-4" data-aos="flip-left" data-aos-delay="200">
                <div class="card vehicle-card h-100">
                    <img src="https://images.unsplash.com/photo-1650369446487-88da5c2ca105?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" class="card-img-top" alt="SUV">
                    <div class="card-body">
                        <h5 class="card-title">BMW 520D</h5>
                        <p class="card-text">Perfect for family getaways.</p>
                        <p class="price">From $99/day</p>
                        <a href="login.html" class="btn btn-outline-primary">Rent Now</a>
                    </div>
                </div>
            </div>
            <!-- Card 3 -->
            <div class="col-md-4 mb-4" data-aos="flip-left" data-aos-delay="400">
                <div class="card vehicle-card h-100">
                    <img src="https://images.unsplash.com/photo-1706117948438-826d8018505a?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" class="card-img-top" alt="Sports Car">
                    <div class="card-body">
                        <h5 class="card-title">Toyota Premio</h5>
                        <p class="card-text">reliable.</p>
                        <p class="price">From $80/day</p>
                        <a href="login.jsp" class="btn btn-outline-primary">Rent Now</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="bg-dark text-white py-4">
    <div class="container">
        <div class="row">
            <div class="col-md-4 mb-3">
                <h5><i class="fas fa-car-side"></i> VehicleRent</h5>
                <p>Your trusted partner in vehicle rentals.</p>
            </div>
            <div class="col-md-4 mb-3">
                <h5>Quick Links</h5>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-white">Home</a></li>
                    <li><a href="#vehicles" class="text-white">Vehicles</a></li>
                    <li><a href="login.html" class="text-white">Login</a></li>
                    <li><a href="signup.html" class="text-white">Register</a></li>
                </ul>
            </div>
            <div class="col-md-4 mb-3">
                <h5>Contact Us</h5>
                <p><i class="fas fa-phone"></i> +1 234 567 890</p>
                <p><i class="fas fa-envelope"></i> info@vehiclerent.com</p>
            </div>
        </div>
    </div>
</footer>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    if (window.AOS) AOS.init({ duration: 1000, once: true });
    // Extra: smooth scroll for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(link => {
        link.addEventListener('click', function(e) {
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                e.preventDefault();
                target.scrollIntoView({behavior: 'smooth'});
            }
        });
    });
    // Card hover effect
    document.querySelectorAll('.vehicle-card').forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.boxShadow = '0 16px 32px rgba(13,110,253,0.3)';
        });
        card.addEventListener('mouseleave', function() {
            this.style.boxShadow = '';
        });
    });
</script>
</body>
</html>