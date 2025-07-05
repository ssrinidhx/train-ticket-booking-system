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
import jakarta.servlet.http.HttpSession;

@WebServlet("/BookedTrainDetailsServlet")
public class BookedTrainDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
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
                    request.setAttribute("message", "No bookings found for this email.");
                }
                
                request.setAttribute("resultSet", rs);
                request.getRequestDispatcher("booked-train-details.jsp").forward(request, response);
                
                rs.close();
                ps.close();
                con.close();
            } catch (SQLException e) {
                request.setAttribute("errorMessage", "Database error: " + e.getMessage());
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}
