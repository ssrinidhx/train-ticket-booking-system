import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import DBC.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/EditUserServlet")
public class EditUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        String phoneNumber = request.getParameter("phoneNumber");

        try {
            Connection con = DBConnection.getConnection();
            String sql = "UPDATE users SET full_name = ?, age = ?, gender = ?, phone_number = ? WHERE email = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, fullName);
            ps.setInt(2, age);
            ps.setString(3, gender);
            ps.setString(4, phoneNumber);
            ps.setString(5, email);
            ps.executeUpdate();
            ps.close();
            con.close();

            response.sendRedirect("user-dashboard.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
