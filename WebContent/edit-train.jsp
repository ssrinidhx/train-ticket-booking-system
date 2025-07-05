<%@ page import="java.sql.*, DBC.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Train</title>
    <style>
        body {
            text-align: center;
            font-family: 'Calibri', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .form-container {
            width: 50%;
            margin: 50px auto;
            padding: 20px;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .form-container h1 {
            margin-bottom: 20px;
            color: #333;
        }
        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        input[type="text"], input[type="number"], input[type="date"], input[type="time"], select {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
        }
        input[type="submit"] {
            width: 100%;
            padding: 15px;
            border: none;
            background: #0275d8;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            font-size: 18px;
            transition: background 0.3s;
        }
        input[type="submit"]:hover {
            background: #025aa5;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Edit Train</h1>
        <form action="EditTrainServlet" method="post">
            <%-- Fetch train details from database based on trainNumber --%>
            <%
            try {
                String trainNumber = request.getParameter("trainId");
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement("SELECT * FROM trains WHERE train_number = ?");
                ps.setString(1, trainNumber);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    String trainName = rs.getString("train_name");
                    String departureDate = rs.getString("departure_date");
                    String departureTime = rs.getString("departure_time");
                    String fromStation = rs.getString("from_station");
                    String toStation = rs.getString("to_station");
                    String pricePerSeat = rs.getString("price_per_seat");
                    String maxSeats = rs.getString("max_seats");
            %>
            <input type="hidden" name="trainNumber" value="<%= trainNumber %>">
            <input type="text" name="trainName" value="<%= trainName %>" placeholder="Train Name" required>
            <input type="date" name="departureDate" value="<%= departureDate %>" placeholder="Departure Date" required>
            <input type="time" name="departureTime" value="<%= departureTime %>" placeholder="Departure Time" required>
            <input type="text" name="fromStation" value="<%= fromStation %>" placeholder="From Station" required>
            <input type="text" name="toStation" value="<%= toStation %>" placeholder="To Station" required>
            <input type="number" step="0.01" name="pricePerSeat" value="<%= pricePerSeat %>" placeholder="Price Per Seat" required>
            <input type="number" name="maxSeats" value="<%= maxSeats %>" placeholder="Max Seats" required>
            
            <input type="submit" value="Save">
            <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            %>
        </form>
    </div>
</body>
</html>
