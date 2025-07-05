<%@ page import="java.sql.*, DBC.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>
    <style>
        body {
            text-align: center;
            font-family: Calibri, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .form-container {
            width: 400px;
            padding: 30px;
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            text-align: left;
            font-weight: bold;
            margin-bottom: 5px;
            color: #555;
        }
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .button {
            width: 100%;
            padding: 12px;
            border: none;
            background: #0275d8;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
            transition: background-color 0.3s ease;
        }
        .button:hover {
            background-color: #025aa5;
        }
        .error-message {
            color: red;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Change Password</h1>
        <% 
            String errorMessage = (String) session.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <div class="error-message"><%= errorMessage %></div>
        <% 
            session.removeAttribute("errorMessage");
            }
        %>
        <form action="ChangePasswordServlet" method="post">
            <div class="form-group">
                <label for="oldPassword">Old Password</label>
                <input type="password" id="oldPassword" name="oldPassword" required>
            </div>
            <div class="form-group">
                <label for="newPassword">New Password</label>
                <input type="password" id="newPassword" name="newPassword" required>
            </div>
            <button type="submit" class="button">Change Password</button>
        </form>
    </div>
</body>
</html>
