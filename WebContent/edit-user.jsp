<%@ page import="java.sql.*, DBC.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit User</title>
    <style>
        body {
            font-family: Calibri, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .form-container {
            width: 400px;
            padding: 30px;
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        input[type="text"], input[type="number"], input[type="email"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            border: none;
            background: #0275d8;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background: #025aa5;
        }
        .form-group {
            display: flex;
            flex-direction: column;
            margin-bottom: 15px;
        }
        .form-group label {
            font-weight: bold;
            margin-bottom: 5px;
            color: #555;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Edit User</h1>
        <form action="EditUserServlet" method="post">
            <%-- Fetch user details from database based on userEmail from session --%>
            <%
            String userEmail = (String) session.getAttribute("userEmail");
            if (userEmail == null) {
                response.sendRedirect("user-login.jsp");
                return;
            }
            try {
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement("SELECT u.full_name, u.age, u.gender, u.phone_number, u.email " +
                                                            "FROM users u " +
                                                            "WHERE u.email = ?");
                ps.setString(1, userEmail);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    String fullName = rs.getString("full_name");
                    int age = rs.getInt("age");
                    String gender = rs.getString("gender");
                    String phoneNumber = rs.getString("phone_number");
            %>
            <input type="hidden" name="email" value="<%= userEmail %>">
            <div class="form-group">
                <label for="fullName">Full Name</label>
                <input type="text" id="fullName" name="fullName" value="<%= fullName %>" placeholder="Full Name" required>
            </div>
            <div class="form-group">
                <label for="age">Age</label>
                <input type="number" id="age" name="age" value="<%= age %>" placeholder="Age" required>
            </div>
            <div class="form-group">
                <label for="gender">Gender</label>
                <input type="text" id="gender" name="gender" value="<%= gender %>" placeholder="Gender" required>
            </div>
            <div class="form-group">
                <label for="phoneNumber">Phone Number</label>
                <input type="text" id="phoneNumber" name="phoneNumber" value="<%= phoneNumber %>" placeholder="Phone Number" required>
            </div>
            
            <input type="submit" value="Save">
            <%
                }
                rs.close();
                ps.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            %>
        </form>
    </div>
</body>
</html>
