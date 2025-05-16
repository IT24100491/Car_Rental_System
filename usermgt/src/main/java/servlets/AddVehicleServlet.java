package servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

@WebServlet("/AddVehicleServlet")
public class AddVehicleServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String model = request.getParameter("vehicleModel");
        String type = request.getParameter("vehicleType");
        String availability = request.getParameter("vehicleAvailability");
        String pricing = request.getParameter("vehiclePricing");

        HttpSession session = request.getSession();

        // Validation
        if (model == null || type == null || availability == null || pricing == null ||
            model.isEmpty() || type.isEmpty() || availability.isEmpty() || pricing.isEmpty()) {
            session.setAttribute("vehicleError", "Please fill in all vehicle fields.");
            response.sendRedirect("vehicles.html");
            return;
        }

        // Define file path
        String filePath = getServletContext().getRealPath("/WEB-INF/vehicles.txt");
        File file = new File(filePath);

        // Save vehicle
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
            String formatted = String.format("%s:%s:%s:%s", model, type, availability, pricing);
            writer.write(formatted);
            writer.newLine();
        } catch (IOException e) {
            session.setAttribute("vehicleError", "Error saving vehicle. Please try again.");
            response.sendRedirect("vehicles.html");
            return;
        }

        session.setAttribute("vehicleSuccess", "Vehicle added successfully!");
        response.sendRedirect("vehicles.html");
    }
}
