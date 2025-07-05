<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Train</title>
    <style>
        body {
            font-family: Calibri, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .form-container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            max-width: 600px;
            margin: 40px auto;
            border-top: 5px solid #0275d8;
        }
        .form-container h2 {
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }
        .form-container label {
            font-size: 16px;
            margin-bottom: 5px;
            display: block;
            color: #333;
        }
        .form-container input, .form-container select {
            width: 100%;
            padding: 12px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .form-container button {
            background-color: #0275d8;
            color: white;
            padding: 15px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
        }
        .form-container button:hover {
            background-color: #025aa5;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Add New Train</h2>
        <form action="AddNewTrainServlet" method="post">
            <label for="trainName">Train Name</label>
            <input type="text" id="trainName" name="trainName" required>

            <label for="trainNumber">Train Number</label>
            <input type="text" id="trainNumber" name="trainNumber" required>

            <label for="departureDate">Date of Departure</label>
            <input type="date" id="departureDate" name="departureDate" required>

            <label for="departureTime">Time of Departure</label>
            <input type="time" id="departureTime" name="departureTime" required>

            <label for="fromStation">From Station</label>
            <input type="text" id="fromStation" name="fromStation" required>

            <label for="toStation">To Station</label>
            <input type="text" id="toStation" name="toStation" required>

            <label for="pricePerSeat">Price Per Seat</label>
            <input type="number" id="pricePerSeat" name="pricePerSeat" step="10" required>

            <label for="maxSeats">Maximum Seats</label>
            <input type="number" id="maxSeats" name="maxSeats" required>

            <button type="submit">Add Train</button>
        </form>
    </div>
</body>
</html>
