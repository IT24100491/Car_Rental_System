import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class SavePaymentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get payment details from the request
        String name = request.getParameter("cardHolder");
        String cardNumber = request.getParameter("cardNumber");
        String cardType = request.getParameter("cardType");
        String expiryDate = request.getParameter("expiryDate");
        String cvv = request.getParameter("cvv");

        // Get the path to WEB-INF/payments.txt
        String filePath = getServletContext().getRealPath("/WEB-INF/payments.txt");

        // Create the file if it doesn't exist
        File file = new File(filePath);
        file.getParentFile().mkdirs();
        file.createNewFile();

        // Format: Name:Card Number:Card Type:Expiry date:CVV number
        String line = name + ":" + cardNumber + ":" + cardType + ":" + expiryDate + ":" + cvv;

        // Append the line to the file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
            writer.write(line);
            writer.newLine();
        }

        // Optionally, redirect or send a success response
        response.setContentType("text/plain");
        response.getWriter().write("Payment method saved successfully!");
    }
}
