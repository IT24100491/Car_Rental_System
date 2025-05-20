package com.vehicle_rental_management_system.utils;

import com.vehicle_rental_management_system.model.Vehicle;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;  // Required for toList() in older Java versions

public class VehicleUtil {
    private static List<Vehicle> vehicles = new ArrayList<>();

    static {
        // Initialize with sample vehicles
        vehicles.add(new Vehicle("V001", "Toyota Camry", 50.0, "Sedan", "Available"));
        vehicles.add(new Vehicle("V002", "Ford Explorer", 70.0, "SUV", "Available"));
        vehicles.add(new Vehicle("V003", "Honda Civic", 45.0, "Sedan", "Maintenance"));
    }

    public List<Vehicle> findAvailableVehicles() {
        return vehicles.stream()
                .filter(v -> "Available".equals(v.getStatus()))
                .collect(Collectors.toList());  // Changed from just toList()
    }

    public boolean updateVehicle(Vehicle updatedVehicle) {
        for (int i = 0; i < vehicles.size(); i++) {
            if (vehicles.get(i).getVehicleId().equals(updatedVehicle.getVehicleId())) {
                vehicles.set(i, updatedVehicle);
                return true;
            }
        }
        return false;
    }

    // Other methods remain the same...
}