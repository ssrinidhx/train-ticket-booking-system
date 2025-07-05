<%@ page import="java.sql.*, DBC.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>List of Trains</title>
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
            background-color: #0275d8 !important; /* Ensuring blue color */
            color: white !important;
        }
        tr:hover {
            background-color: #ddd;
        }
        .button {
            background-color: #0275d8 !important; /* Ensuring blue color */
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
        .delete {
            background-color: red !important;
        }
        .delete:hover {
            background-color: darkred !important;
        }
        .action-buttons {
            display: flex;
            justify-content: space-around;
        }
    </style>
</head>
<body>
    <div class="table-container">
        <h1>List of Trains</h1>
        <table>
            <thead>
                <tr>
                    <th>Train Name</th>
                    <th>Train Number</th>
                    <th>Date of Departure</th>
                    <th>Time of Departure</th>
                    <th>From</th>
                    <th>To</th>
                    <th>Price per Seat</th>
                    <th>Max Seats</th>
                    <th>Available Seats</th>
                    <th>Book</th>
                </tr>
            </thead>
            <tbody>
                <%
                try {
                    Connection con = DBConnection.getConnection();
                    Statement st = con.createStatement();
                    ResultSet rs = st.executeQuery("SELECT t.*, COALESCE(a.available_seats, t.max_seats) AS available_seats FROM trains t LEFT JOIN available_seats a ON t.train_number = a.train_number");
                    while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString("train_name") %></td>
                    <td><%= rs.getString("train_number") %></td>
                    <td><%= rs.getString("departure_date") %></td>
                    <td><%= rs.getString("departure_time") %></td>
                    <td><%= rs.getString("from_station") %></td>
                    <td><%= rs.getString("to_station") %></td>
                    <td><%= rs.getString("price_per_seat") %></td>
                    <td><%= rs.getString("max_seats") %></td>
                    <td><%= rs.getInt("available_seats") %></td>
                    <td class="action-buttons">
                        <a href="book-ticket.jsp?trainId=<%= rs.getString("train_number") %>" class="button">Book Ticket</a>
                    </td>
                </tr>
                <%
                    }
                    rs.close();
                    st.close();
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
