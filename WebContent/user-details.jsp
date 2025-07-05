<%@ page import="java.sql.*, DBC.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Details</title>
    <style>
        body {
            font-family: Calibri, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .header {
            background-color: #0275d8;
            color: white;
            padding: 15px;
            text-align: center;
            font-size: 24px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        .details {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        .details div {
            display: flex;
            justify-content: space-between;
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        .details div:last-child {
            border-bottom: none;
        }
        .label {
            font-weight: bold;
            color: #555;
        }
        .value {
            color: #333;
        }
        .password-container {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
        }
        .link {
            color: #0275d8;
            text-decoration: none;
        }
        .link:hover {
            text-decoration: underline;
        }
        .button-container {
            display: flex;
            justify-content: center;
            margin-top: 20px;
            gap: 10px;
        }
        .button {
            padding: 10px 20px;
            border: none;
            background-color: #d9534f;
            color: white;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }
        .button:hover {
            background-color: #025aa5;
        }
        .button-delete {
            background-color: #dc3545;
        }
        .button-delete:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>User Details</h1>
        <div class="details">
            <%
            String userEmail = (String) session.getAttribute("userEmail");
            if (userEmail == null) {
                response.sendRedirect("user-login.jsp");
                return;
            }
            try {
                Connection con = DBConnection.getConnection();
                String sql = "SELECT u.full_name, u.age, u.gender, u.phone_number, u.email, l.password " +
                             "FROM users u " +
                             "JOIN user_login l ON u.email = l.email " +
                             "WHERE u.email = ?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, userEmail);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
            %>
            <div>
                <span class="label">Full Name</span> <span class="value"><%= rs.getString("full_name") %></span>
            </div>
            <div>
                <span class="label">Age</span> <span class="value"><%= rs.getInt("age") %></span>
            </div>
            <div>
                <span class="label">Gender</span> <span class="value"><%= rs.getString("gender") %></span>
            </div>
            <div>
                <span class="label">Phone Number</span> <span class="value"><%= rs.getString("phone_number") %></span>
            </div>
            <div>
                <span class="label">Email</span> <span class="value"><%= rs.getString("email") %></span>
            </div>
            <div>
            	<span class="label">Password</span> <span class="value"><%= rs.getString("password") %></span>
            </div>
            <div class="password-container">
                <a href="change-password.jsp" class="link">Change Password</a>
            	<div class="button-container">
                	<form action="edit-user.jsp" method="post" style="display:inline;">
                    	<button type="submit" class="button">Edit</button>
                	</form>
                	<form action="delete-user.jsp" method="post" style="display:inline;">
                    	<button type="submit" class="button delete">Delete</button>
                	</form>
            	</div>
            </div>
            <%
                }
                rs.close();
                ps.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            %>
        </div>
    </div>
</body>
</html>
