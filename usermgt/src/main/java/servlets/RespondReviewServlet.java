package servlets;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class RespondReviewServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int index = Integer.parseInt(request.getParameter("index"));
        String newResponse = request.getParameter("responseText").trim();

        String filePath = getServletContext().getRealPath("/WEB-INF/respond.txt");

        // Load existing responses
        List<String> responses = new ArrayList<>();
        File file = new File(filePath);

        if (file.exists()) {
            try (BufferedReader br = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = br.readLine()) != null) {
                    responses.add(line.trim());
                }
            }
        }

        // Ensure the list is large enough
        while (responses.size() <= index) {
            responses.add("");
        }

        // Update the response
        responses.set(index, newResponse);

        // Save back to the file
        try (PrintWriter pw = new PrintWriter(new BufferedWriter(new FileWriter(filePath)))) {
            for (String r : responses) {
                pw.println(r);
            }
        }

        response.sendRedirect("manageReviews.jsp");
    }
}
