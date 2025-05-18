// PastTransactionsServlet.java
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class PastTransactionsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String filePath = "C:\\Users\\Dilini kannangara\\IdeaProjects\\PaymentBillingSystem\\src\\main\\webapp\\invoice.txt";
        List<Map<String, String>> transactions = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            Map<String, String> invoice = new HashMap<>();

            while ((line = reader.readLine()) != null) {
                if (line.startsWith("Invoice ID:")) {
                    invoice = new HashMap<>();
                    invoice.put("id", line.split(": ")[1].trim());
                } else if (line.startsWith("Date:")) {
                    invoice.put("date", line.split(": ")[1].trim());
                } else if (line.startsWith("Amount:")) {
                    invoice.put("amount", line.split(": ")[1].trim());
                } else if (line.startsWith("Status:")) {
                    invoice.put("status", line.split(": ")[1].trim());
                } else if (line.contains("----")) {
                    transactions.add(invoice);
                }
            }
        }

        request.setAttribute("transactions", transactions);
        RequestDispatcher dispatcher = request.getRequestDispatcher("past-transactions.jsp");
        dispatcher.forward(request, response);
    }
}
