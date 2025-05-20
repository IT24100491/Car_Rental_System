package com.vehicle_rental_management_system.model;

public class Vehicle {
    private String vehicleId;
    private String model;
    private double dailyRate;
    private String type;
    private String status; // Available, Rented, Maintenance

    public Vehicle() {}

    public Vehicle(String vehicleId, String model, double dailyRate, String type, String status) {
        this.vehicleId = vehicleId;
        this.model = model;
        this.dailyRate = dailyRate;
        this.type = type;
        this.status = status;
    }

    // Getters and Setters
    public String getVehicleId() { return vehicleId; }
    public void setVehicleId(String vehicleId) { this.vehicleId = vehicleId; }

    public String getModel() { return model; }
    public void setModel(String model) { this.model = model; }

    public double getDailyRate() { return dailyRate; }
    public void setDailyRate(double dailyRate) { this.dailyRate = dailyRate; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public boolean isAvailable() { return "Available".equals(status); }
}
