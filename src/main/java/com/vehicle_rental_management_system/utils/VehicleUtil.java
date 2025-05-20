package com.vehicle_rental_management_system.utils;

import com.vehicle_rental_management_system.model.Vehicle;
import java.sql.*;

public class VehicleUtil {
    private Connection connection; // Database connection

    // Constructor with DB connection initialization
    public VehicleUtil() {
        try {
            // Initialize database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.connection = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/vehicle_rental_db",
                    "username", "password");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Add this missing method
    public Vehicle findVehicleById(String vehicleId) {
        String sql = "SELECT * FROM vehicles WHERE vehicle_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, vehicleId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Vehicle{
                    rs.getString("vehicle_id"),
                            rs.getString("model"),
                            rs.getDouble("daily_rate")
                    // Add other vehicle properties as needed
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Other utility methods...
}