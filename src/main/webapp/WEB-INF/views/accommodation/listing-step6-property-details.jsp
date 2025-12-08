<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Step 6/8 - Property Details - GlobalPiligrim Accommodation</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
            padding: 40px 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
        }
        .step-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .step-indicator {
            color: #667eea;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .form-container {
            background: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
        }
        input[type="text"],
        input[type="number"],
        input[type="time"],
        select {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
        }
        input:focus, select:focus {
            outline: none;
            border-color: #667eea;
        }
        .star-rating {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }
        .star {
            font-size: 2rem;
            color: #ddd;
            cursor: pointer;
        }
        .star.active {
            color: #ffd700;
        }
        .cancellation-options {
            display: grid;
            gap: 15px;
            margin-top: 15px;
        }
        .cancellation-card {
            padding: 20px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
        }
        .cancellation-card:hover {
            border-color: #667eea;
        }
        .cancellation-card.selected {
            border-color: #667eea;
            background: #f0f4ff;
        }
        .cancellation-card input[type="radio"] {
            display: none;
        }
        .badge {
            background: #ffd700;
            color: #333;
            padding: 3px 8px;
            border-radius: 5px;
            font-size: 0.8rem;
            font-weight: bold;
            margin-left: 10px;
        }
        .btn-group {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            cursor: pointer;
        }
        .btn-primary {
            background: #667eea;
            color: white;
        }
        .btn-secondary {
            background: #e0e0e0;
            color: #333;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="step-header">
            <div class="step-indicator">🏡 STEP 6/8 — PROPERTY DETAILS</div>
            <h1><i class="fas fa-home"></i> Property Details</h1>
        </div>
        
        <form method="post" action="/pilgrim/accommodation/property/listing/step6" class="form-container">
            <div class="form-group">
                <label><i class="fas fa-sign"></i> Property Name</label>
                <input type="text" name="propertyName" required>
            </div>
            
            <div class="form-group">
                <label><i class="fas fa-star"></i> Star Rating</label>
                <div class="star-rating" id="starRating">
                    <span class="star" data-rating="1"><i class="fas fa-star"></i></span>
                    <span class="star" data-rating="2"><i class="fas fa-star"></i></span>
                    <span class="star" data-rating="3"><i class="fas fa-star"></i></span>
                    <span class="star" data-rating="4"><i class="fas fa-star"></i></span>
                    <span class="star" data-rating="5"><i class="fas fa-star"></i></span>
                </div>
                <input type="hidden" name="starRating" id="starRatingValue" value="1" required>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label><i class="fas fa-clock"></i> Check-in Time (From)</label>
                    <input type="time" name="checkInTimeFrom" required>
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-clock"></i> Check-in Time (To)</label>
                    <input type="time" name="checkInTimeTo" required>
                </div>
            </div>
            
            <div class="form-group">
                <label><i class="fas fa-clock"></i> Check-out Time</label>
                <input type="time" name="checkOutTime" required>
            </div>
            
            <div class="form-group">
                <label><i class="fas fa-ban"></i> Cancellation Policy</label>
                <div class="cancellation-options">
                    <label class="cancellation-card" onclick="selectCancellation(this)">
                        <input type="radio" name="cancellationPolicy" value="FREE_CANCELLATION_1_DAY_BEFORE">
                        <strong>Free cancellation 1 day before</strong>
                    </label>
                    
                    <label class="cancellation-card" onclick="selectCancellation(this)">
                        <input type="radio" name="cancellationPolicy" value="REFUNDABLE_UP_TO_3_DAYS_BEFORE">
                        <strong>Refundable up to 3 days before</strong>
                    </label>
                    
                    <label class="cancellation-card" onclick="selectCancellation(this)">
                        <input type="radio" name="cancellationPolicy" value="NON_REFUNDABLE">
                        <strong>Non-refundable</strong>
                        <span class="badge">Most Popular</span>
                    </label>
                </div>
            </div>
            
            <div class="btn-group">
                <a href="/pilgrim/accommodation/property/listing/step5" class="btn btn-secondary">Back</a>
                <button type="submit" class="btn btn-primary">Next Step <i class="fas fa-arrow-right"></i></button>
            </div>
        </form>
    </div>
    
    <script>
        document.querySelectorAll('.star').forEach(star => {
            star.addEventListener('click', function() {
                const rating = parseInt(this.dataset.rating);
                document.getElementById('starRatingValue').value = rating;
                document.querySelectorAll('.star').forEach((s, index) => {
                    if (index < rating) {
                        s.classList.add('active');
                    } else {
                        s.classList.remove('active');
                    }
                });
            });
        });
        
        function selectCancellation(element) {
            document.querySelectorAll('.cancellation-card').forEach(card => {
                card.classList.remove('selected');
            });
            element.classList.add('selected');
            element.querySelector('input[type="radio"]').checked = true;
        }
    </script>
</body>
</html>

