<%@ page import="java.util.*, java.io.*, java.text.SimpleDateFormat, java.util.TimeZone" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    sdf.setTimeZone(TimeZone.getTimeZone("UTC"));
    String currentTime = sdf.format(new Date());

    String currentUser = (String) session.getAttribute("username");
    if (currentUser == null) {
        currentUser = "Guest";
    }
%>
<html>
<head>
    <title>Vehicle List - Customer View</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        .header {
            background-color: #2c3e50;
            color: white;
            padding: 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .user-info {
            background-color: #2ecc71;
            color: white;
            padding: 8px 15px;
            border-radius: 5px;
            margin-right: 20px;
            white-space: pre-line;
        }
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 20px;
        }
        .filter-section {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .vehicles-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .vehicle-card {
            background: white;
            border-radius: 8px;
            padding: 15px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        select {
            padding: 8px;
            margin-right: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 200px;
        }
        .feedback-btn {
            background-color: #3498db;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin-top: 20px;
        }
        .feedback-btn:hover {
            background-color: #2980b9;
        }
        .price {
            color: #2ecc71;
            font-weight: bold;
            font-size: 1.2em;
        }
        .status-available {
            background-color: #2ecc71;
            color: white;
            padding: 5px 10px;
            border-radius: 3px;
            display: inline-block;
        }
        .status-unavailable {
            background-color: #e74c3c;
            color: white;
            padding: 5px 10px;
            border-radius: 3px;
            display: inline-block;
        }
        .apply-btn {
            padding: 8px 15px;
            background: #2c3e50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .apply-btn:hover {
            background: #34495e;
        }
        .error-message {
            color: #e74c3c;
            padding: 10px;
            margin: 10px 0;
            background: #fde8e8;
            border-radius: 4px;
        }
    </style>
</head>
<body>
<div class="header">
    <h1>Vehicle Rental System</h1>
    <div class="user-info">
        Current Date and Time (UTC): <%= currentTime %>
        <br>
        Logged in as: <%= currentUser %>
    </div>
</div>

<div class="container">
    <div class="filter-section">
        <h2>Filter Vehicles</h2>
        <form method="get">
            <div class="form-group">
                <label for="priceSort">Sort by Price:</label>
                <select name="priceSort" id="priceSort">
                    <option value="">No Sorting</option>
                    <option value="asc" <%= "asc".equals(request.getParameter("priceSort")) ? "selected" : "" %>>Low to High</option>
                    <option value="desc" <%= "desc".equals(request.getParameter("priceSort")) ? "selected" : "" %>>High to Low</option>
                </select>
            </div>
            <div class="form-group">
                <label for="availability">Filter by Availability:</label>
                <select name="availability" id="availability">
                    <option value="">All Vehicles</option>
                    <option value="true" <%= "true".equals(request.getParameter("availability")) ? "selected" : "" %>>Available Only</option>
                    <option value="false" <%= "false".equals(request.getParameter("availability")) ? "selected" : "" %>>Not Available</option>
                </select>
            </div>
            <button type="submit" class="apply-btn">Apply Filters</button>
        </form>
    </div>

    <div class="vehicles-grid">
        <%
            String filePath = application.getRealPath("/WEB-INF/vehicles.txt");
            List<String[]> vehicles = new ArrayList<>();

            try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
                String line;
                while ((line = br.readLine()) != null) {
                    String[] vehicleData = line.split(":");
                    if (vehicleData.length == 4) {
                        vehicles.add(vehicleData);
                    }
                }
            } catch (IOException e) {
        %>
        <div class="error-message">
            Error reading vehicle data: <%= e.getMessage() %>
        </div>
        <%
            }

            String priceSort = request.getParameter("priceSort");
            if (priceSort != null && !priceSort.isEmpty()) {
                try {
                    vehicles.sort((a, b) -> {
                        double priceA = Double.parseDouble(a[2].trim());
                        double priceB = Double.parseDouble(b[2].trim());
                        return priceSort.equals("asc") ? Double.compare(priceA, priceB) : Double.compare(priceB, priceA);
                    });
                } catch (NumberFormatException e) {
        %>
        <div class="error-message">
            Error sorting prices: Invalid price format
        </div>
        <%
                }
            }

            String availabilityFilter = request.getParameter("availability");

            for (String[] vehicle : vehicles) {
                try {
                    String status = vehicle[3].trim().toLowerCase();
                    boolean isAvailable = "true".equalsIgnoreCase(status);

                    if (availabilityFilter == null || availabilityFilter.isEmpty() || status.equals(availabilityFilter.toLowerCase())) {
        %>
        <div class="vehicle-card">
            <h3><%= vehicle[0] %></h3>
            <p>Type: <%= vehicle[1] %></p>
            <p class="price">$<%= vehicle[2] %>/day</p>
            <span class="<%= isAvailable ? "status-available" : "status-unavailable" %>">
                <%= isAvailable ? "Available" : "Not Available" %>
            </span>
        </div>
        <%
            }
        } catch (Exception e) {
        %>
        <div class="error-message">
            Error displaying vehicle information.
        </div>
        <%
                }
            }
        %>
    </div>

    <div style="text-align: center; margin-top: 30px; margin-bottom: 30px;">
        <a href="<%= request.getContextPath() %>/feedback.jsp" class="feedback-btn">Provide Feedback</a>
    </div>
</div>
</body>
</html>
