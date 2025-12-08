<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Unit Selection - GlobalPiligrim Accommodation</title>
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
            max-width: 900px;
            margin: 0 auto;
        }
        h1 {
            color: #333;
            margin-bottom: 40px;
            font-size: 1.8rem;
            font-weight: 600;
        }
        .unit-options {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .unit-card {
            background: #f5f5f5;
            border-radius: 12px;
            padding: 0;
            cursor: pointer;
            transition: all 0.3s;
            border: 2px solid transparent;
            overflow: hidden;
        }
        .unit-card:hover {
            border-color: #667eea;
        }
        .unit-card.selected {
            border-color: #667eea;
            border-width: 3px;
        }
        .unit-card input[type="radio"] {
            position: absolute;
            top: 15px;
            right: 15px;
            width: 20px;
            height: 20px;
            cursor: pointer;
            z-index: 10;
        }
        .unit-card .icon-area {
            background: #e3f2fd;
            padding: 30px;
            text-align: center;
            position: relative;
        }
        .unit-card.selected .icon-area {
            background: #bbdefb;
        }
        .unit-card .icon-wrapper {
            display: inline-block;
            position: relative;
        }
        .unit-card .pin-icon {
            font-size: 2rem;
            color: #333;
            margin-bottom: 10px;
        }
        .unit-card .house-icon {
            font-size: 1.5rem;
            color: #333;
        }
        .unit-card .houses-icon {
            display: flex;
            gap: 8px;
            justify-content: center;
        }
        .unit-card .content {
            padding: 25px;
            background: white;
        }
        .unit-card h2 {
            color: #333;
            margin-bottom: 12px;
            font-size: 1.2rem;
            font-weight: 600;
        }
        .unit-card p {
            color: #666;
            font-size: 0.95rem;
            line-height: 1.6;
        }
        .additional-link {
            text-align: center;
            margin: 30px 0;
        }
        .additional-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .tip-box {
            background: #e3f2fd;
            border-radius: 12px;
            padding: 20px;
            margin-top: 30px;
            display: flex;
            align-items: flex-start;
            gap: 15px;
        }
        .tip-box .icon {
            color: #667eea;
            font-size: 1.5rem;
            flex-shrink: 0;
        }
        .tip-box .content {
            flex: 1;
        }
        .tip-box strong {
            color: #333;
            font-weight: 600;
        }
        .tip-box p {
            color: #666;
            margin-top: 5px;
            font-size: 0.95rem;
            line-height: 1.6;
        }
        .btn-group {
            display: flex;
            justify-content: space-between;
            margin-top: 40px;
            padding: 0 20px;
        }
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            cursor: pointer;
            font-weight: 500;
        }
        .btn-back {
            background: #f5f5f5;
            color: #333;
        }
        .btn-next {
            background: #667eea;
            color: white;
        }
        .error-message {
            background: #ffebee;
            color: #c62828;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>How many units do you want to list?</h1>
        
        <c:if test="${not empty error}">
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>
        
        <form method="post" action="/pilgrim/accommodation/property/select-units" id="unitForm">
            <div class="unit-options">
                <div class="unit-card" onclick="selectUnit('ONE_UNIT')">
                    <input type="radio" name="unitSelection" value="ONE_UNIT" id="oneUnit">
                    <div class="icon-area">
                        <div class="icon-wrapper">
                            <div class="pin-icon"><i class="fas fa-map-marker-alt"></i></div>
                            <div class="house-icon"><i class="fas fa-home"></i></div>
                        </div>
                    </div>
                    <div class="content">
                        <h2>One unit</h2>
                        <p>You have one rentable unit, which can only be rented in its entirety.</p>
                    </div>
                </div>
                
                <div class="unit-card" onclick="selectUnit('MULTIPLE_UNITS_SAME_LOCATION')">
                    <input type="radio" name="unitSelection" value="MULTIPLE_UNITS_SAME_LOCATION" id="multipleUnits">
                    <div class="icon-area">
                        <div class="icon-wrapper">
                            <div class="pin-icon"><i class="fas fa-map-marker-alt"></i></div>
                            <div class="houses-icon">
                                <i class="fas fa-home"></i>
                                <i class="fas fa-home"></i>
                                <i class="fas fa-home"></i>
                            </div>
                        </div>
                    </div>
                    <div class="content">
                        <h2>Multiple units (at the same location)</h2>
                        <p>You have multiple rentable units, which are located at the same street address or complex, such as a gated community or large resort.</p>
                    </div>
                </div>
            </div>
            
            <div class="additional-link">
                <a href="#"><i class="fas fa-question-circle"></i> Have properties in different locations?</a>
            </div>
            
            <div class="tip-box">
                <div class="icon"><i class="fas fa-lightbulb"></i></div>
                <div class="content">
                    <strong>Tip:</strong>
                    <p>Please ensure you provide accurate information as much as possible — this helps us guide you better and maximize the benefits of partnering with us.</p>
                </div>
            </div>
            
            <div class="btn-group">
                <button type="button" class="btn btn-back" onclick="window.history.back()">Back</button>
                <button type="submit" class="btn btn-next">Next</button>
            </div>
        </form>
    </div>
    
    <script>
        function selectUnit(type) {
            // Uncheck all radios
            document.querySelectorAll('input[name="unitSelection"]').forEach(radio => {
                radio.checked = false;
            });
            
            // Check selected radio
            document.querySelector('input[value="' + type + '"]').checked = true;
            
            // Update visual selection
            document.querySelectorAll('.unit-card').forEach(card => {
                card.classList.remove('selected');
            });
            
            const selectedCard = document.querySelector('input[value="' + type + '"]').closest('.unit-card');
            if (selectedCard) {
                selectedCard.classList.add('selected');
            }
        }
        
        // Form validation
        document.getElementById('unitForm').addEventListener('submit', function(e) {
            const selected = document.querySelector('input[name="unitSelection"]:checked');
            if (!selected) {
                e.preventDefault();
                alert('Please select an option before continuing');
                return false;
            }
        });
        
        // Initialize selection on page load if any is already selected
        document.querySelectorAll('input[name="unitSelection"]').forEach(radio => {
            if (radio.checked) {
                selectUnit(radio.value);
            }
        });
    </script>
</body>
</html>

