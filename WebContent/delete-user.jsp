<%@ page import="java.sql.*, DBC.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete User Confirmation</title>
    <style>
        body {
            font-family: Calibri, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .confirmation-container {
            width: 400px;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        h2 {
            color: #333;
            margin-bottom: 20px;
        }
        .button-container {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 20px;
        }
        .button {
            padding: 10px 20px;
            border: none;
            background-color: #0275d8;
            color: white;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.3s ease;
            text-decoration: none;
        }
        .button:hover {
            background-color: #025aa5;
        }
        .button-delete {
            background-color: #d9534f;
        }
        .button-delete:hover {
            background-color: #c9302c;
        }
        .button-cancel {
            background-color: #0275d8;
        }
        .button-cancel:hover {
            background-color: #025aa5;
        }
    </style>
</head>
<body>
    <div class="confirmation-container">
        <h2>Are you sure you want to delete your account?</h2>
        <div class="button-container">
            <form action="DeleteUserServlet" method="post" style="display:inline;">
                <button type="submit" class="button button-delete">Yes, Delete</button>
            </form>
            <a href="user-dashboard.jsp" class="button button-cancel">Cancel</a>
        </div>
    </div>
</body>
</html>
