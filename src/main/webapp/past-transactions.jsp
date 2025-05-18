<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Past Transactions</title>
    <style>
        table {
            border-collapse: collapse;
            width: 80%;
            margin: auto;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #007BFF;
            color: white;
        }
    </style>
</head>
<body>
<h2 style="text-align: center;">Past Transactions</h2>
<table>
    <tr>
        <th>Invoice ID</th>
        <th>Date</th>
        <th>Amount ($)</th>
        <th>Status</th>
    </tr>
    <c:forEach var="txn" items="${transactions}">
        <tr>
            <td>${txn.id}</td>
            <td>${txn.date}</td>
            <td>${txn.amount}</td>
            <td>${txn.status}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
