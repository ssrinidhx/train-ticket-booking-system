<%@ page import="java.sql.*" %>
<%@ page import="DBC.DBConnection"%>
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
        <h1>List of Booked Passengers</h1>
        <table>
	        <thead>
	            <tr>
	                <th>Passenger Name</th>
                    <th>Phone Number</th>
                    <th>Email</th>
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
                try {
                    Connection con = DBConnection.getConnection();
                    Statement st = con.createStatement();
                    ResultSet rs = st.executeQuery("SELECT * FROM bookings");
                    while (rs.next()) {
                %>
                <tr>
                	<td><%= rs.getString(2) %></td>
                    <td><%= rs.getString(3) %></td>
                    <td><%= rs.getString(4) %></td>
                    <td><%= rs.getString(5) %></td>
                    <td><%= rs.getString(6) %></td>
                    <td><%= rs.getString(7) %></td>
                    <td><%= rs.getString(8) %></td>
                    <td><%= rs.getString(9) %></td>
                    <td><%= rs.getString(10) %></td>
                    <td><%= rs.getString(12) %></td>
                    <td><%= rs.getString(13) %></td>
                </tr>
            	<%
        			}
                } catch (Exception e) {
                    System.out.println(e);
                }
                %>
            </tbody>
        </table>
    </div>
    <script>
        // JavaScript to handle navigation
        window.addEventListener('load', function() {
            if (window.location.hash === '#list-trains') {
                // Logic to show the registered students section
                document.getElementById('list-trains').scrollIntoView();
            }
        });
    </script>
</body>
</html>
