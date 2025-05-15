package servlets;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.JSONObject;

import java.io.*;

@WebServlet("/getProfile")
public class ProfileServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String username = (String) session.getAttribute("username");

        // Use WEB-INF with proper case
        String filePath = getServletContext().getRealPath("/WEB-INF/users.txt");
        File file = new File(filePath);

        if (!file.exists()) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("users.txt not found");
            return;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;

            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(":");
                if (parts.length == 4 && parts[0].equals(username)) {
                    JSONObject json = new JSONObject();
                    json.put("username", parts[0]);
                    json.put("role", parts[2]);
                    json.put("email", parts[3]);

                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(json.toString());
                    return;
                }
            }
        }

        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        response.getWriter().write("User not found");
    }
}
