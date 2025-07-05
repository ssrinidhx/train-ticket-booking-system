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

@WebServlet("/bookSeats")
public class BookSeatsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String trainNumber = request.getParameter("trainNumber");
        int seatsToBook = Integer.parseInt(request.getParameter("seatsToBook"));

        try {
            Connection con = DBConnection.getConnection();
            con.setAutoCommit(false);

            // Fetch available seats
            PreparedStatement pst1 = con.prepareStatement("SELECT available_seats FROM available_seats WHERE train_number = ?");
            pst1.setString(1, trainNumber);
            ResultSet rs = pst1.executeQuery();
            if (rs.next()) {
                int availableSeats = rs.getInt("available_seats");

                if (availableSeats >= seatsToBook) {
                    // Update available seats
                    PreparedStatement pst2 = con.prepareStatement("UPDATE available_seats SET available_seats = ? WHERE train_number = ?");
                    pst2.setInt(1, availableSeats - seatsToBook);
                    pst2.setString(2, trainNumber);
                    pst2.executeUpdate();

                    // Insert booking record
                    PreparedStatement pst3 = con.prepareStatement("INSERT INTO bookings (train_number, seats_booked) VALUES (?, ?)");
                    pst3.setString(1, trainNumber);
                    pst3.setInt(2, seatsToBook);
                    pst3.executeUpdate();

                    con.commit();
                    response.sendRedirect("success.jsp");
                } else {
                    con.rollback();
                    response.sendRedirect("error.jsp?message=Not enough available seats");
                }
            } else {
                con.rollback();
                response.sendRedirect("error.jsp?message=Train not found");
            }

            rs.close();
            pst1.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=An error occurred while booking seats");
        }
    }
}
