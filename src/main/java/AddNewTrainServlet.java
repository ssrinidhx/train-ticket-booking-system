import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import DBC.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddNewTrainServlet")
public class AddNewTrainServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String trainName = request.getParameter("trainName");
        String trainNumber = request.getParameter("trainNumber");
        String departureDate = request.getParameter("departureDate");
        String departureTime = request.getParameter("departureTime");
        String fromStation = request.getParameter("fromStation");
        String toStation = request.getParameter("toStation");
        String pricePerSeat = request.getParameter("pricePerSeat");
        int maxSeats = Integer.parseInt(request.getParameter("maxSeats"));

        try (Connection connection = DBConnection.getConnection()) {
            connection.setAutoCommit(false);

            // Insert into trains table
            String trainSql = "INSERT INTO trains (train_number, max_seats, train_name, departure_date, departure_time, from_station, to_station, price_per_seat) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement trainStatement = connection.prepareStatement(trainSql);
            trainStatement.setString(1, trainNumber);
            trainStatement.setInt(2, maxSeats);
            trainStatement.setString(3, trainName);
            trainStatement.setString(4, departureDate);
            trainStatement.setString(5, departureTime);
            trainStatement.setString(6, fromStation);
            trainStatement.setString(7, toStation);
            trainStatement.setString(8, pricePerSeat);
            trainStatement.executeUpdate();

            // Insert into available_seats table
            String availableSeatsSql = "INSERT INTO available_seats (train_number, available_seats) VALUES (?, ?)";
            PreparedStatement availableSeatsStatement = connection.prepareStatement(availableSeatsSql);
            availableSeatsStatement.setString(1, trainNumber);
            availableSeatsStatement.setInt(2, maxSeats);
            availableSeatsStatement.executeUpdate();

            connection.commit();

            response.sendRedirect("admin-dashboard.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("erroradd.jsp");
        }
    }
}
