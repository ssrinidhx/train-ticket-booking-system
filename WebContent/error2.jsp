<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <style>
        body {
            font-family: Calibri, sans-serif;
            background-color: #f8d7da;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .message-container {
            text-align: center;
            padding: 20px;
            border: 2px solid #f5c6cb;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .message-container h1 {
            color: #721c24;
            margin-bottom: 20px;
        }
        .message-container p {
            color: #721c24;
        }
        .message-container a {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            color: #ffffff;
            background-color: #721c24;
            text-decoration: none;
            border-radius: 4px;
        }
        .message-container a:hover {
            background-color: #491217;
        }
    </style>
</head>
<body>
    <div class="message-container">
        <h1>Error</h1>
        <p>There was an error processing your request. Please try again later.</p>
        <p><%= request.getAttribute("errorMessage") %></p>
        <a href="admin-dashboard.jsp">Go to Dashboard</a>
    </div>
</body>
</html>
