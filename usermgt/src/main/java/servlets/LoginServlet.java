package servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
            out.println("<script>alert('Please fill in all fields.'); window.location.href='login.jsp';</script>");
            return;
        }

        String filePath = getServletContext().getRealPath("/WEB-INF/users.txt");
        File file = new File(filePath);
        boolean found = false;
        String role = "";

        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;

            while ((line = br.readLine()) != null) {
                String[] credentials = line.split(":");

                // Now we expect username:password:role:email (4 elements)
                if (credentials.length == 4 &&
                        credentials[0].equals(username) &&
                        credentials[1].equals(password)) {
                    role = credentials[2].toLowerCase();
                    found = true;
                    break;
                }
            }
        } catch (IOException e) {
            out.println("<script>alert('Error accessing user database.'); window.location.href='login.jsp';</script>");
            return;
        }

        HttpSession session = request.getSession();

        if (found) {
            session.setAttribute("username", username);
            session.setAttribute("role", role);

            // Redirect based on role
            if (role.equals("admin")) {
                response.sendRedirect("login.jsp");
            } else if (role.equals("customer")) {
                response.sendRedirect("loggedin.html");
            } else {
                out.println("<script>alert('Unknown role.'); window.location.href='login.jsp';</script>");
            }
        } else {
            out.println("<script>alert('Incorrect username or password.'); window.history.back();</script>");
        }
    }
}
