<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirm Logout</title>
    <style>
        body {
            font-family: 'Calibri', sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background-color: #ffffff;
            border: 1px solid #ccc;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 500px;
            text-align: center;
        }
        h2 {
            font-size: 24px;
            margin-bottom: 30px;
            color: #333;
        }
        .button {
            background-color: #0275d8;
            color: white;
            padding: 15px 30px;
            margin: 10px;
            cursor: pointer;
            border-radius: 4px;
            text-decoration: none;
            font-size: 15px;
            transition: background-color 0.3s ease;
            display: inline-block;
        }
        .button:hover {
            background-color: #025aa5;
        }
        .button-cancel {
            background-color: #f44336;
        }
        .button-cancel:hover {
            background-color: #d32f2f;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Are you sure you want to logout?</h2>
        <a href="admin-logout.jsp" class="button">Yes</a>
        <a href="admin-dashboard.jsp" class="button button-cancel">No</a>
    </div>
</body>
</html>
