package servlets;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class SubmitReviewServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get review text and rating from the form
        String reviewText = request.getParameter("reviewText");
        String rating = request.getParameter("rating");

        // Resolve the path to WEB-INF/reviews.txt
        String filePath = getServletContext().getRealPath("/WEB-INF/reviews.txt");

        // Save review to the file
        try (FileWriter fw = new FileWriter(filePath, true);
             BufferedWriter bw = new BufferedWriter(fw);
             PrintWriter outFile = new PrintWriter(bw)) {

            outFile.println(reviewText.trim());
            outFile.println(rating);
            outFile.println(); // Blank line to separate entries
        }

        // Redirect to loggedin.jsp after submission
        response.sendRedirect("loggedin.jsp");
    }
}
