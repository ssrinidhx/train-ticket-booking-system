<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <style>
        body {
            font-family: Calibri, sans-serif;
            text-align: center;
            background-color: #f2f2f2;
            margin: 0;
            padding: 50px;
        }
        .error-message {
            color: red;
            font-size: 24px;
            margin: 20px 0;
        }
        .button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            cursor: pointer;
            border-radius: 4px;
            border: none;
        }
        .button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h1>Error</h1>
    <div class="error-message">
        An account with this email already exists. Please use a different email.
    </div>
    <a href="create-account.jsp" class="button">Go Back</a>
</body>
</html>
