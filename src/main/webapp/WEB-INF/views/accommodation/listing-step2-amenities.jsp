<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Step 2/8 - Amenities - GlobalPiligrim Accommodation</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Poppins', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
            display: flex;
            min-height: 100vh;
        }
        .sidebar {
            width: 280px;
            background: white;
            border-right: 1px solid #e0e0e0;
            padding: 30px 20px;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
        }
        .sidebar h3 {
            color: #333;
            font-size: 1.1rem;
            margin-bottom: 30px;
            font-weight: 600;
        }
        .step-list {
            list-style: none;
        }
        .step-item {
            display: flex;
            align-items: center;
            padding: 15px 10px;
            margin-bottom: 5px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
        }
        .step-item:hover {
            background: #f5f5f5;
        }
        .step-item.active {
            background: #e3f2fd;
            color: #667eea;
        }
        .step-number {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background: #e0e0e0;
            color: #666;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            margin-right: 15px;
            font-size: 0.9rem;
        }
        .step-item.active .step-number {
            background: #667eea;
            color: white;
        }
        .step-item.completed .step-number {
            background: #4caf50;
            color: white;
        }
        .step-name {
            font-size: 0.95rem;
            color: #333;
        }
        .step-item.active .step-name {
            color: #667eea;
            font-weight: 600;
        }
        .main-content {
            margin-left: 280px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        .content-header {
            background: white;
            padding: 30px 40px;
            border-bottom: 1px solid #e0e0e0;
        }
        .step-indicator {
            color: #667eea;
            font-size: 0.9rem;
            font-weight: 600;
            margin-bottom: 10px;
        }
        .content-header h1 {
            color: #333;
            font-size: 2rem;
            font-weight: 600;
        }
        .save-exit {
            position: absolute;
            top: 30px;
            right: 40px;
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
        }
        .content-body {
            flex: 1;
            padding: 40px;
            background: white;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
        }
        .footer-nav {
            background: white;
            padding: 20px 40px;
            border-top: 1px solid #e0e0e0;
            display: flex;
            justify-content: space-between;
        }
        .form-container {
            background: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .amenities-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
        }
        .amenity-item {
            padding: 20px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
            text-align: center;
        }
        .amenity-item:hover {
            border-color: #667eea;
            background: #f0f4ff;
        }
        .amenity-item input[type="checkbox"] {
            display: none;
        }
        .amenity-item.selected {
            border-color: #667eea;
            background: #667eea;
            color: white;
        }
        .amenity-item i {
            font-size: 2rem;
            margin-bottom: 10px;
            display: block;
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
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
            text-decoration: none;
            display: inline-block;
        }
        .btn-next {
            background: #667eea;
            color: white;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <h3>List your property</h3>
        <ul class="step-list">
            <li class="step-item completed">
                <div class="step-number">1</div>
                <div class="step-name">Location</div>
            </li>
            <li class="step-item active">
                <div class="step-number">2</div>
                <div class="step-name">Amenities</div>
            </li>
            <li class="step-item">
                <div class="step-number">3</div>
                <div class="step-name">Rooms</div>
            </li>
            <li class="step-item">
                <div class="step-number">4</div>
                <div class="step-name">Pricing</div>
            </li>
            <li class="step-item">
                <div class="step-number">5</div>
                <div class="step-name">Photos</div>
            </li>
            <li class="step-item">
                <div class="step-number">6</div>
                <div class="step-name">Details</div>
            </li>
            <li class="step-item">
                <div class="step-number">7</div>
                <div class="step-name">Profile</div>
            </li>
            <li class="step-item">
                <div class="step-number">8</div>
                <div class="step-name">Publish</div>
            </li>
        </ul>
    </div>
    
    <div class="main-content">
        <div class="content-header" style="position: relative;">
            <a href="/pilgrim/accommodation/property/drafts" class="save-exit">Save & exit</a>
            <div class="step-indicator">Step 2/8</div>
            <h1>Amenities</h1>
        </div>
        
        <div class="content-body">
            <form method="post" action="/pilgrim/accommodation/property/listing/step2" id="amenitiesForm" class="form-container">
            <div class="amenities-grid">
                <label class="amenity-item" onclick="toggleAmenity(this)">
                    <input type="checkbox" name="amenities" value="SWIMMING_POOL">
                    <i class="fas fa-swimming-pool"></i>
                    <div>Swimming Pool</div>
                </label>
                
                <label class="amenity-item" onclick="toggleAmenity(this)">
                    <input type="checkbox" name="amenities" value="CAR_PARK">
                    <i class="fas fa-parking"></i>
                    <div>Car Park</div>
                </label>
                
                <label class="amenity-item" onclick="toggleAmenity(this)">
                    <input type="checkbox" name="amenities" value="SAUNA">
                    <i class="fas fa-hot-tub"></i>
                    <div>Sauna</div>
                </label>
                
                <label class="amenity-item" onclick="toggleAmenity(this)">
                    <input type="checkbox" name="amenities" value="SPA">
                    <i class="fas fa-spa"></i>
                    <div>Spa</div>
                </label>
                
                <label class="amenity-item" onclick="toggleAmenity(this)">
                    <input type="checkbox" name="amenities" value="NON_SMOKING">
                    <i class="fas fa-ban"></i>
                    <div>Non-smoking</div>
                </label>
                
                <label class="amenity-item" onclick="toggleAmenity(this)">
                    <input type="checkbox" name="amenities" value="FREE_WIFI">
                    <i class="fas fa-wifi"></i>
                    <div>Free Wi-Fi</div>
                </label>
                
                <label class="amenity-item" onclick="toggleAmenity(this)">
                    <input type="checkbox" name="amenities" value="AIRPORT_TRANSFER">
                    <i class="fas fa-plane"></i>
                    <div>Airport Transfer</div>
                </label>
                
                <label class="amenity-item" onclick="toggleAmenity(this)">
                    <input type="checkbox" name="amenities" value="PETS_ALLOWED">
                    <i class="fas fa-paw"></i>
                    <div>Pets Allowed</div>
                </label>
                
                <label class="amenity-item" onclick="toggleAmenity(this)">
                    <input type="checkbox" name="amenities" value="FITNESS_CENTER">
                    <i class="fas fa-dumbbell"></i>
                    <div>Fitness Center</div>
                </label>
                
                <label class="amenity-item" onclick="toggleAmenity(this)">
                    <input type="checkbox" name="amenities" value="SMOKING_AREA">
                    <i class="fas fa-smoking"></i>
                    <div>Smoking Area</div>
                </label>
                
                <label class="amenity-item" onclick="toggleAmenity(this)">
                    <input type="checkbox" name="amenities" value="TWENTY_FOUR_HOUR_FRONT_DESK">
                    <i class="fas fa-clock"></i>
                    <div>24-hour Front Desk</div>
                </label>
                
                <label class="amenity-item" onclick="toggleAmenity(this)">
                    <input type="checkbox" name="amenities" value="AIR_CONDITIONING">
                    <i class="fas fa-snowflake"></i>
                    <div>Air Conditioning</div>
                </label>
                
                <label class="amenity-item" onclick="toggleAmenity(this)">
                    <input type="checkbox" name="amenities" value="RESTAURANTS">
                    <i class="fas fa-utensils"></i>
                    <div>Restaurants</div>
                </label>
                
                <label class="amenity-item" onclick="toggleAmenity(this)">
                    <input type="checkbox" name="amenities" value="NIGHTCLUB">
                    <i class="fas fa-music"></i>
                    <div>Nightclub</div>
                </label>
                
                <label class="amenity-item" onclick="toggleAmenity(this)">
                    <input type="checkbox" name="amenities" value="FACILITIES_FOR_DISABLED_GUESTS">
                    <i class="fas fa-wheelchair"></i>
                    <div>Facilities for Disabled Guests</div>
                </label>
            </div>
            
            </form>
        </div>
        
        <div class="footer-nav">
            <a href="/pilgrim/accommodation/property/listing/step1" class="btn btn-secondary">Back</a>
            <button type="submit" form="amenitiesForm" class="btn btn-next">Next</button>
        </div>
    </div>
    
    <script>
        function toggleAmenity(element) {
            const checkbox = element.querySelector('input[type="checkbox"]');
            checkbox.checked = !checkbox.checked;
            if (checkbox.checked) {
                element.classList.add('selected');
            } else {
                element.classList.remove('selected');
            }
        }
    </script>
</body>
</html>

