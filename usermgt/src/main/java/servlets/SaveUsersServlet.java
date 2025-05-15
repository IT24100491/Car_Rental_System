package servlets;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

@WebServlet("/save-users")
public class SaveUsersServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String data = request.getReader().lines()
                .reduce("", (accumulator, line) -> accumulator + line + "\n");

        String filePath = getServletContext().getRealPath("/WEB-INF/users.txt");
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            writer.write(data.trim()); // write updated data
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("User data updated successfully.");
        } catch (IOException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Failed to update users.txt");
            e.printStackTrace();
        }
    }
}
