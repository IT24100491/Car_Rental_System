package com.vehicle_rental_management_system.utils;

import com.vehicle_rental_management_system.model.Vehicle;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class VehicleUtil {
    private static List<Vehicle> vehicles = new ArrayList<>();
    private Connection connection;

    // Initialize with sample data
    static {
        vehicles.add(new Vehicle("V001", "Toyota Camry", 50.0, "Sedan", "Available"));
        vehicles.add(new Vehicle("V002", "Honda CR-V", 65.0, "SUV", "Available"));
        vehicles.add(new Vehicle("V003", "Ford F-150", 75.0, "Truck", "Maintenance"));
    }

    public VehicleUtil() {
        try {
            // Initialize database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.connection = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/vehicle_rental_db",
                    "username",
                    "password"
            );
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Vehicle findVehicleById(String vehicleId) {
        // First check in-memory list
        Vehicle vehicle = vehicles.stream()
                .filter(v -> v.getVehicleId().equals(vehicleId))
                .findFirst()
                .orElse(null);

        if (vehicle != null) {
            return vehicle;
        }

        // If not found, check database
        String sql = "SELECT * FROM vehicles WHERE vehicle_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, vehicleId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                vehicle = new Vehicle(
                        rs.getString("vehicle_id"),
                        rs.getString("model"),
                        rs.getDouble("daily_rate"),
                        rs.getString("type"),
                        rs.getString("status")
                );
                vehicles.add(vehicle); // Cache the vehicle
                return vehicle;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Vehicle> getAvailableVehicles() {
        List<Vehicle> availableVehicles = new ArrayList<>();

        // Check in-memory list first
        availableVehicles.addAll(
                vehicles.stream()
                        .filter(Vehicle::isAvailable)
                        .collect(Collectors.toList())
        );

        // Also check database
        String sql = "SELECT * FROM vehicles WHERE status = 'Available'";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                String vehicleId = rs.getString("vehicle_id");
                // Only add if not already in our list
                if (availableVehicles.stream().noneMatch(v -> v.getVehicleId().equals(vehicleId))) {
                    Vehicle vehicle = new Vehicle(
                            vehicleId,
                            rs.getString("model"),
                            rs.getDouble("daily_rate"),
                            rs.getString("type"),
                            rs.getString("status")
                    );
                    availableVehicles.add(vehicle);
                    vehicles.add(vehicle); // Cache the vehicle
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return availableVehicles;
    }

    public boolean updateVehicleStatus(String vehicleId, String status) {
        // Update in-memory list
        for (Vehicle vehicle : vehicles) {
            if (vehicle.getVehicleId().equals(vehicleId)) {
                vehicle.setStatus(status);
                break;
            }
        }

        // Update database
        String sql = "UPDATE vehicles SET status = ? WHERE vehicle_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setString(2, vehicleId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean addVehicle(Vehicle vehicle) {
        vehicles.add(vehicle); // Add to in-memory list

        String sql = "INSERT INTO vehicles (vehicle_id, model, daily_rate, type, status) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, vehicle.getVehicleId());
            stmt.setString(2, vehicle.getModel());
            stmt.setDouble(3, vehicle.getDailyRate());
            stmt.setString(4, vehicle.getType());
            stmt.setString(5, vehicle.getStatus());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void close() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}