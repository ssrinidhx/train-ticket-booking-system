<%@ page import="java.sql.*" %>
<%@ page import="DBC.DBConnection"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booked Train Details</title>
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #0275d8 !important;
            color: white !important;
        }
        tr:hover {
            background-color: #ddd;
        }
        .button {
            background-color: #0275d8 !important;
            color: white !important;
            padding: 10px 15px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            cursor: pointer;
            border-radius: 4px;
            margin-right: 5px;
        }
        .button:hover {
            background-color: #025aa5 !important;
        }
    </style>
</head>
<body>
        <div class="results">
            <h3>Your Booked Train Details</h3>
            <table>
                <thead>
                    <tr>
                        <th>Train Name</th>
                        <th>Train Number</th>
                        <th>Date of Departure</th>
                        <th>Time of Departure</th>
                        <th>From</th>
                        <th>To</th>
                        <th>Seats Booked</th>
                        <th>Total Price</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    String userEmail = (String) session.getAttribute("userEmail");
                    if (userEmail != null) {
                        try {
                            Connection con = DBConnection.getConnection();
                            String sql = "SELECT b.full_name, b.phone_number, b.email, t.train_name, t.train_number, t.departure_date, t.departure_time, t.from_station, t.to_station, b.seats_booked, (b.seats_booked * t.price_per_seat) AS total_price " +
                                         "FROM bookings b " +
                                         "JOIN trains t ON b.train_number = t.train_number " +
                                         "WHERE b.email = ?";
                            PreparedStatement ps = con.prepareStatement(sql);
                            ps.setString(1, userEmail);
                            ResultSet rs = ps.executeQuery();
                            
                            if (!rs.isBeforeFirst()) {
                                out.println("<tr><td colspan='8'>No bookings found for this email.</td></tr>");
                            } else {
                                while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getString("train_name") %></td>
                        <td><%= rs.getString("train_number") %></td>
                        <td><%= rs.getString("departure_date") %></td>
                        <td><%= rs.getString("departure_time") %></td>
                        <td><%= rs.getString("from_station") %></td>
                        <td><%= rs.getString("to_station") %></td>
                        <td><%= rs.getInt("seats_booked") %></td>
                        <td><%= rs.getDouble("total_price") %></td>
                    </tr>
                    <%
                                }
                            }
                            rs.close();
                            ps.close();
                            con.close();
                        } catch (SQLException e) {
                            out.println("<tr><td colspan='8'>An error occurred: " + e.getMessage() + "</td></tr>");
                        }
                    } else {
                        out.println("<tr><td colspan='8'>User not logged in.</td></tr>");
                    }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>