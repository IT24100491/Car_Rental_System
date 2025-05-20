package com.vehicle_rental_management_system.servlets;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import com.vehicle_rental_management_system.model.Booking;
import com.vehicle_rental_management_system.utils.VehicleUtil;
import com.vehicle_rental_management_system.utils.BookingUtil;

@WebServlet("/add-rental")
public class AddBookingServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Parameter extraction and validation
            String vehicleId = request.getParameter("vehicleId");
            String customerId = request.getParameter("customerId");
            String startTimeStr = request.getParameter("startTime");
            String endTimeStr = request.getParameter("endTime");

            if (vehicleId == null || customerId == null ||
                    startTimeStr == null || endTimeStr == null) {
                throw new IllegalArgumentException("Missing parameters");
            }

            // Date parsing
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            LocalDateTime startTime = LocalDateTime.parse(startTimeStr, formatter);
            LocalDateTime endTime = LocalDateTime.parse(endTimeStr, formatter);

            if (startTime.isAfter(endTime)) {
                throw new IllegalArgumentException("End time must be after start time");
            }

            // Business logic
            boolean insurance = request.getParameter("insurance") != null;
            boolean gps = request.getParameter("gps") != null;

            VehicleUtil vehicleUtil = new VehicleUtil();
            double dailyRate = vehicleUtil.findVehicleById(vehicleId).getDailyRate();
            long days = java.time.Duration.between(startTime, endTime).toDays();
            double totalCost = days * dailyRate;

            if (insurance) totalCost += days * 10;
            if (gps) totalCost += days * 5;

            // Create and save booking
            Booking booking = new Booking(
                    null, vehicleId, customerId,
                    startTime, endTime, "active",
                    totalCost, insurance, gps
            );

            BookingUtil bookingUtil = new BookingUtil();
            boolean success = bookingUtil.addBooking(booking);

            if (success) {
                response.sendRedirect("rentalManagement.jsp?message=Rental+created+successfully");
            } else {
                response.sendRedirect("rentalManagement.jsp?error=Failed+to+create+rental");
            }

        } catch (DateTimeParseException e) {
            response.sendRedirect("rentalManagement.jsp?error=Invalid+date+format");
        } catch (NullPointerException e) {
            response.sendRedirect("rentalManagement.jsp?error=Vehicle+not+found");
        } catch (IllegalArgumentException e) {
            response.sendRedirect("rentalManagement.jsp?error=" + e.getMessage().replace(" ", "+"));
        } catch (Exception e) {
            response.sendRedirect("rentalManagement.jsp?error=Unexpected+error");
            e.printStackTrace(); // Log the error
        }
    }
}