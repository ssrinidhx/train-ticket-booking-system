<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
    <style>
        body {
            font-family: Calibri, sans-serif;
            background-color: #f2f2f2;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .error-container {
            background-color: #ffffff;
            border: 1px solid #ccc;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            max-width: 500px;
            text-align: center;
        }
        .error-container h1 {
            color: #ff0000;
            font-size: 24px;
        }
        .error-container p {
            font-size: 18px;
            color: #333;
        }
        .error-container a {
            color: #0066cc;
            text-decoration: none;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>Something went wrong!</h1>
        <p>We encountered an error while processing your request. Please try again later.</p>
        <p><a href="index.jsp">Go back to the homepage</a></p>
    </div>
</body>
</html>
