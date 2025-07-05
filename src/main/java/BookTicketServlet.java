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

@WebServlet("/BookTicketServlet")
public class BookTicketServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("full_name");
        String phoneNumber = request.getParameter("phone_number");
        String email = request.getParameter("email");
        String trainName = request.getParameter("train_name");
        String trainNumber = request.getParameter("train_number");
        String departureDate = request.getParameter("departure_date");
        String departureTime = request.getParameter("departure_time");
        String fromStation = request.getParameter("from_station");
        String toStation = request.getParameter("to_station");
        String pricePerSeat = request.getParameter("price_per_seat");
        int seatsBooked = Integer.parseInt(request.getParameter("seats_booked"));
        double totalPrice = Double.parseDouble(request.getParameter("total_price"));

        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false);

            // Check available seats
            String checkSeatsSql = "SELECT available_seats FROM available_seats WHERE train_number = ?";
            try (PreparedStatement checkSeatsStmt = con.prepareStatement(checkSeatsSql)) {
                checkSeatsStmt.setString(1, trainNumber);
                ResultSet rs = checkSeatsStmt.executeQuery();
                if (rs.next()) {
                    int availableSeats = rs.getInt("available_seats");
                    if (seatsBooked > availableSeats) {
                        // Not enough seats available
                        response.getWriter().println("Not enough seats available. Only " + availableSeats + " seats are available.");
                        con.rollback();
                        return;
                    }
                } else {
                    response.getWriter().println("Train not found.");
                    con.rollback();
                    return;
                }
            }

            // Insert booking into bookings table
            String insertBookingSql = "INSERT INTO bookings (full_name, phone_number, email, train_name, train_number, departure_date, departure_time, from_station, to_station, price_per_seat, seats_booked, total_price) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement insertBookingStmt = con.prepareStatement(insertBookingSql)) {
                insertBookingStmt.setString(1, fullName);
                insertBookingStmt.setString(2, phoneNumber);
                insertBookingStmt.setString(3, email);
                insertBookingStmt.setString(4, trainName);
                insertBookingStmt.setString(5, trainNumber);
                insertBookingStmt.setString(6, departureDate);
                insertBookingStmt.setString(7, departureTime);
                insertBookingStmt.setString(8, fromStation);
                insertBookingStmt.setString(9, toStation);
                insertBookingStmt.setString(10, pricePerSeat);
                insertBookingStmt.setInt(11, seatsBooked);
                insertBookingStmt.setDouble(12, totalPrice);

                int bookingResult = insertBookingStmt.executeUpdate();

                if (bookingResult > 0) {
                    // Update available seats
                    String updateAvailableSeatsSql = "UPDATE available_seats SET available_seats = available_seats - ? WHERE train_number = ?";
                    try (PreparedStatement updateAvailableSeatsStmt = con.prepareStatement(updateAvailableSeatsSql)) {
                        updateAvailableSeatsStmt.setInt(1, seatsBooked);
                        updateAvailableSeatsStmt.setString(2, trainNumber);
                        updateAvailableSeatsStmt.executeUpdate();
                    }

                    con.commit();
                    response.sendRedirect("user-dashboard.jsp");
                } else {
                    con.rollback();
                    response.getWriter().println("Error booking ticket.");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("errorbook.jsp");
        }
    }
}
