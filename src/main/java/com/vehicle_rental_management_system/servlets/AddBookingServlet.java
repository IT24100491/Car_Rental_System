package com.vehicle_rental_management_system.servlets;

import com.vehicle_rental_management_system.model.Booking;
import com.vehicle_rental_management_system.utils.BookingUtil;
import com.vehicle_rental_management_system.utils.VehicleUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/add-rental")
public class AddBookingServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String vehicleId = request.getParameter("vehicleId");
        String customerId = request.getParameter("customerId");
        String startTimeStr = request.getParameter("startTime");
        String endTimeStr = request.getParameter("endTime");
        boolean insurance = request.getParameter("insurance") != null;
        boolean gps = request.getParameter("gps") != null;

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
        LocalDateTime startTime = LocalDateTime.parse(startTimeStr, formatter);
        LocalDateTime endTime = LocalDateTime.parse(endTimeStr, formatter);

        // Calculate total cost (simplified - in real app you'd calculate based on days and options)
        VehicleUtil vehicleUtil = new VehicleUtil();
        double dailyRate = vehicleUtil.findVehicleById(vehicleId).getDailyRate();
        long days = java.time.Duration.between(startTime, endTime).toDays();
        double totalCost = days * dailyRate;
        if (insurance) totalCost += days * 10;
        if (gps) totalCost += days * 5;

        Booking booking = new Booking(null, vehicleId, customerId,
                startTime, endTime, "active", totalCost, insurance, gps);

        BookingUtil bookingUtil = new BookingUtil();
        boolean success = bookingUtil.addBooking(booking);

        if (success) {
            response.sendRedirect("rentalManagement.jsp?message=Rental+created+successfully");
        } else {
            response.sendRedirect("rentalManagement.jsp?error=Failed+to+create+rental");
        }
    }
}