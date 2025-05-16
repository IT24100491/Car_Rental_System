package servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        String role = request.getParameter("role");
        String email = request.getParameter("email"); // <-- NEW

        HttpSession session = request.getSession();

        // Validate fields
        if (username == null || password == null || confirmPassword == null || role == null || email == null ||
                username.isEmpty() || password.isEmpty() || confirmPassword.isEmpty() || role.isEmpty() || email.isEmpty()) {
            session.setAttribute("error", "Please fill in all fields.");
            response.sendRedirect("signup.html");
            return;
        }

        // Validate password match
        if (!password.equals(confirmPassword)) {
            session.setAttribute("error", "Passwords do not match.");
            response.sendRedirect("signup.html");
            return;
        }

        // Define path to users.txt
        String filePath = getServletContext().getRealPath("/WEB-INF/users.txt");
        File file = new File(filePath);

        // Check if username already exists
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(":");
                if (parts.length >= 1 && parts[0].equalsIgnoreCase(username)) {
                    session.setAttribute("error", "Username already exists.");
                    response.sendRedirect("signup.html");
                    return;
                }
            }
        }

        // Save user in username:password:role:email format
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
            String formatted = String.format("%s:%s:%s:%s", username, password, role.toLowerCase().replace(" ", "_"), email);
            writer.write(formatted);
            writer.newLine();
        } catch (IOException e) {
            session.setAttribute("error", "Error saving user. Please try again.");
            response.sendRedirect("signup.html");
            return;
        }

        session.setAttribute("success", "Registration successful! Please log in.");
        response.sendRedirect("login.html");
    }
}
