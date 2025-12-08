<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Step 3/8 - Rooms Setup - GlobalPiligrim Accommodation</title>
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
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group.full-width {
            grid-column: 1 / -1;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
        }
        input[type="text"],
        input[type="number"],
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
        .add-room-btn {
            background: #667eea;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 10px;
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
            <li class="step-item completed">
                <div class="step-number">2</div>
                <div class="step-name">Amenities</div>
            </li>
            <li class="step-item active">
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
            <div class="step-indicator">Step 3/8</div>
            <h1>Rooms</h1>
        </div>
        
        <div class="content-body">
            <form method="post" action="/pilgrim/accommodation/property/listing/step3" id="roomsForm" class="form-container">
            <div class="form-group full-width">
                <label><i class="fas fa-door-open"></i> Room Type</label>
                <select name="roomType" id="roomType" required>
                    <option value="">Select Room Type</option>
                    <c:forEach var="roomType" items="${roomTypes}">
                        <option value="${roomType}">${fn:replace(fn:toLowerCase(roomType), '_', ' ')}</option>
                    </c:forEach>
                    <option value="CUSTOM">Add New Room Type</option>
                </select>
            </div>
            
            <div class="form-group full-width" id="customRoomTypeDiv" style="display: none;">
                <label><i class="fas fa-plus-circle"></i> Custom Room Type</label>
                <input type="text" name="customRoomType" id="customRoomType" placeholder="Enter custom room type">
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label><i class="fas fa-ruler"></i> Room Size (sqm)</label>
                    <input type="number" name="roomSize" step="0.01" required>
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-bath"></i> Bathrooms (0-5)</label>
                    <input type="number" name="bathrooms" min="0" max="5" required>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label><i class="fas fa-users"></i> Total Occupancy</label>
                    <input type="number" name="totalOccupancy" id="totalOccupancy" min="1" required>
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-bed"></i> Total Rooms</label>
                    <input type="number" name="totalRooms" id="totalRooms" min="1" value="1" required>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label><i class="fas fa-rupee-sign"></i> Minimum Room Rate (INR / Night)</label>
                    <input type="number" name="minimumRoomRate" step="0.01" required>
                </div>
                
                <div class="form-group">
                    <!-- Empty space for layout -->
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label><i class="fas fa-user-plus"></i> Extra Guest Price</label>
                    <input type="number" name="extraGuestPrice" step="0.01" required>
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-coffee"></i> Breakfast Included?</label>
                    <select name="breakfastIncluded" id="breakfastIncluded" required>
                        <option value="false">No</option>
                        <option value="true">Yes</option>
                    </select>
                </div>
            </div>
            
            <div class="form-group" id="breakfastPriceDiv" style="display: none;">
                <label><i class="fas fa-rupee-sign"></i> Breakfast Price / Guest</label>
                <input type="number" name="breakfastPricePerGuest" step="0.01" id="breakfastPricePerGuest">
            </div>
            
            <button type="button" class="add-room-btn" onclick="addAnotherRoom()">
                <i class="fas fa-plus"></i> Add Another Room
            </button>
            
            </form>
        </div>
        
        <div class="footer-nav">
            <a href="/pilgrim/accommodation/property/listing/step2" class="btn btn-secondary">Back</a>
            <button type="submit" form="roomsForm" class="btn btn-next">Next</button>
        </div>
    </div>
    
    <script>
        document.getElementById('roomType').addEventListener('change', function() {
            if (this.value === 'CUSTOM') {
                document.getElementById('customRoomTypeDiv').style.display = 'block';
                document.getElementById('customRoomType').required = true;
            } else {
                document.getElementById('customRoomTypeDiv').style.display = 'none';
                document.getElementById('customRoomType').required = false;
            }
        });
        
        document.getElementById('breakfastIncluded').addEventListener('change', function() {
            if (this.value === 'true') {
                document.getElementById('breakfastPriceDiv').style.display = 'block';
                document.getElementById('breakfastPricePerGuest').required = true;
            } else {
                document.getElementById('breakfastPriceDiv').style.display = 'none';
                document.getElementById('breakfastPricePerGuest').required = false;
            }
        });
        
        function addAnotherRoom() {
            // For now, just submit and allow adding more in next step
            alert('Room added! You can add more rooms after submitting this step.');
        }
    </script>
</body>
</html>

