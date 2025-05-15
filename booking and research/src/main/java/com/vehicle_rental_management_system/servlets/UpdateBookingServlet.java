package com.vehicle_rental_management_system.servlets;

import com.vehicle_rental_management_system.model.Booking;
import com.vehicle_rental_management_system.utils.BookingUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/update-rental")
public class UpdateBookingServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookingId = request.getParameter("bookingId");
        String vehicleId = request.getParameter("vehicleId");
        String customerId = request.getParameter("customerId");
        String startTimeStr = request.getParameter("startTime");
        String endTimeStr = request.getParameter("endTime");
        String status = request.getParameter("status");

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
        LocalDateTime startTime = LocalDateTime.parse(startTimeStr, formatter);
        LocalDateTime endTime = LocalDateTime.parse(endTimeStr, formatter);

        BookingUtil bookingUtil = new BookingUtil();
        Booking existingBooking = bookingUtil.findBookingById(bookingId);

        if (existingBooking != null) {
            Booking updatedBooking = new Booking(
                    bookingId, vehicleId, customerId,
                    startTime, endTime, status,
                    existingBooking.getTotalCost(),
                    existingBooking.hasInsurance(),
                    existingBooking.hasGps()
            );

            boolean success = bookingUtil.updateBooking(updatedBooking);

            if (success) {
                response.sendRedirect("rentalManagement.jsp?message=Rental+updated+successfully");
            } else {
                response.sendRedirect("rentalManagement.jsp?error=Failed+to+update+rental");
            }
        } else {
            response.sendRedirect("rentalManagement.jsp?error=Rental+not+found");
        }
    }
}
