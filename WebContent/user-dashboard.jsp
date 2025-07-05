<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>User Dashboard - RailTrack</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    html, body {
      height: 100%;
      font-family: Calibri, sans-serif;
      overflow-x: hidden;
    }

    body {
      background: url('images/train.avif') no-repeat center center fixed;
      background-size: cover;
    }

    .blur-overlay {
      position: fixed;
      top: 0; left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.6);
      backdrop-filter: blur(6px);
      z-index: -1;
    }

    .sidebar {
      min-height: 100vh;
      background-color: rgba(33, 37, 41, 0.95);
      padding-top: 20px;
      position: sticky;
      top: 0;
    }

    .sidebar .nav-link {
      color: white;
      margin-bottom: 10px;
    }

    .sidebar .nav-link:hover,
    .sidebar .nav-link.active {
      background-color: #495057;
      color: #ffc107 !important;
      border-radius: 6px;
    }

    .content-area {
      padding: 30px;
    }

    .content-container {
      background-color: rgba(255, 255, 255, 0.95);
      padding: 25px;
      border-radius: 10px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
      display: none;
    }

    .content-container.active {
      display: block;
      animation: fadeIn 0.5s;
    }

    .welcome-message {
      color: white;
      text-align: center;
      margin-top: 25vh;
      font-size: 2.2rem;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(10px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .logout-btn {
      background-color: #dc3545;
      border: none;
      color: white;
      padding: 8px 16px;
      border-radius: 5px;
    }

    .logout-btn:hover {
      background-color: #c82333;
    }

    .nav-icon {
      margin-right: 8px;
    }

    @media (max-width: 768px) {
      .sidebar {
        min-height: auto;
      }
    }
  </style>
</head>
<body>
  <!-- Blurred background overlay -->
  <div class="blur-overlay"></div>

  <div class="container-fluid">
    <div class="row">

      <!-- Sidebar -->
      <nav class="col-md-3 col-lg-2 sidebar">
        <div class="text-center text-white mb-4">
          <h4>RailTrack User</h4>
        </div>
        <ul class="nav flex-column px-3">
          <li class="nav-item">
            <a class="nav-link" href="#" onclick="showSection('user-details')">
              <i class="bi bi-person-lines-fill nav-icon"></i> Your Details
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#" onclick="showSection('list-trains-user')">
              <i class="bi bi-train-front nav-icon"></i> List of Trains
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#" onclick="showSection('booked-train-details')">
              <i class="bi bi-ticket-perforated nav-icon"></i> Booked Tickets
            </a>
          </li>
          <li class="nav-item mt-4">
            <a class="btn logout-btn w-100" href="confirm-logout-admin.jsp">Logout</a>
          </li>
        </ul>
      </nav>

      <!-- Main Content -->
      <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
        <div class="content-area">

          <!-- Welcome message -->
          <div id="welcome" class="welcome-message">
            <h class="fw-bold">Welcome, User</h>
            <p>Book your journey with comfort and ease!</p>
          </div>

          <!-- User Details Section -->
          <div id="user-details" class="content-container">
            <h5 class="mb-3"><i class="bi bi-person-lines-fill"></i> Your Details</h5>
            <jsp:include page="user-details.jsp" />
          </div>

          <!-- List Trains Section -->
          <div id="list-trains-user" class="content-container">
            <h5 class="mb-3"><i class="bi bi-train-front"></i> Available Trains</h5>
            <jsp:include page="list-trains-user.jsp" />
          </div>

          <!-- Booked Trains Section -->
          <div id="booked-train-details" class="content-container">
            <h5 class="mb-3"><i class="bi bi-ticket-perforated"></i> Booked Tickets</h5>
            <jsp:include page="booked-train-details.jsp" />
          </div>

        </div>
      </main>
    </div>
  </div>

  <!-- Scripts -->
  <script>
    function showSection(id) {
      document.getElementById('welcome').style.display = 'none';

      // Hide all content containers
      document.querySelectorAll('.content-container').forEach(div => div.classList.remove('active'));

      // Show selected one
      const section = document.getElementById(id);
      if (section) section.classList.add('active');

      // Highlight selected nav
      document.querySelectorAll('.nav-link').forEach(link => link.classList.remove('active'));
      const activeLink = Array.from(document.querySelectorAll('.nav-link')).find(link => link.onclick.toString().includes(id));
      if (activeLink) activeLink.classList.add('active');
    }
  </script>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
