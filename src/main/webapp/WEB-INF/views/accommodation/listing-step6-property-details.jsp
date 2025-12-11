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
            background: #EFDFBB; /* Dutch White - CHANGED */
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
            color: #722F37; /* Wine - CHANGED */
            font-weight: bold;
            margin-bottom: 10px;
        }
        .form-container {
            background: #EFDFBB; /* Dutch White - CHANGED */
            border: 2px solid #722F37; /* Wine - CHANGED */
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 4px 15px rgba(114, 47, 55, 0.1); /* Wine with opacity - CHANGED */
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
            color: #722F37; /* Wine - CHANGED */
            font-weight: 500;
        }
        input[type="text"],
        input[type="number"],
        input[type="time"],
        select {
            width: 100%;
            padding: 12px;
            border: 2px solid #722F37; /* Wine - CHANGED */
            border-radius: 8px;
            font-size: 1rem;
            background: rgba(255, 255, 255, 0.9);
            color: #722F37; /* Wine - CHANGED */
        }
        input:focus, select:focus {
            outline: none;
            border-color: #5a2530; /* Darker Wine - CHANGED */
            box-shadow: 0 0 0 2px rgba(114, 47, 55, 0.2); /* Wine with opacity - CHANGED */
        }
        .star-rating {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }
        .star {
            font-size: 2rem;
            color: #d4c2a0; /* Light Dutch White - CHANGED */
            cursor: pointer;
            transition: transform 0.2s;
        }
        .star:hover {
            transform: scale(1.2);
        }
        .star.active {
            color: #FFD700; /* Keep gold for stars */
        }
        .cancellation-options {
            display: grid;
            gap: 15px;
            margin-top: 15px;
        }
        .cancellation-card {
            padding: 20px;
            border: 2px solid #722F37; /* Wine - CHANGED */
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
            background: #EFDFBB; /* Dutch White - CHANGED */
        }
        .cancellation-card:hover {
            border-color: #5a2530; /* Darker Wine - CHANGED */
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(114, 47, 55, 0.1); /* Wine with opacity - CHANGED */
        }
        .cancellation-card.selected {
            border-color: #5a2530; /* Darker Wine - CHANGED */
            background: rgba(114, 47, 55, 0.1); /* Wine with opacity - CHANGED */
        }
        .cancellation-card input[type="radio"] {
            display: none;
        }
        .badge {
            background: linear-gradient(135deg, #FFD700, #FFC300); /* Gold gradient - ENHANCED */
            color: #722F37; /* Wine - CHANGED */
            padding: 4px 10px;
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
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .btn-primary {
            background: #722F37; /* Wine - CHANGED */
            color: #EFDFBB; /* Dutch White - CHANGED */
            border: 2px solid #722F37; /* Wine - CHANGED */
        }
        .btn-primary:hover {
            background: #5a2530; /* Darker Wine - CHANGED */
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(114, 47, 55, 0.2); /* Wine with opacity - CHANGED */
        }
        .btn-secondary {
            background: #EFDFBB; /* Dutch White - CHANGED */
            color: #722F37; /* Wine - CHANGED */
            border: 2px solid #722F37; /* Wine - CHANGED */
        }
        .btn-secondary:hover {
            background: #722F37; /* Wine - CHANGED */
            color: #EFDFBB; /* Dutch White - CHANGED */
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(114, 47, 55, 0.2); /* Wine with opacity - CHANGED */
        }
        
        /* Progress Indicator (Optional - matches your other pages) */
        .progress-container {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
            position: relative;
        }
        .progress-steps {
            display: flex;
            align-items: center;
            gap: 8px;
            position: relative;
            z-index: 2;
        }
        .step {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background: #EFDFBB; /* Dutch White */
            border: 2px solid #722F37; /* Wine */
            color: #722F37; /* Wine */
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        .step.active {
            background: #722F37; /* Wine */
            color: #EFDFBB; /* Dutch White */
            transform: scale(1.1);
        }
        .step.completed {
            background: #722F37; /* Wine */
            color: #EFDFBB; /* Dutch White */
        }
        .step-line {
            position: absolute;
            top: 50%;
            left: 15%;
            right: 15%;
            height: 2px;
            background: #722F37; /* Wine */
            opacity: 0.3;
            transform: translateY(-50%);
            z-index: 1;
        }
        
        /* Icon colors */
        label i {
            color: #722F37; /* Wine - CHANGED */
        }
        
        /* Keep gold for star icons when active */
        .star.active i {
            color: #FFD700;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Optional Progress Indicator (matches your other pages) -->
        <div class="progress-container">
            <div class="step-line"></div>
            <div class="progress-steps">
                <div class="step completed">1</div>
                <div class="step completed">2</div>
                <div class="step completed">3</div>
                <div class="step completed">4</div>
                <div class="step completed">5</div>
                <div class="step active">6</div>
                <div class="step">7</div>
                <div class="step">8</div>
            </div>
        </div>
        
        <div class="step-header">
            <div class="step-indicator">🏡 STEP 6/8 — PROPERTY DETAILS</div>
            <h1><i class="fas fa-home"></i> Property Details</h1>
        </div>
        
        <form method="post" action="/pilgrim/accommodation/property/listing/step6" class="form-container">
            <div class="form-group">
                <label><i class="fas fa-sign"></i> Property Name</label>
                <input type="text" name="propertyName" required placeholder="Enter your property name">
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
                <a href="/pilgrim/accommodation/property/listing/step5" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back
                </a>
                <button type="submit" class="btn btn-primary">
                    Next Step <i class="fas fa-arrow-right"></i>
                </button>
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
        
        // Set default star rating
        document.querySelector('.star[data-rating="1"]').click();
        
        function selectCancellation(element) {
            document.querySelectorAll('.cancellation-card').forEach(card => {
                card.classList.remove('selected');
            });
            element.classList.add('selected');
            element.querySelector('input[type="radio"]').checked = true;
        }
        
        // Auto-select the recommended option after a delay (like your other pages)
        setTimeout(() => {
            const recommendedCard = document.querySelector('.cancellation-card .badge')?.closest('.cancellation-card');
            if (recommendedCard && !document.querySelector('.cancellation-card.selected')) {
                selectCancellation(recommendedCard);
            }
        }, 1000);
    </script>
</body>
</html>