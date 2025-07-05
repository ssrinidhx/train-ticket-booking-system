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

@WebServlet("/EditTrainServlet")
public class EditTrainServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String trainNumber = request.getParameter("trainNumber");
        String trainName = request.getParameter("trainName");
        String departureDate = request.getParameter("departureDate");
        String departureTime = request.getParameter("departureTime");
        String fromStation = request.getParameter("fromStation");
        String toStation = request.getParameter("toStation");
        String pricePerSeat = request.getParameter("pricePerSeat");
        int maxSeats = Integer.parseInt(request.getParameter("maxSeats"));

        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false);

            // Check if any tickets are booked for the train
            String checkTicketsSql = "SELECT COUNT(*) AS booked_count FROM bookings WHERE train_number = ?";
            try (PreparedStatement checkTicketsStmt = con.prepareStatement(checkTicketsSql)) {
                checkTicketsStmt.setString(1, trainNumber);
                ResultSet rs = checkTicketsStmt.executeQuery();
                if (rs.next()) {
                    int bookedCount = rs.getInt("booked_count");
                    if (bookedCount > 0) {
                        // If tickets are booked, prevent max_seats change
                        response.getWriter().println("Cannot change max seats as tickets have been booked for this train.");
                        con.rollback();
                        return;
                    }
                }
            }

            // Update the trains table
            String updateTrainSql = "UPDATE trains SET train_name=?, departure_date=?, departure_time=?, from_station=?, to_station=?, price_per_seat=?, max_seats=? WHERE train_number=?";
            try (PreparedStatement updateTrainStmt = con.prepareStatement(updateTrainSql)) {
                updateTrainStmt.setString(1, trainName);
                updateTrainStmt.setString(2, departureDate);
                updateTrainStmt.setString(3, departureTime);
                updateTrainStmt.setString(4, fromStation);
                updateTrainStmt.setString(5, toStation);
                updateTrainStmt.setString(6, pricePerSeat);
                updateTrainStmt.setInt(7, maxSeats);
                updateTrainStmt.setString(8, trainNumber);

                int trainResult = updateTrainStmt.executeUpdate();

                if (trainResult > 0) {
                    // Update available_seats table if max_seats is changed
                    String updateAvailableSeatsSql = "UPDATE available_seats SET available_seats = ? WHERE train_number = ?";
                    try (PreparedStatement updateAvailableSeatsStmt = con.prepareStatement(updateAvailableSeatsSql)) {
                        updateAvailableSeatsStmt.setInt(1, maxSeats);
                        updateAvailableSeatsStmt.setString(2, trainNumber);
                        updateAvailableSeatsStmt.executeUpdate();
                    }

                    con.commit();
                    response.sendRedirect("admin-dashboard.jsp");
                } else {
                    con.rollback();
                    response.getWriter().println("Error updating train details.");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
