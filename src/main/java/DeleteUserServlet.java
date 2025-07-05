import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import DBC.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("userEmail");

        try {
            Connection con = DBConnection.getConnection();
            String deleteUserSQL = "DELETE FROM users WHERE email = ?";
            String deleteLoginSQL = "DELETE FROM user_login WHERE email = ?";
            
            // Delete from users table
            PreparedStatement psUser = con.prepareStatement(deleteUserSQL);
            psUser.setString(1, email);
            psUser.executeUpdate();
            psUser.close();

            // Delete from user_login table
            PreparedStatement psLogin = con.prepareStatement(deleteLoginSQL);
            psLogin.setString(1, email);
            psLogin.executeUpdate();
            psLogin.close();

            con.close();
            session.invalidate();
            response.sendRedirect("user-login.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
