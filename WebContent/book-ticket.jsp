<%@ page import="java.sql.*, DBC.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book Ticket</title>
    <style>
        body {
            font-family: Calibri, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        form {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        label {
            display: block;
            margin-bottom: 10px;
            color: #333;
        }
        input, select {
            width: 95%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .button {
            background-color: #0275d8;
            color: white;
            padding: 10px 15px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            cursor: pointer;
            border-radius: 4px;
            margin-right: 5px;
            width: 100%;
        }
        .button:hover {
            background-color: #025aa5;
        }
    </style>
    <script>
        function calculateTotalPrice() {
            var pricePerSeat = parseFloat(document.getElementById("price_per_seat").value);
            var numberOfSeats = parseInt(document.getElementById("seats_booked").value);
            var totalPrice = pricePerSeat * numberOfSeats;
            document.getElementById("total_price").value = totalPrice.toFixed(2);
        }
    </script>
</head>
<body>
    <div>
        <h1>Book Ticket</h1>
        <form action="BookTicketServlet" method="POST">
            <%
            Connection con = null;
            PreparedStatement userPst = null;
            PreparedStatement trainPst = null;
            ResultSet userRs = null;
            ResultSet trainRs = null;

            try {
                con = DBConnection.getConnection();

                // Retrieve user details
                String email = request.getParameter("userEmail");
                String userQuery = "SELECT full_name, phone_number, email FROM users WHERE email=?";
                userPst = con.prepareStatement(userQuery);
                userPst.setString(1, email);
                userRs = userPst.executeQuery();

                String fullName = "";
                String phoneNumber = "";

                if (userRs.next()) {
                    fullName = userRs.getString("full_name");
                    phoneNumber = userRs.getString("phone_number");
                    email = userRs.getString("email");
                }

                // Retrieve train details
                String trainNumber = request.getParameter("trainId");
                String trainQuery = "SELECT train_name, train_number, departure_date, departure_time, from_station, to_station, price_per_seat FROM trains WHERE train_number=?";
                trainPst = con.prepareStatement(trainQuery);
                trainPst.setString(1, trainNumber);
                trainRs = trainPst.executeQuery();

                if (trainRs.next()) {
            %>

            <label for="full_name">Full Name</label>
            <input type="text" id="full_name" name="full_name" value="<%= fullName %>" required>

            <label for="phone_number">Phone Number</label>
            <input type="text" id="phone_number" name="phone_number" value="<%= phoneNumber %>" required>

            <label for="email">Email</label>
            <input type="email" id="email" name="email" value="<%= email %>" required>

            <label for="train_name">Train Name</label>
            <input type="text" id="train_name" name="train_name" value="<%= trainRs.getString("train_name") %>" readonly>

            <label for="train_number">Train Number</label>
            <input type="text" id="train_number" name="train_number" value="<%= trainRs.getString("train_number") %>" readonly>

            <label for="departure_date">Date of Departure</label>
            <input type="text" id="departure_date" name="departure_date" value="<%= trainRs.getString("departure_date") %>" readonly>

            <label for="departure_time">Time of Departure</label>
            <input type="text" id="departure_time" name="departure_time" value="<%= trainRs.getString("departure_time") %>" readonly>

            <label for="from_station">From</label>
            <input type="text" id="from_station" name="from_station" value="<%= trainRs.getString("from_station") %>" readonly>

            <label for="to_station">To</label>
            <input type="text" id="to_station" name="to_station" value="<%= trainRs.getString("to_station") %>" readonly>

            <label for="price_per_seat">Price per Seat</label>
            <input type="text" id="price_per_seat" name="price_per_seat" value="<%= trainRs.getString("price_per_seat") %>" readonly>

            <label for="seats_booked">Number of Seats</label>
            <input type="number" id="seats_booked" name="seats_booked" required oninput="calculateTotalPrice()">

            <label for="total_price">Total Price</label>
            <input type="text" id="total_price" name="total_price" readonly>

            <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (userRs != null) try { userRs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (userPst != null) try { userPst.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (trainRs != null) try { trainRs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (trainPst != null) try { trainPst.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            %>

            <button type="submit" class="button">Book Ticket</button>
        </form>
    </div>
</body>
</html>
