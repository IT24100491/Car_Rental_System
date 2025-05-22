package com.vehicle_rental_management_system.models;

import java.util.Date;

public class Booking {
    private int bookingId;
    private String customerName;
    private String vehicleId;
    private Date startDate;
    private Date endDate;
    private double totalCost;
    private String status; // "pending", "confirmed", "cancelled", "completed"

    public Booking() {
        this.totalCost = 0.0;
        this.status = "pending";
    }

    public Booking(int bookingId, String customerName, String vehicleId,
                   Date startDate, Date endDate, double totalCost, String status) {
        this.bookingId = bookingId;
        this.customerName = customerName;
        this.vehicleId = vehicleId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.totalCost = totalCost;
        this.status = (status != null) ? status : "pending";
    }

    // Getters and Setters
    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(String vehicleId) {
        this.vehicleId = vehicleId;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public double getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(double totalCost) {
        this.totalCost = totalCost;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return bookingId + "," + customerName + "," + vehicleId + ","
                + (startDate != null ? startDate.getTime() : "") + ","
                + (endDate != null ? endDate.getTime() : "") + ","
                + totalCost + "," + status;
    }
}