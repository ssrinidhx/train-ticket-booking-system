import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import DBC.DBConnection;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("userEmail");
        if (email == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            String checkPasswordSql = "SELECT password FROM user_login WHERE email = ?";
            ps = con.prepareStatement(checkPasswordSql);
            ps.setString(1, email);
            rs = ps.executeQuery();

            if (rs.next() && rs.getString("password").equals(oldPassword)) {
                String updatePasswordSql = "UPDATE user_login SET password = ? WHERE email = ?";
                ps = con.prepareStatement(updatePasswordSql);
                ps.setString(1, newPassword);
                ps.setString(2, email);
                int updated = ps.executeUpdate();
                if (updated > 0) {
                    response.sendRedirect("user-dashboard.jsp?message=Password changed successfully");
                } else {
                    session.setAttribute("errorMessage", "Error updating password");
                    response.sendRedirect("change-password.jsp");
                }
            } else {
                session.setAttribute("errorMessage", "Old password is incorrect");
                response.sendRedirect("change-password.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
