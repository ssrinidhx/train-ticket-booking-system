import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import DBC.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CreateAccountServlet")
public class CreateAccountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String age = request.getParameter("age");
        String gender = request.getParameter("gender");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement checkEmail = con.prepareStatement("SELECT email FROM users WHERE email = ?");
            checkEmail.setString(1, email);
            ResultSet rs = checkEmail.executeQuery();
            
            if (rs.next()) {
                // Email already exists, redirect to error page
                response.sendRedirect("erroraccount.jsp");
            } else {
                // Email does not exist, proceed with insertion
                PreparedStatement ps = con.prepareStatement("INSERT INTO users (full_name, age, gender, phone_number, email) VALUES (?, ?, ?, ?, ?)");
                ps.setString(1, fullName);
                ps.setString(2, age);
                ps.setString(3, gender);
                ps.setString(4, phoneNumber);
                ps.setString(5, email);
                ps.executeUpdate();
                
                PreparedStatement ps2 = con.prepareStatement("INSERT INTO user_login (email, password) VALUES (?, ?)");
                ps2.setString(1, email);
                ps2.setString(2, password);
                ps2.executeUpdate();
                
                response.sendRedirect("user-login.jsp");
                ps.close();
                ps2.close();
            }
            
            rs.close();
            checkEmail.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
