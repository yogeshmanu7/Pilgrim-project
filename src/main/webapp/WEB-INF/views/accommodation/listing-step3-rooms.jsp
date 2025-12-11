<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Step 3/8 - Rooms Setup - GlobalPiligrim Accommodation</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Merriweather:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --dutch-white: #EFDFBB;
            --wine: #722F37;
            --wine-dark: #5A242B;
            --wine-light: rgba(114, 47, 55, 0.8);
            --wine-transparent: rgba(114, 47, 55, 0.1);
            --wine-pale: rgba(114, 47, 55, 0.05);
            --text-wine: #722F37;
            --text-cream: #EFDFBB;
            --border-wine: #722F37;
            --shadow-wine: 0 10px 30px rgba(114, 47, 55, 0.15);
            --shadow-light: 0 4px 15px rgba(114, 47, 55, 0.08);
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: var(--dutch-white);
            display: flex;
            min-height: 100vh;
            color: var(--text-wine);
        }
        
        /* Sidebar */
        .sidebar {
            width: 320px;
            background: var(--wine);
            padding: 40px 25px;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            border-right: 3px solid var(--dutch-white);
            box-shadow: var(--shadow-wine);
        }
        
        .sidebar-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 40px;
        }
        
        .sidebar-logo {
            width: 50px;
            height: 50px;
            background: var(--dutch-white);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--wine);
            font-size: 24px;
            border: 2px solid var(--dutch-white);
        }
        
        .sidebar-title {
            font-family: 'Merriweather', serif;
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--dutch-white);
        }
        
        .step-list {
            list-style: none;
        }
        
        .step-item {
            display: flex;
            align-items: center;
            padding: 18px 15px;
            margin-bottom: 10px;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }
        
        .step-item:hover {
            background: rgba(239, 223, 187, 0.1);
            transform: translateX(5px);
        }
        
        .step-item.active {
            background: var(--dutch-white);
            border-color: var(--dutch-white);
            transform: translateX(10px);
        }
        
        .step-item.completed {
            background: rgba(239, 223, 187, 0.2);
            border: 2px dashed var(--dutch-white);
        }
        
        .step-number {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: rgba(239, 223, 187, 0.2);
            color: var(--dutch-white);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            margin-right: 15px;
            font-size: 1rem;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }
        
        .step-item.active .step-number {
            background: var(--wine);
            color: var(--dutch-white);
            border: 2px solid var(--dutch-white);
        }
        
        .step-item.completed .step-number {
            background: var(--dutch-white);
            color: var(--wine);
            border: 2px solid var(--dutch-white);
        }
        
        .step-name {
            font-size: 1rem;
            color: var(--dutch-white);
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .step-item.active .step-name {
            color: var(--wine);
            font-weight: 600;
        }
        
        .step-item.completed .step-name {
            color: var(--dutch-white);
            opacity: 0.9;
        }
        
        .step-description {
            font-size: 0.85rem;
            color: rgba(239, 223, 187, 0.7);
            margin-top: 3px;
            transition: all 0.3s ease;
        }
        
        .step-item.active .step-description {
            color: var(--wine-light);
        }
        
        /* Main Content */
        .main-content {
            margin-left: 320px;
            flex: 1;
            display: flex;
            flex-direction: column;
            background: var(--dutch-white);
        }
        
        /* Content Header */
        .content-header {
            background: var(--dutch-white);
            padding: 30px 40px;
            border-bottom: 3px solid var(--wine);
            position: relative;
        }
        
        .header-actions {
            position: absolute;
            top: 30px;
            right: 40px;
            display: flex;
            gap: 15px;
        }
        
        .save-exit {
            color: var(--wine);
            text-decoration: none;
            font-weight: 600;
            padding: 10px 20px;
            border: 2px solid var(--wine);
            border-radius: 8px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .save-exit:hover {
            background: var(--wine);
            color: var(--dutch-white);
            transform: translateY(-2px);
            box-shadow: var(--shadow-light);
        }
        
        .step-indicator {
            color: var(--wine);
            font-size: 1rem;
            font-weight: 600;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .content-header h1 {
            font-family: 'Merriweather', serif;
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--wine);
            position: relative;
            display: inline-block;
        }
        
        .content-header h1::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 100px;
            height: 3px;
            background: var(--wine);
            border-radius: 2px;
        }
        
        /* Content Body */
        .content-body {
            flex: 1;
            padding: 40px;
            background: var(--dutch-white);
        }
        
        /* Container */
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        /* Form Container */
        .form-container {
            background: var(--dutch-white);
            border-radius: 20px;
            padding: 40px;
            border: 3px solid var(--wine);
            box-shadow: var(--shadow-wine);
        }
        
        /* Header Text */
        .header-text {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .header-text h2 {
            font-family: 'Merriweather', serif;
            font-size: 2rem;
            color: var(--wine);
            margin-bottom: 15px;
        }
        
        .header-text p {
            color: var(--wine-light);
            font-size: 1.1rem;
            max-width: 600px;
            margin: 0 auto;
            line-height: 1.6;
        }
        
        /* Form Layout */
        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 30px;
            margin-bottom: 40px;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group.full-width {
            grid-column: 1 / -1;
        }
        
        label {
            display: block;
            margin-bottom: 10px;
            color: var(--wine);
            font-weight: 600;
            font-size: 1rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .label-icon {
            width: 35px;
            height: 35px;
            background: var(--wine-pale);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--wine);
            font-size: 1rem;
            flex-shrink: 0;
        }
        
        input[type="text"],
        input[type="number"],
        select,
        textarea {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid var(--border-wine);
            border-radius: 12px;
            font-size: 1rem;
            background: var(--dutch-white);
            color: var(--text-wine);
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s ease;
        }
        
        input:focus,
        select:focus,
        textarea:focus {
            outline: none;
            border-color: var(--wine);
            box-shadow: 0 0 0 3px var(--wine-transparent);
        }
        
        input::placeholder {
            color: var(--wine-light);
            opacity: 0.6;
        }
        
        /* Room Features Section */
        .room-features {
            grid-column: 1 / -1;
            margin: 30px 0;
            padding: 30px;
            background: var(--wine-pale);
            border-radius: 15px;
            border: 2px solid var(--wine);
        }
        
        .room-features h3 {
            color: var(--wine);
            font-size: 1.4rem;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 15px;
        }
        
        .feature-checkbox {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 15px;
            background: var(--dutch-white);
            border: 2px solid var(--border-wine);
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .feature-checkbox:hover {
            background: var(--wine-pale);
        }
        
        .feature-checkbox input[type="checkbox"] {
            display: none;
        }
        
        .feature-checkbox.selected {
            background: var(--wine);
            color: var(--dutch-white);
            border-color: var(--wine);
        }
        
        .feature-checkbox.selected .feature-text {
            color: var(--dutch-white);
        }
        
        .feature-text {
            color: var(--wine);
            font-weight: 500;
        }
        
        /* Add Room Button */
        .add-room-btn {
            background: var(--wine);
            color: var(--dutch-white);
            padding: 15px 30px;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-size: 1.1rem;
            font-weight: 600;
            margin-top: 20px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 10px;
            justify-content: center;
            width: 100%;
            border: 2px solid var(--wine);
        }
        
        .add-room-btn:hover {
            background: var(--wine-dark);
            transform: translateY(-3px);
            box-shadow: var(--shadow-wine);
        }
        
        .add-room-btn:active {
            transform: translateY(0);
        }
        
        /* Room Counter */
        .room-counter {
            text-align: center;
            margin: 20px 0;
            padding: 20px;
            background: var(--wine-pale);
            border-radius: 12px;
            border: 2px dashed var(--wine);
        }
        
        .room-counter h4 {
            color: var(--wine);
            font-size: 1.2rem;
            margin-bottom: 10px;
        }
        
        .counter-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--wine);
            font-family: 'Merriweather', serif;
        }
        
        /* Existing Rooms */
        .existing-rooms {
            margin-top: 40px;
            padding: 30px;
            background: var(--wine-pale);
            border-radius: 15px;
            border: 2px solid var(--wine);
            display: none;
        }
        
        .existing-rooms h3 {
            color: var(--wine);
            font-size: 1.4rem;
            margin-bottom: 20px;
        }
        
        .room-list {
            display: grid;
            gap: 15px;
        }
        
        .room-item {
            background: var(--dutch-white);
            padding: 20px;
            border-radius: 12px;
            border: 2px solid var(--border-wine);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .room-info h4 {
            color: var(--wine);
            font-size: 1.2rem;
            margin-bottom: 5px;
        }
        
        .room-info p {
            color: var(--wine-light);
            font-size: 0.9rem;
        }
        
        /* Footer Navigation */
        .footer-nav {
            background: var(--dutch-white);
            padding: 25px 40px;
            border-top: 3px solid var(--wine);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .btn {
            padding: 14px 35px;
            border: none;
            border-radius: 12px;
            font-size: 1.1rem;
            cursor: pointer;
            font-weight: 600;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
        }
        
        .btn-back {
            background: transparent;
            color: var(--wine);
            border: 2px solid var(--wine);
        }
        
        .btn-back:hover {
            background: var(--wine-transparent);
            transform: translateX(-5px);
            box-shadow: var(--shadow-light);
        }
        
        .btn-next {
            background: var(--wine);
            color: var(--dutch-white);
            border: 2px solid var(--wine);
        }
        
        .btn-next:hover {
            background: var(--wine-dark);
            transform: translateX(5px);
            box-shadow: var(--shadow-wine);
        }
        
        /* Responsive Design */
        @media (max-width: 1200px) {
            .sidebar {
                width: 280px;
            }
            
            .main-content {
                margin-left: 280px;
            }
        }
        
        @media (max-width: 992px) {
            .sidebar {
                position: fixed;
                top: 0;
                left: -280px;
                z-index: 1000;
                transition: left 0.3s ease;
            }
            
            .sidebar.active {
                left: 0;
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .menu-toggle {
                display: block;
                position: fixed;
                top: 20px;
                left: 20px;
                background: var(--wine);
                color: var(--dutch-white);
                border: none;
                padding: 12px;
                border-radius: 8px;
                font-size: 1.2rem;
                cursor: pointer;
                z-index: 999;
            }
            
            .content-header {
                padding: 20px;
            }
            
            .content-body {
                padding: 30px 20px;
            }
            
            .form-container {
                padding: 30px;
            }
            
            .form-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }
            
            .features-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .footer-nav {
                padding: 20px;
            }
        }
        
        @media (max-width: 768px) {
            .header-actions {
                position: static;
                margin-top: 15px;
                justify-content: flex-end;
            }
            
            .content-header h1 {
                font-size: 2rem;
            }
            
            .header-text h2 {
                font-size: 1.6rem;
            }
            
            .features-grid {
                grid-template-columns: 1fr;
            }
            
            .btn {
                padding: 12px 25px;
                font-size: 1rem;
            }
        }
        
        @media (max-width: 576px) {
            .content-header h1 {
                font-size: 1.8rem;
            }
            
            .header-text h2 {
                font-size: 1.4rem;
            }
            
            .form-container {
                padding: 20px;
            }
            
            .form-group {
                margin-bottom: 20px;
            }
            
            input[type="text"],
            input[type="number"],
            select,
            textarea {
                padding: 12px 15px;
                font-size: 0.95rem;
            }
            
            .room-features {
                padding: 20px;
            }
            
            .btn {
                padding: 10px 20px;
                font-size: 0.95rem;
            }
            
            .footer-nav {
                flex-direction: column;
                gap: 15px;
            }
        }
    </style>
</head>
<body>
    <!-- Mobile Menu Toggle -->
    <button class="menu-toggle" onclick="toggleSidebar()">
        <i class="fas fa-bars"></i>
    </button>
    
    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <div class="sidebar-logo">
                <i class="fas fa-hands-praying"></i>
            </div>
            <div class="sidebar-title">List Property</div>
        </div>
        
        <ul class="step-list">
            <li class="step-item completed">
                <div class="step-number">1</div>
                <div>
                    <div class="step-name">Location</div>
                    <div class="step-description">Set your property location</div>
                </div>
            </li>
            <li class="step-item completed">
                <div class="step-number">2</div>
                <div>
                    <div class="step-name">Amenities</div>
                    <div class="step-description">Add features & facilities</div>
                </div>
            </li>
            <li class="step-item active">
                <div class="step-number">3</div>
                <div>
                    <div class="step-name">Rooms</div>
                    <div class="step-description">Configure room types</div>
                </div>
            </li>
            <li class="step-item">
                <div class="step-number">4</div>
                <div>
                    <div class="step-name">Pricing</div>
                    <div class="step-description">Set rates & availability</div>
                </div>
            </li>
            <li class="step-item">
                <div class="step-number">5</div>
                <div>
                    <div class="step-name">Photos</div>
                    <div class="step-description">Upload property images</div>
                </div>
            </li>
            <li class="step-item">
                <div class="step-number">6</div>
                <div>
                    <div class="step-name">Details</div>
                    <div class="step-description">Add property description</div>
                </div>
            </li>
            <li class="step-item">
                <div class="step-number">7</div>
                <div>
                    <div class="step-name">Profile</div>
                    <div class="step-description">Setup host profile</div>
                </div>
            </li>
            <li class="step-item">
                <div class="step-number">8</div>
                <div>
                    <div class="step-name">Publish</div>
                    <div class="step-description">Review & publish</div>
                </div>
            </li>
        </ul>
    </div>
    
    <!-- Main Content -->
    <div class="main-content">
        <!-- Header -->
        <div class="content-header">
            <div class="header-actions">
                <a href="/pilgrim/accommodation/property/drafts" class="save-exit">
                    <i class="fas fa-save"></i> Save & Exit
                </a>
            </div>
            
            <div class="step-indicator">
                <i class="fas fa-door-open"></i> Step 3 of 8
            </div>
            <h1>Room Configuration</h1>
        </div>
        
        <!-- Form -->
        <div class="content-body">
            <div class="container">
                <form method="post" action="/pilgrim/accommodation/property/listing/step3" id="roomsForm" class="form-container">
                    <!-- Header Text -->
                    <div class="header-text">
                        <h2>Set Up Your Rooms</h2>
                        <p>Configure the rooms available at your property. You can add multiple room types.</p>
                    </div>
                    
                    <!-- Room Counter -->
                    <div class="room-counter">
                        <h4>Current Room Count</h4>
                        <div class="counter-number" id="roomCount">1</div>
                        <p style="color: var(--wine-light); font-size: 0.9rem; margin-top: 10px;">Add more rooms as needed</p>
                    </div>
                    
                    <!-- Room Details -->
                    <div class="form-grid">
                        <!-- Room Type -->
                        <div class="form-group full-width">
                            <label>
                                <div class="label-icon">
                                    <i class="fas fa-door-open"></i>
                                </div>
                                Room Type
                            </label>
                            <select name="roomType" id="roomType" required onchange="toggleCustomRoomType()">
                                <option value="">Select Room Type</option>
                                <c:forEach var="roomType" items="${roomTypes}">
                                    <option value="${roomType}">${fn:replace(fn:toLowerCase(roomType), '_', ' ')}</option>
                                </c:forEach>
                                <option value="CUSTOM">Add New Room Type</option>
                            </select>
                        </div>
                        
                        <!-- Custom Room Type -->
                        <div class="form-group full-width" id="customRoomTypeDiv" style="display: none;">
                            <label>
                                <div class="label-icon">
                                    <i class="fas fa-plus-circle"></i>
                                </div>
                                Custom Room Type
                            </label>
                            <input type="text" name="customRoomType" id="customRoomType" placeholder="Enter custom room type (e.g., Deluxe Suite)">
                        </div>
                        
                        <!-- Room Size -->
                        <div class="form-group">
                            <label>
                                <div class="label-icon">
                                    <i class="fas fa-ruler"></i>
                                </div>
                                Room Size (sqm)
                            </label>
                            <input type="number" name="roomSize" step="0.01" required placeholder="e.g., 25.5">
                        </div>
                        
                        <!-- Bathrooms -->
                        <div class="form-group">
                            <label>
                                <div class="label-icon">
                                    <i class="fas fa-bath"></i>
                                </div>
                                Bathrooms
                            </label>
                            <input type="number" name="bathrooms" min="0" max="5" required placeholder="0-5">
                        </div>
                        
                        <!-- Total Occupancy -->
                        <div class="form-group">
                            <label>
                                <div class="label-icon">
                                    <i class="fas fa-users"></i>
                                </div>
                                Total Occupancy
                            </label>
                            <input type="number" name="totalOccupancy" id="totalOccupancy" min="1" required placeholder="Max guests">
                        </div>
                        
                        <!-- Total Rooms -->
                        <div class="form-group">
                            <label>
                                <div class="label-icon">
                                    <i class="fas fa-bed"></i>
                                </div>
                                Total Rooms
                            </label>
                            <input type="number" name="totalRooms" id="totalRooms" min="1" value="1" required>
                        </div>
                        
                        <!-- Minimum Room Rate -->
                        <div class="form-group">
                            <label>
                                <div class="label-icon">
                                    <i class="fas fa-rupee-sign"></i>
                                </div>
                                Minimum Room Rate
                            </label>
                            <input type="number" name="minimumRoomRate" step="0.01" required placeholder="INR per night">
                        </div>
                        
                        <!-- Extra Guest Price -->
                        <div class="form-group">
                            <label>
                                <div class="label-icon">
                                    <i class="fas fa-user-plus"></i>
                                </div>
                                Extra Guest Price
                            </label>
                            <input type="number" name="extraGuestPrice" step="0.01" required placeholder="INR per extra guest">
                        </div>
                    </div>
                    
                    <!-- Breakfast Options -->
                    <div class="form-grid">
                        <div class="form-group">
                            <label>
                                <div class="label-icon">
                                    <i class="fas fa-coffee"></i>
                                </div>
                                Breakfast Included?
                            </label>
                            <select name="breakfastIncluded" id="breakfastIncluded" required onchange="toggleBreakfastPrice()">
                                <option value="false">No</option>
                                <option value="true">Yes, included in price</option>
                            </select>
                        </div>
                        
                        <!-- Breakfast Price -->
                        <div class="form-group" id="breakfastPriceDiv" style="display: none;">
                            <label>
                                <div class="label-icon">
                                    <i class="fas fa-rupee-sign"></i>
                                </div>
                                Breakfast Price / Guest
                            </label>
                            <input type="number" name="breakfastPricePerGuest" step="0.01" id="breakfastPricePerGuest" placeholder="Additional charge per guest">
                        </div>
                    </div>
                    
                    <!-- Room Features -->
                    <div class="room-features">
                        <h3><i class="fas fa-star"></i> Room Features</h3>
                        <div class="features-grid">
                            <label class="feature-checkbox" onclick="toggleFeature(this)">
                                <input type="checkbox" name="features" value="TV">
                                <div class="feature-text">Television</div>
                            </label>
                            <label class="feature-checkbox" onclick="toggleFeature(this)">
                                <input type="checkbox" name="features" value="MINIBAR">
                                <div class="feature-text">Mini Bar</div>
                            </label>
                            <label class="feature-checkbox" onclick="toggleFeature(this)">
                                <input type="checkbox" name="features" value="SAFE">
                                <div class="feature-text">Safe Deposit Box</div>
                            </label>
                            <label class="feature-checkbox" onclick="toggleFeature(this)">
                                <input type="checkbox" name="features" value="WORKDESK">
                                <div class="feature-text">Work Desk</div>
                            </label>
                            <label class="feature-checkbox" onclick="toggleFeature(this)">
                                <input type="checkbox" name="features" value="BALCONY">
                                <div class="feature-text">Balcony</div>
                            </label>
                            <label class="feature-checkbox" onclick="toggleFeature(this)">
                                <input type="checkbox" name="features" value="VIEW">
                                <div class="feature-text">Scenic View</div>
                            </label>
                        </div>
                        <input type="hidden" name="roomFeatures" id="roomFeaturesInput">
                    </div>
                    
                    <!-- Add Another Room Button -->
                    <button type="button" class="add-room-btn" onclick="addAnotherRoom()">
                        <i class="fas fa-plus-circle"></i> Add Another Room Type
                    </button>
                    
                    <!-- Existing Rooms (will be shown when rooms are added) -->
                    <div class="existing-rooms" id="existingRooms">
                        <h3><i class="fas fa-list"></i> Existing Rooms</h3>
                        <div class="room-list" id="roomList">
                            <!-- Rooms will be added here dynamically -->
                        </div>
                    </div>
                </form>
            </div>
        </div>
        
        <!-- Footer Navigation -->
        <div class="footer-nav">
            <a href="/pilgrim/accommodation/property/listing/step2" class="btn btn-back">
                <i class="fas fa-arrow-left"></i> Back
            </a>
            <button type="button" class="btn btn-next" onclick="submitForm()">
                Next Step <i class="fas fa-arrow-right"></i>
            </button>
        </div>
    </div>
    
    <script>
        let roomCount = 1;
        let selectedFeatures = [];
        
        // Toggle sidebar on mobile
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('active');
        }
        
        // Close sidebar when clicking outside on mobile
        document.addEventListener('click', function(event) {
            const sidebar = document.getElementById('sidebar');
            const menuToggle = document.querySelector('.menu-toggle');
            
            if (window.innerWidth <= 992 && 
                !sidebar.contains(event.target) && 
                !menuToggle.contains(event.target)) {
                sidebar.classList.remove('active');
            }
        });
        
        // Toggle custom room type field
        function toggleCustomRoomType() {
            const roomType = document.getElementById('roomType');
            const customDiv = document.getElementById('customRoomTypeDiv');
            const customInput = document.getElementById('customRoomType');
            
            if (roomType.value === 'CUSTOM') {
                customDiv.style.display = 'block';
                customInput.required = true;
            } else {
                customDiv.style.display = 'none';
                customInput.required = false;
            }
        }
        
        // Toggle breakfast price field
        function toggleBreakfastPrice() {
            const breakfast = document.getElementById('breakfastIncluded');
            const priceDiv = document.getElementById('breakfastPriceDiv');
            const priceInput = document.getElementById('breakfastPricePerGuest');
            
            if (breakfast.value === 'true') {
                priceDiv.style.display = 'block';
                priceInput.required = true;
            } else {
                priceDiv.style.display = 'none';
                priceInput.required = false;
            }
        }
        
        // Toggle room feature selection
        function toggleFeature(element) {
            const checkbox = element.querySelector('input[type="checkbox"]');
            const featureValue = checkbox.value;
            
            checkbox.checked = !checkbox.checked;
            
            if (checkbox.checked) {
                element.classList.add('selected');
                selectedFeatures.push(featureValue);
            } else {
                element.classList.remove('selected');
                selectedFeatures = selectedFeatures.filter(f => f !== featureValue);
            }
            
            // Update hidden input
            document.getElementById('roomFeaturesInput').value = selectedFeatures.join(',');
        }
        
        // Add another room
        function addAnotherRoom() {
            // Validate current form
            if (!validateCurrentRoom()) {
                return;
            }
            
            // Get current room data
            const roomType = document.getElementById('roomType').value;
            const customType = document.getElementById('customRoomType').value;
            const roomSize = document.querySelector('input[name="roomSize"]').value;
            const bathrooms = document.querySelector('input[name="bathrooms"]').value;
            const occupancy = document.getElementById('totalOccupancy').value;
            const rooms = document.getElementById('totalRooms').value;
            const rate = document.querySelector('input[name="minimumRoomRate"]').value;
            
            // Create room item
            const roomList = document.getElementById('roomList');
            const existingRooms = document.getElementById('existingRooms');
            
            const roomItem = document.createElement('div');
            roomItem.className = 'room-item';
            roomItem.innerHTML = `
                <div class="room-info">
                    <h4>${customType || roomType.replace('_', ' ')}</h4>
                    <p>${roomSize} sqm • ${rooms} rooms • ${occupancy} guests • ₹${rate}/night</p>
                </div>
                <div>
                    <button type="button" class="btn-secondary" style="padding: 8px 15px; font-size: 0.9rem;" onclick="removeRoom(this)">
                        <i class="fas fa-trash"></i> Remove
                    </button>
                </div>
            `;
            
            roomList.appendChild(roomItem);
            
            // Show existing rooms section
            existingRooms.style.display = 'block';
            
            // Increment room count
            roomCount++;
            document.getElementById('roomCount').textContent = roomCount;
            
            // Reset form for next room
            resetRoomForm();
            
            // Show success message
            alert(`Room type added successfully! You have added ${roomCount} room type(s).`);
        }
        
        // Remove room from list
        function removeRoom(button) {
            const roomItem = button.closest('.room-item');
            roomItem.remove();
            
            // Decrement room count
            roomCount--;
            document.getElementById('roomCount').textContent = roomCount;
            
            // Hide existing rooms if empty
            const roomList = document.getElementById('roomList');
            if (roomList.children.length === 0) {
                document.getElementById('existingRooms').style.display = 'none';
            }
        }
        
        // Validate current room form
        function validateCurrentRoom() {
            const requiredFields = [
                'roomType', 'roomSize', 'bathrooms', 
                'totalOccupancy', 'totalRooms', 'minimumRoomRate', 
                'extraGuestPrice'
            ];
            
            let isValid = true;
            
            requiredFields.forEach(fieldName => {
                const field = document.querySelector(`[name="${fieldName}"]`);
                if (field && !field.value.trim()) {
                    isValid = false;
                    field.style.borderColor = '#dc3545';
                } else if (field) {
                    field.style.borderColor = 'var(--border-wine)';
                }
            });
            
            // Check for custom room type if selected
            const roomType = document.getElementById('roomType');
            if (roomType.value === 'CUSTOM') {
                const customType = document.getElementById('customRoomType');
                if (!customType.value.trim()) {
                    isValid = false;
                    customType.style.borderColor = '#dc3545';
                } else {
                    customType.style.borderColor = 'var(--border-wine)';
                }
            }
            
            if (!isValid) {
                alert('Please fill in all required fields before adding another room.');
                return false;
            }
            
            return true;
        }
        
        // Reset room form
        function resetRoomForm() {
            document.getElementById('roomsForm').reset();
            document.getElementById('customRoomTypeDiv').style.display = 'none';
            document.getElementById('breakfastPriceDiv').style.display = 'none';
            
            // Reset features
            selectedFeatures = [];
            document.querySelectorAll('.feature-checkbox').forEach(feature => {
                feature.classList.remove('selected');
                feature.querySelector('input[type="checkbox"]').checked = false;
            });
            document.getElementById('roomFeaturesInput').value = '';
        }
        
        // Submit form
        function submitForm() {
            if (validateCurrentRoom()) {
                // Show loading state
                const nextBtn = document.querySelector('.btn-next');
                const originalText = nextBtn.innerHTML;
                nextBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
                nextBtn.disabled = true;
                
                // Submit the form
                document.getElementById('roomsForm').submit();
            }
        }
        
        // Initialize form
        document.addEventListener('DOMContentLoaded', function() {
            // Set up event listeners
            document.getElementById('roomType').addEventListener('change', toggleCustomRoomType);
            document.getElementById('breakfastIncluded').addEventListener('change', toggleBreakfastPrice);
            
            // Set up feature checkboxes
            document.querySelectorAll('.feature-checkbox').forEach(feature => {
                const checkbox = feature.querySelector('input[type="checkbox"]');
                checkbox.addEventListener('change', function() {
                    if (this.checked) {
                        feature.classList.add('selected');
                    } else {
                        feature.classList.remove('selected');
                    }
                });
            });
        });
    </script>
</body>
</html>