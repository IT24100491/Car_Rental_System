package servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

@WebServlet("/invoice") // Use this OR web.xml config (not both)
public class InvoiceServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String invoiceId = request.getParameter("manual-id");
        String date = request.getParameter("manual-date");
        String amount = request.getParameter("manual-amount");
        String status = request.getParameter("manual-status");

        if (invoiceId == null || date == null || amount == null || status == null ||
                invoiceId.isEmpty() || date.isEmpty() || amount.isEmpty() || status.isEmpty()) {
            response.getWriter().println("Missing form data.");
            return;
        }

        // Save to file
        String filePath = "C:\\Users\\Dilini kannangara\\IdeaProjects\\PaymentBillingSystem\\src\\main\\webapp\\invoice.txt"; // Make sure this directory exists or is creatable
        File file = new File(filePath);
        file.getParentFile().mkdirs(); // Create directories if needed

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
            writer.write("Invoice ID: " + invoiceId);
            writer.newLine();
            writer.write("Date: " + date);
            writer.newLine();
            writer.write("Amount: " + amount);
            writer.newLine();
            writer.write("Status: " + status);
            writer.newLine();
            writer.write("-----------------------------");
            writer.newLine();

        }

        response.setContentType("text/plain");
        response.getWriter().println("Invoice saved successfully.");
    }
}

