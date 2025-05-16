<%@ page import="java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Reviews</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e6f0ff;
            color: #003366;
            padding: 30px;
        }

        h2 {
            color: #0059b3;
        }

        .review {
            background-color: #ffffff;
            border-left: 6px solid #3399ff;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }

        .rating {
            font-weight: bold;
            color: #ffaa00;
        }
    </style>
</head>
<body>
    <h2>Customers Reviews And Feed Backs</h2>

    <%
        String filePath = application.getRealPath("/WEB-INF/reviews.txt");
        File file = new File(filePath);

        if (file.exists()) {
            try (BufferedReader br = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = br.readLine()) != null) {
                    String message = line.trim();
                    String rating = br.readLine(); // read rating line
                    br.readLine(); // skip blank separator line
    %>
                    <div class="review">
                        <p><%= message %></p>
                        <p class="rating">Rating: <%= rating %> star(s)</p>
                    </div>
    <%
                }
            } catch (IOException e) {
    %>
            <p style="color: red;">Error reading reviews: <%= e.getMessage() %></p>
    <%
            }
        } else {
    %>
        <p>No reviews yet.</p>
    <%
        }
    %>
</body>
</html>
