<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Review</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff;
            color: #003366;
            padding: 40px;
            display: flex;
            justify-content: center;
        }

        .review-container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 51, 102, 0.2);
            max-width: 500px;
            width: 100%;
        }

        .review-container h2 {
            color: #003366;
            margin-bottom: 20px;
        }

        textarea {
            width: 100%;
            height: 100px;
            border: 1px solid #99c2ff;
            border-radius: 8px;
            padding: 10px;
            resize: vertical;
            font-size: 14px;
            margin-bottom: 20px;
        }

        .stars {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .stars label {
            cursor: pointer;
            text-align: center;
            flex: 1;
            color: #666;
            font-size: 14px;
        }

        .stars input[type="radio"] {
            display: none;
        }

        .stars label span {
            display: block;
            font-size: 24px;
        }

        .stars input[type="radio"]:checked + label span {
            color: #007bff;
        }

        button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background-color: #005bb5;
        }
    </style>
</head>
<body>
<div class="review-container">
    <h2>Leave a Review</h2>
    <form action="SubmitReviewServlet" method="post">
        <textarea name="reviewText" placeholder="Write your review here..."></textarea>

        <div class="stars">
            <input type="radio" id="star1" name="rating" value="1">
            <label for="star1"><span>★</span><div>Bad</div></label>

            <input type="radio" id="star2" name="rating" value="2">
            <label for="star2"><span>★★</span><div>Poor</div></label>

            <input type="radio" id="star3" name="rating" value="3">
            <label for="star3"><span>★★★</span><div>Okay</div></label>

            <input type="radio" id="star4" name="rating" value="4">
            <label for="star4"><span>★★★★</span><div>Good</div></label>

            <input type="radio" id="star5" name="rating" value="5">
            <label for="star5"><span>★★★★★</span><div>Excellent</div></label>
        </div>

        <button type="submit">Send Review</button>
    </form>
</div>
</body>
</html>
