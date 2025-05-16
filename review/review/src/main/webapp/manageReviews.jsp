<%@ page import="java.io.*" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage User Reviews</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #eef6ff;
            color: #003366;
            padding: 20px;
        }

        .review {
            background-color: #ffffff;
            border: 1px solid #99ccff;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
        }

        .rating {
            font-weight: bold;
            color: #ffaa00;
        }

        .delete-btn, .respond-btn {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 6px 12px;
            cursor: pointer;
            border-radius: 4px;
            margin-top: 5px;
        }

        .delete-btn {
            background-color: #ff4d4d;
        }

        textarea {
            width: 100%;
            height: 60px;
            resize: none;
            margin-top: 5px;
        }

        .response {
            margin-top: 10px;
            font-style: italic;
            color: #006600;
            background-color: #f4fff4;
            padding: 8px;
            border-radius: 4px;
        }
    </style>
</head>
<body>
<h2>Manage Reviews</h2>

<%
    String reviewPath = application.getRealPath("/WEB-INF/reviews.txt");
    String responsePath = application.getRealPath("/WEB-INF/respond.txt");

    File reviewFile = new File(reviewPath);
    File responseFile = new File(responsePath);

    List<String> responses = new ArrayList<>();

    if (responseFile.exists()) {
        try (BufferedReader rb = new BufferedReader(new FileReader(responseFile))) {
            String line;
            while ((line = rb.readLine()) != null) {
                responses.add(line.trim());
            }
        }
    }

    if (reviewFile.exists()) {
        try (BufferedReader br = new BufferedReader(new FileReader(reviewFile))) {
            String line;
            int index = 0;

            while ((line = br.readLine()) != null) {
                String message = line.trim();
                String rating = br.readLine(); // star rating
                br.readLine(); // skip blank line

                String responseMsg = (index < responses.size()) ? responses.get(index) : "";
%>
<div class="review">
    <p><strong>Review:</strong> <%= message %></p>
    <p class="rating">Rating: <%= rating %> star(s)</p>

    <% if (!responseMsg.isEmpty()) { %>
    <div class="response">
        <strong>Response:</strong> <%= responseMsg %>
    </div>
    <% } %>

    <!-- Delete form -->
    <form method="post" action="DeleteReviewServlet">
        <input type="hidden" name="index" value="<%= index %>">
        <button type="submit" class="delete-btn">Delete</button>
    </form>

    <!-- Respond form -->
    <form method="post" action="RespondReviewServlet">
        <input type="hidden" name="index" value="<%= index %>">
        <label for="responseText<%= index %>">Response:</label><br>
        <textarea id="responseText<%= index %>" name="responseText" placeholder="Write your response..."></textarea><br>
        <button type="submit" class="respond-btn">Respond</button>
    </form>
</div>
<%
        index++;
    }
} catch (IOException e) {
%>
<p style="color:red;">Error reading reviews: <%= e.getMessage() %></p>
<%
    }
} else {
%>
<p>No reviews found.</p>
<%
    }
%>

</body>
</html>
