<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Generate Invoice</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 40px;
            background-color: #f9f9f9;
        }
        form {
            background-color: #fff;
            padding: 25px;
            border-radius: 8px;
            max-width: 400px;
            margin: auto;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }
        input[type="text"],
        select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .btn {
            margin-top: 20px;
            padding: 12px;
            width: 100%;
            background-color: #007BFF;
            border: none;
            border-radius: 5px;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<form action="InvoiceServlet" method="post">
    <label for="invoice-id">Invoice ID</label>
    <input type="text" id="invoice-id" name="manual-id" placeholder="e.g., INV-2001" required>

    <label for="invoice-date">Date</label>
    <input type="text" id="invoice-date" name="manual-date" placeholder="e.g., 2025-05-09" required>

    <label for="invoice-amount">Amount ($)</label>
    <input type="text" id="invoice-amount" name="manual-amount" placeholder="e.g., $300.00" required>

    <label for="invoice-status">Status</label>
    <select id="invoice-status" name="manual-status" required>
        <option value="">-- Select Status --</option>
        <option value="Paid">Paid</option>
        <option value="Pending">Pending</option>
    </select>

    <button type="submit" class="btn">Generate Invoice</button>
</form>

</body>
</html>
