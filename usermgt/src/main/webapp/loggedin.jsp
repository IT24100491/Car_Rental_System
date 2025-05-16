<%@ page import="java.util.*, java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Vehicle Rental System - Customer View</title>
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
        .user-status {
            background-color: #2ecc71;
            color: white;
            padding: 8px 15px;
            border-radius: 5px;
            margin-right: 20px;
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
        select {
            padding: 8px;
            margin-right: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
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
        }
        .availability {
            padding: 5px 10px;
            border-radius: 3px;
            font-size: 0.9em;
        }
        .available {
            background-color: #2ecc71;
            color: white;
        }
        .unavailable {
            background-color: #e74c3c;
            color: white;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Vehicle Rental System</h1>
        <div class="user-status">
            Logged in as: <%= session.getAttribute("username") != null ? session.getAttribute("username") : "Guest" %>
        </div>
    </div>

    <div class="container">
        <div class="filter-section">
            <h2>Filter Vehicles</h2>
            <form method="get" action="">
                <select name="priceSort" id="priceSort">
                    <option value="">Sort by Price</option>
                    <option value="asc">Low to High</option>
                    <option value="desc">High to Low</option>
                </select>
                <select name="availability" id="availability">
                    <option value="">All Availabilities</option>
                    <option value="Available">Available Only</option>
                    <option value="Not Available">Not Available</option>
                </select>
                <button type="submit" style="padding: 8px 15px; background: #2c3e50; color: white; border: none; border-radius: 4px; cursor: pointer;">Apply Filters</button>
            </form>
        </div>

        <div class="vehicles-grid">
            <%
                String filePath = application.getRealPath("/WEB-INF/vehicles.txt");
                List<String[]> vehicles = new ArrayList<>();
                
                try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        vehicles.add(line.split(":"));
                    }
                } catch (IOException e) {
                    out.print("<p style='color: red;'>Error reading vehicles data.</p>");
                }

                // Apply sorting if requested
                String priceSort = request.getParameter("priceSort");
                String availabilityFilter = request.getParameter("availability");

                if (priceSort != null && !priceSort.isEmpty()) {
                    Collections.sort(vehicles, (a, b) -> {
                        double priceA = Double.parseDouble(a[2]);
                        double priceB = Double.parseDouble(b[2]);
                        return priceSort.equals("asc") ? Double.compare(priceA, priceB) : Double.compare(priceB, priceA);
                    });
                }

                for (String[] vehicle : vehicles) {
                    if (availabilityFilter == null || availabilityFilter.isEmpty() || 
                        availabilityFilter.equals(vehicle[3])) {
            %>
                <div class="vehicle-card">
                    <h3><%= vehicle[0] %></h3>
                    <p>Type: <%= vehicle[1] %></p>
                    <p class="price">$<%= vehicle[2] %>/day</p>
                    <span class="availability <%= vehicle[3].equals("Available") ? "available" : "unavailable" %>">
                        <%= vehicle[3] %>
                    </span>
                </div>
            <%
                    }
                }
            %>
        </div>

        <div style="text-align: center; margin-top: 30px; margin-bottom: 30px;">
            <a href="feedback.jsp" class="feedback-btn">Provide Feedback</a>
        </div>
    </div>
</body>
</html>