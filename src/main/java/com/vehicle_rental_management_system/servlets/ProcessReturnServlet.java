package com.vehicle_rental_management_system.servlets;

import com.vehicle_rental_management_system.utils.BookingUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/process-return")
public class ProcessReturnServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookingId = request.getParameter("bookingId");

        BookingUtil bookingUtil = new BookingUtil();
        boolean success = bookingUtil.processReturn(bookingId);

        if (success) {
            response.sendRedirect("rentalManagement.jsp?message=Vehicle+return+processed+successfully");
        } else {
            response.sendRedirect("rentalManagement.jsp?error=Failed+to+process+vehicle+return");
        }
    }
}
