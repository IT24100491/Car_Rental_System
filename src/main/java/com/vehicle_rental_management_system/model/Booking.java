package com.vehicle_rental_management_system.model;

import java.time.LocalDateTime;

public class Booking {
    private String bookingId;
    private String vehicleId;
    private String customerId;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private String status;
    private double totalCost;
    private boolean overdue;
    private boolean insurance;
    private boolean gps;

    // Constructors
    public Booking() {}

    public Booking(String bookingId, String vehicleId, String customerId,
                   LocalDateTime startTime, LocalDateTime endTime,
                   String status, double totalCost, boolean insurance, boolean gps) {
        this.bookingId = bookingId;
        this.vehicleId = vehicleId;
        this.customerId = customerId;
        this.startTime = startTime;
        this.endTime = endTime;
        this.status = status;
        this.totalCost = totalCost;
        this.insurance = insurance;
        this.gps = gps;
        this.overdue = LocalDateTime.now().isAfter(endTime) && status.equals("active");
    }

    // Getters and Setters
    public String getBookingId() { return bookingId; }
    public void setBookingId(String bookingId) { this.bookingId = bookingId; }

    public String getVehicleId() { return vehicleId; }
    public void setVehicleId(String vehicleId) { this.vehicleId = vehicleId; }

    public String getCustomerId() { return customerId; }
    public void setCustomerId(String customerId) { this.customerId = customerId; }

    public LocalDateTime getStartTime() { return startTime; }
    public void setStartTime(LocalDateTime startTime) { this.startTime = startTime; }

    public LocalDateTime getEndTime() { return endTime; }
    public void setEndTime(LocalDateTime endTime) {
        this.endTime = endTime;
        this.overdue = LocalDateTime.now().isAfter(endTime) && status.equals("active");
    }

    public String getStatus() { return status; }
    public void setStatus(String status) {
        this.status = status;
        this.overdue = LocalDateTime.now().isAfter(endTime) && status.equals("active");
    }

    public double getTotalCost() { return totalCost; }
    public void setTotalCost(double totalCost) { this.totalCost = totalCost; }

    public boolean isOverdue() { return overdue; }
    public boolean hasInsurance() { return insurance; }
    public void setInsurance(boolean insurance) { this.insurance = insurance; }
    public boolean hasGps() { return gps; }
    public void setGps(boolean gps) { this.gps = gps; }
}