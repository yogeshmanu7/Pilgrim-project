<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Property Type - GlobalPiligrim Accommodation</title>
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
            max-width: 1200px;
            margin: 0 auto;
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 50px;
            font-size: 2.5rem;
        }
        .property-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }
        .property-card {
            background: white;
            border-radius: 12px;
            padding: 30px;
            text-align: left;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            border: 2px solid #e0e0e0;
            position: relative;
        }
        .property-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            border-color: #667eea;
        }
        .property-card.selected {
            border-color: #667eea;
            border-width: 3px;
            background: #f8f9ff;
        }
        .property-card input[type="radio"] {
            position: absolute;
            top: 15px;
            right: 15px;
            width: 20px;
            height: 20px;
            cursor: pointer;
        }
        .property-card .icon-container {
            margin-bottom: 20px;
        }
        .property-card i {
            font-size: 3.5rem;
            color: #667eea;
        }
        .property-card h2 {
            color: #333;
            margin-bottom: 12px;
            font-size: 1.5rem;
            font-weight: 600;
        }
        .property-card p {
            color: #666;
            line-height: 1.7;
            font-size: 0.95rem;
            margin: 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1><i class="fas fa-question-circle"></i> What type of property are you listing?</h1>
        
        <form method="post" action="/pilgrim/accommodation/property/select-type" id="propertyTypeForm">
            <div class="property-cards">
                <div class="property-card" onclick="selectType('HOME_TYPE')">
                    <input type="radio" name="propertyType" value="HOME_TYPE" id="homeType">
                    <div class="icon-container">
                        <i class="fas fa-home"></i>
                    </div>
                    <h2>Home-type property</h2>
                    <p>Standalone units rented as a whole, such as individual apartments/flats, single bungalows, villas, and guest houses. They offer a residential experience for travelers seeking privacy and self-sufficient stays.</p>
                </div>
                
                <div class="property-card" onclick="selectType('HOTEL_TYPE')">
                    <input type="radio" name="propertyType" value="HOTEL_TYPE" id="hotelType">
                    <div class="icon-container">
                        <i class="fas fa-hotel"></i>
                    </div>
                    <h2>Hotel-type property</h2>
                    <p>Multiple rented units within one location, such as hotels, motels, serviced apartments, or resorts. They offer shared facilities, standard traveler amenities and services, and a front desk staff.</p>
                </div>
                
                <div class="property-card" onclick="selectType('UNIQUE_TYPE')">
                    <input type="radio" name="propertyType" value="UNIQUE_TYPE" id="uniqueType">
                    <div class="icon-container">
                        <i class="fas fa-campground"></i>
                    </div>
                    <h2>Unique-type property</h2>
                    <p>Special accommodations such as holiday/caravan parks, houseboats, farm stays, or castles. They appeal to travelers seeking distinctive accommodation experiences that often include related activities.</p>
                </div>
            </div>
            
            <div style="display: flex; justify-content: space-between; margin-top: 40px; padding: 0 20px;">
                <button type="button" onclick="window.history.back()" style="padding: 12px 30px; background: #f5f5f5; color: #333; border: none; border-radius: 8px; font-size: 1rem; cursor: pointer;">
                    Back
                </button>
                <button type="submit" style="padding: 12px 30px; background: #667eea; color: white; border: none; border-radius: 8px; font-size: 1rem; cursor: pointer; font-weight: 500;">
                    Next
                </button>
            </div>
        </form>
    </div>
    
    <script>
        function selectType(type) {
            // Uncheck all radios
            document.querySelectorAll('input[name="propertyType"]').forEach(radio => {
                radio.checked = false;
            });
            
            // Check selected radio
            document.querySelector('input[value="' + type + '"]').checked = true;
            
            // Update visual selection
            document.querySelectorAll('.property-card').forEach(card => {
                card.classList.remove('selected');
            });
            
            const selectedCard = document.querySelector('input[value="' + type + '"]').closest('.property-card');
            if (selectedCard) {
                selectedCard.classList.add('selected');
            }
        }
        
        // Form validation
        document.getElementById('propertyTypeForm').addEventListener('submit', function(e) {
            const selected = document.querySelector('input[name="propertyType"]:checked');
            if (!selected) {
                e.preventDefault();
                alert('Please select a property type before continuing');
                return false;
            }
        });
        
        // Initialize selection on page load if any is already selected
        document.querySelectorAll('input[name="propertyType"]').forEach(radio => {
            if (radio.checked) {
                selectType(radio.value);
            }
        });
    </script>
</body>
</html>

