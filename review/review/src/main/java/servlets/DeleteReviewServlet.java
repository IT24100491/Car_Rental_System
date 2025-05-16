package servlets;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class DeleteReviewServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int indexToDelete = Integer.parseInt(request.getParameter("index"));
        String filePath = getServletContext().getRealPath("/WEB-INF/reviews.txt");

        List<String> lines = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = br.readLine()) != null) {
                lines.add(line);
            }
        }

        // Each review is 3 lines: message, rating, blank
        int start = indexToDelete * 3;
        if (start + 2 < lines.size()) {
            lines.subList(start, start + 3).clear();
        }

        try (PrintWriter pw = new PrintWriter(new BufferedWriter(new FileWriter(filePath)))) {
            for (String line : lines) {
                pw.println(line);
            }
        }

        // Redirect back to the review management page
        response.sendRedirect("manageReviews.jsp");
    }
}
