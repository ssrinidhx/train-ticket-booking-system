<%@ page import="java.sql.*" %>
<%@ page import="DBC.DBConnection"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Login</title>
    <style>
        body {
            background-image: url('images/metro-train.avif');
            background-size: cover;
            background-position: center;
            color: white;
            font-family: Arial, sans-serif;
            position: relative;
            margin: 0;
            padding: 0;
            height: 100vh;
            overflow: hidden;
        }
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: inherit;
            filter: blur(5px); /* Light blur effect */
            z-index: -1;
        }
        .login-box {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 400px;
            padding: 30px;
            background: rgba(0, 0, 0, 0.7);
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
            text-align: center; /* Center text inside the login box */
        }
        .login-box h2 {
            margin: 0 0 20px;
            text-align: center;
        }
        .login-box input[type="text"],
        .login-box input[type="password"] {
            width: 95%;
            padding: 10px;
            margin: 10px 0;
            border: none;
            border-radius: 5px;
        }
        .login-box input[type="password"] {
            margin-bottom: 20px;
        }
        .login-box input[type="submit"] {
            width: 100%;
            padding: 10px;
            border: none;
            background: #ff5722;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .link {
            display: block;
            margin-top: 10px;
            color: #00aaff; /* Changed color */
            text-decoration: underline;
            cursor: pointer;
            text-align: center; /* Center the link text */
        }
    </style>
</head>
<body>
    <div class="login-box">
        <h2>User Login</h2>
        <form action="UserLoginServlet" method="post">
            <input type="text" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="submit" value="Login">
        </form>
        <a href="create-account.jsp" class="link">Create an account</a>
    </div>
</body>
</html>
