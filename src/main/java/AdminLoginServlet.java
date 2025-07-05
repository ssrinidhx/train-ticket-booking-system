import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import DBC.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        System.out.println("Username: " + username);  // Debug statement
        System.out.println("Password: " + password);  // Debug statement

        try (Connection connection = DBConnection.getConnection()) {
            String sql = "SELECT * FROM admin WHERE username = ? AND password = ? AND role = 'admin'";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, password);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                // Redirect to admin dashboard on successful login
                response.sendRedirect("admin-dashboard.jsp");
            } else {
                // Redirect back to login page with error message
                response.sendRedirect("error.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle database connection or query errors
            // Redirect to an error page or log the error details
            response.sendRedirect("error.jsp");
        }
    }
}