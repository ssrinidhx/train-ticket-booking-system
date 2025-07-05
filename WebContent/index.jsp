<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>RailEase Train Ticket Booking</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    body {
      font-family: Calibri, sans-serif;
      scroll-behavior: smooth;
    }

    .hero {
      position: relative;
      height: 100vh;
      color: white;
      display: flex;
      align-items: center;
      justify-content: center;
      text-align: center;
      overflow: hidden;
    }

    .hero::before {
      content: "";
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: url('images/train.avif') no-repeat center center fixed;
      background-size: cover;
      filter: blur(4px);
      z-index: 1;
    }

    .hero-overlay {
      background-color: rgba(0, 0, 0, 0.6);
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      z-index: 1;
    }

    .hero-content {
      z-index: 2;
      position: relative;
    }

    .section {
      padding: 60px 20px;
    }

    .section:nth-child(even) {
      background-color: #f8f9fa;
    }

    .section h2 {
      margin-bottom: 22px;
    }

    footer {
      background-color: #212529;
      color: white;
      padding: 40px 20px;
    }

    footer a {
      color: #ffc107;
      text-decoration: none;
    }

    footer a:hover {
      text-decoration: underline;
    }

    .nav-link {
      color: white !important;
    }

    .nav-link:hover {
      color: #ffc107 !important;
    }
  </style>
</head>
<body>
  <!-- Navbar -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top shadow-sm">
    <div class="container-fluid d-flex justify-content-between align-items-center">
      <div class="d-flex align-items-center">
        <span class="navbar-brand mb-0 h5">RailEase</span>
      </div>
      <div>
        <ul class="navbar-nav flex-row" style="font-family: Calibri, sans-serif; line-height: 1.8;">
          <li class="nav-item me-3"><a class="nav-link" href="#about">About</a></li>
          <li class="nav-item me-3"><a class="nav-link" href="admin-login.jsp">Admin</a></li>
        </ul>
      </div>
    </div>
  </nav>

  <!-- Hero Section -->
  <section class="hero" id="home">
    <div class="hero-overlay"></div>
    <div class="hero-content">
      <h1 class="display-4 fw-bold">Welcome to RailEase Train Ticket Booking!</h1>
      <p class="lead">Your Journey Begins Here!</p>
      <a href="user-login.jsp" class="btn btn-warning btn-lg mt-3">Book Now</a>
    </div>
  </section>

  <!-- About Section -->
  <section class="section text-center" id="about">
    <div class="container">
      <h2><b>About Us</b></h2>
      <p>
        Our Train Ticket Booking System is designed to make your travel planning fast, easy, and reliable. 
        Whether you're booking in advance or planning a last-minute trip, our system ensures a smooth experience with real-time seat availability and confirmation.
      </p>
    </div>
  </section>

  <!-- Why Choose Us Section -->
<section class="section text-center bg-white" id="features">
  <div class="container">
    <h2><b>Why Choose Us?</b></h2>
    <ul class="text-start" style="max-width: 960px; margin: 0 auto; padding-left: 1rem;">
      <li class="mb-3"><strong>Easy Booking:</strong> Simple and quick steps to reserve your seat.</li>
      <li class="mb-3"><strong>Real-Time Updates:</strong> Instant train availability and confirmation.</li>
      <li class="mb-3"><strong>Admin Control:</strong> Add trains, manage bookings, and monitor seats in real-time.</li>
    </ul>
  </div>
</section>


  <!-- Footer -->
  <footer class="text-center">
    <div class="container" style="font-family: Calibri, sans-serif; line-height: 1.8;">
      <p class="mb-2">&copy; 2025 RailEase Train Ticket Booking. All rights reserved.</p>
      <div>
        <a href="#">Terms of Service</a> | 
        <a href="#">Privacy Policy</a> | 
        <a href="#">Support</a>
      </div>
    </div>
  </footer>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
