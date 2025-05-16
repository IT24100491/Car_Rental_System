package com.vehicle_rental_management_system.servlets;

import com.vehicle_rental_management_system.utils.BookingUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/view-rentals")
public class ViewBookingsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookingUtil bookingUtil = new BookingUtil();
        request.setAttribute("bookings", bookingUtil.readBookings());
        request.getRequestDispatcher("rentalManagement.jsp").forward(request, response);
    }
}