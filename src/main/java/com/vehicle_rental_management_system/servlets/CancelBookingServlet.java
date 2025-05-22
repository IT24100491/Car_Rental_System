package com.vehicle_rental_management_system.servlets;

import com.vehicle_rental_management_system.utils.BookingUtil;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class CancelBookingServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));

        if (BookingUtil.cancelBooking(bookingId)) {
            response.sendRedirect("bookingManagement.jsp?message=Booking cancelled successfully");
        } else {
            response.sendRedirect("bookingManagement.jsp?error=Failed to cancel booking");
        }
    }
}