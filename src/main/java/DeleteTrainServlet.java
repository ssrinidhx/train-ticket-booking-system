import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import DBC.DBConnection;

@WebServlet("/DeleteTrainServlet")
public class DeleteTrainServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String trainID = request.getParameter("trainID");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false); // Start transaction

            // Delete train from trains table
            String deleteTrainSql = "DELETE FROM trains WHERE train_number = ?";
            ps = con.prepareStatement(deleteTrainSql);
            ps.setString(1, trainID);
            int rowsDeleted = ps.executeUpdate();

            // If train deletion was successful, delete available seats
            if (rowsDeleted > 0) {
                String deleteSeatsSql = "DELETE FROM available_seats WHERE train_number = ?";
                ps = con.prepareStatement(deleteSeatsSql);
                ps.setString(1, trainID);
                ps.executeUpdate();

                con.commit(); // Commit transaction
                response.sendRedirect("admin-dashboard.jsp#list-trains");
            } else {
                // Train deletion failed
                response.getWriter().println("Failed to delete train.");
                con.rollback(); // Rollback transaction
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
            try {
                if (con != null) {
                    con.rollback(); // Rollback transaction in case of error
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            // Close resources
            try {
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
