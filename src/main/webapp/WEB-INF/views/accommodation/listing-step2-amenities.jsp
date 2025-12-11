<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Step 2/8 - Amenities - GlobalPiligrim Accommodation</title>
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
        
        /* Amenities Grid */
        .amenities-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }
        
        .amenity-item {
            padding: 25px 20px;
            border: 3px solid var(--wine);
            border-radius: 15px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            background: var(--dutch-white);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 140px;
            position: relative;
            overflow: hidden;
        }
        
        .amenity-item:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-wine);
            background: var(--wine-pale);
        }
        
        .amenity-item input[type="checkbox"] {
            display: none;
        }
        
        .amenity-item.selected {
            background: var(--wine);
            color: var(--dutch-white);
            transform: translateY(-5px);
            box-shadow: var(--shadow-wine);
        }
        
        .amenity-item.selected i {
            color: var(--dutch-white);
        }
        
        .amenity-item.selected .amenity-name {
            color: var(--dutch-white);
        }
        
        .amenity-item i {
            font-size: 2.5rem;
            margin-bottom: 15px;
            color: var(--wine);
            transition: all 0.3s ease;
        }
        
        .amenity-name {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--wine);
            transition: all 0.3s ease;
        }
        
        .amenity-check {
            position: absolute;
            top: 10px;
            right: 10px;
            width: 25px;
            height: 25px;
            background: var(--dutch-white);
            border: 2px solid var(--wine);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
            color: var(--wine);
            opacity: 0;
            transition: all 0.3s ease;
        }
        
        .amenity-item.selected .amenity-check {
            opacity: 1;
            background: var(--dutch-white);
            color: var(--wine);
        }
        
        /* Selected Counter */
        .selected-counter {
            text-align: center;
            margin: 30px 0;
            padding: 20px;
            background: var(--wine-pale);
            border-radius: 12px;
            border: 2px solid var(--wine);
        }
        
        .selected-counter h3 {
            font-size: 1.3rem;
            color: var(--wine);
            margin-bottom: 10px;
        }
        
        .counter-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--wine);
            font-family: 'Merriweather', serif;
        }
        
        /* Custom Amenities */
        .custom-amenities {
            margin-top: 40px;
            padding: 30px;
            background: var(--wine-pale);
            border-radius: 15px;
            border: 2px dashed var(--wine);
        }
        
        .custom-amenities h3 {
            color: var(--wine);
            font-size: 1.4rem;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .custom-input-group {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
        }
        
        .custom-input {
            flex: 1;
            padding: 15px;
            border: 2px solid var(--wine);
            border-radius: 10px;
            background: var(--dutch-white);
            color: var(--wine);
            font-size: 1rem;
            font-family: 'Poppins', sans-serif;
        }
        
        .custom-input:focus {
            outline: none;
            box-shadow: 0 0 0 3px var(--wine-transparent);
        }
        
        .btn-add {
            background: var(--wine);
            color: var(--dutch-white);
            border: none;
            padding: 0 25px;
            border-radius: 10px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-add:hover {
            background: var(--wine-dark);
            transform: scale(1.05);
        }
        
        .custom-list {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 20px;
        }
        
        .custom-tag {
            background: var(--wine);
            color: var(--dutch-white);
            padding: 10px 20px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.9rem;
        }
        
        .custom-tag i {
            cursor: pointer;
            font-size: 0.8rem;
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
            
            .amenities-grid {
                grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
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
            
            .amenities-grid {
                grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
                gap: 20px;
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
            
            .amenities-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .custom-input-group {
                flex-direction: column;
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
            
            .amenities-grid {
                grid-template-columns: 1fr;
            }
            
            .amenity-item {
                padding: 20px;
                min-height: 120px;
            }
            
            .amenity-item i {
                font-size: 2rem;
            }
            
            .amenity-name {
                font-size: 1rem;
            }
            
            .form-container {
                padding: 20px;
            }
            
            .selected-counter {
                padding: 15px;
            }
            
            .counter-number {
                font-size: 2rem;
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
            <li class="step-item active">
                <div class="step-number">2</div>
                <div>
                    <div class="step-name">Amenities</div>
                    <div class="step-description">Add features & facilities</div>
                </div>
            </li>
            <li class="step-item">
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
                <i class="fas fa-star"></i> Step 2 of 8
            </div>
            <h1>Amenities & Facilities</h1>
        </div>
        
        <!-- Form -->
        <div class="content-body">
            <div class="container">
                <form method="post" action="/pilgrim/accommodation/property/listing/step2" id="amenitiesForm" class="form-container">
                    <!-- Header Text -->
                    <div class="header-text">
                        <h2>Select Your Property Amenities</h2>
                        <p>Choose the amenities that make your property special. This helps attract the right guests.</p>
                    </div>
                    
                    <!-- Selected Counter -->
                    <div class="selected-counter">
                        <h3>Amenities Selected</h3>
                        <div class="counter-number" id="selectedCount">0</div>
                    </div>
                    
                    <!-- Amenities Grid -->
                    <div class="amenities-grid">
                        <label class="amenity-item" onclick="toggleAmenity(this)">
                            <input type="checkbox" name="amenities" value="SWIMMING_POOL">
                            <div class="amenity-check"><i class="fas fa-check"></i></div>
                            <i class="fas fa-swimming-pool"></i>
                            <div class="amenity-name">Swimming Pool</div>
                        </label>
                        
                        <label class="amenity-item" onclick="toggleAmenity(this)">
                            <input type="checkbox" name="amenities" value="CAR_PARK">
                            <div class="amenity-check"><i class="fas fa-check"></i></div>
                            <i class="fas fa-parking"></i>
                            <div class="amenity-name">Car Park</div>
                        </label>
                        
                        <label class="amenity-item" onclick="toggleAmenity(this)">
                            <input type="checkbox" name="amenities" value="SAUNA">
                            <div class="amenity-check"><i class="fas fa-check"></i></div>
                            <i class="fas fa-hot-tub"></i>
                            <div class="amenity-name">Sauna</div>
                        </label>
                        
                        <label class="amenity-item" onclick="toggleAmenity(this)">
                            <input type="checkbox" name="amenities" value="SPA">
                            <div class="amenity-check"><i class="fas fa-check"></i></div>
                            <i class="fas fa-spa"></i>
                            <div class="amenity-name">Spa</div>
                        </label>
                        
                        <label class="amenity-item" onclick="toggleAmenity(this)">
                            <input type="checkbox" name="amenities" value="NON_SMOKING">
                            <div class="amenity-check"><i class="fas fa-check"></i></div>
                            <i class="fas fa-ban"></i>
                            <div class="amenity-name">Non-smoking</div>
                        </label>
                        
                        <label class="amenity-item" onclick="toggleAmenity(this)">
                            <input type="checkbox" name="amenities" value="FREE_WIFI">
                            <div class="amenity-check"><i class="fas fa-check"></i></div>
                            <i class="fas fa-wifi"></i>
                            <div class="amenity-name">Free Wi-Fi</div>
                        </label>
                        
                        <label class="amenity-item" onclick="toggleAmenity(this)">
                            <input type="checkbox" name="amenities" value="AIRPORT_TRANSFER">
                            <div class="amenity-check"><i class="fas fa-check"></i></div>
                            <i class="fas fa-plane"></i>
                            <div class="amenity-name">Airport Transfer</div>
                        </label>
                        
                        <label class="amenity-item" onclick="toggleAmenity(this)">
                            <input type="checkbox" name="amenities" value="PETS_ALLOWED">
                            <div class="amenity-check"><i class="fas fa-check"></i></div>
                            <i class="fas fa-paw"></i>
                            <div class="amenity-name">Pets Allowed</div>
                        </label>
                        
                        <label class="amenity-item" onclick="toggleAmenity(this)">
                            <input type="checkbox" name="amenities" value="FITNESS_CENTER">
                            <div class="amenity-check"><i class="fas fa-check"></i></div>
                            <i class="fas fa-dumbbell"></i>
                            <div class="amenity-name">Fitness Center</div>
                        </label>
                        
                        <label class="amenity-item" onclick="toggleAmenity(this)">
                            <input type="checkbox" name="amenities" value="SMOKING_AREA">
                            <div class="amenity-check"><i class="fas fa-check"></i></div>
                            <i class="fas fa-smoking"></i>
                            <div class="amenity-name">Smoking Area</div>
                        </label>
                        
                        <label class="amenity-item" onclick="toggleAmenity(this)">
                            <input type="checkbox" name="amenities" value="TWENTY_FOUR_HOUR_FRONT_DESK">
                            <div class="amenity-check"><i class="fas fa-check"></i></div>
                            <i class="fas fa-clock"></i>
                            <div class="amenity-name">24-hour Front Desk</div>
                        </label>
                        
                        <label class="amenity-item" onclick="toggleAmenity(this)">
                            <input type="checkbox" name="amenities" value="AIR_CONDITIONING">
                            <div class="amenity-check"><i class="fas fa-check"></i></div>
                            <i class="fas fa-snowflake"></i>
                            <div class="amenity-name">Air Conditioning</div>
                        </label>
                        
                        <label class="amenity-item" onclick="toggleAmenity(this)">
                            <input type="checkbox" name="amenities" value="RESTAURANTS">
                            <div class="amenity-check"><i class="fas fa-check"></i></div>
                            <i class="fas fa-utensils"></i>
                            <div class="amenity-name">Restaurants</div>
                        </label>
                        
                        <label class="amenity-item" onclick="toggleAmenity(this)">
                            <input type="checkbox" name="amenities" value="NIGHTCLUB">
                            <div class="amenity-check"><i class="fas fa-check"></i></div>
                            <i class="fas fa-music"></i>
                            <div class="amenity-name">Nightclub</div>
                        </label>
                        
                        <label class="amenity-item" onclick="toggleAmenity(this)">
                            <input type="checkbox" name="amenities" value="FACILITIES_FOR_DISABLED_GUESTS">
                            <div class="amenity-check"><i class="fas fa-check"></i></div>
                            <i class="fas fa-wheelchair"></i>
                            <div class="amenity-name">Facilities for Disabled Guests</div>
                        </label>
                    </div>
                    
                    <!-- Custom Amenities Section -->
                    <div class="custom-amenities">
                        <h3><i class="fas fa-plus-circle"></i> Add Custom Amenities</h3>
                        <div class="custom-input-group">
                            <input type="text" class="custom-input" id="customAmenity" placeholder="Enter custom amenity (e.g., Yoga Studio, Library)">
                            <button type="button" class="btn-add" onclick="addCustomAmenity()">
                                <i class="fas fa-plus"></i> Add
                            </button>
                        </div>
                        <div class="custom-list" id="customList"></div>
                        <input type="hidden" name="customAmenities" id="customAmenitiesInput">
                    </div>
                </form>
            </div>
        </div>
        
        <!-- Footer Navigation -->
        <div class="footer-nav">
            <a href="/pilgrim/accommodation/property/listing/step1" class="btn btn-back">
                <i class="fas fa-arrow-left"></i> Back
            </a>
            <button type="button" class="btn btn-next" onclick="submitForm()">
                Next Step <i class="fas fa-arrow-right"></i>
            </button>
        </div>
    </div>
    
    <script>
        let selectedCount = 0;
        let customAmenities = [];
        
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
        
        // Toggle amenity selection
        function toggleAmenity(element) {
            const checkbox = element.querySelector('input[type="checkbox"]');
            checkbox.checked = !checkbox.checked;
            
            if (checkbox.checked) {
                element.classList.add('selected');
                selectedCount++;
            } else {
                element.classList.remove('selected');
                selectedCount--;
            }
            
            // Update counter
            document.getElementById('selectedCount').textContent = selectedCount;
        }
        
        // Add custom amenity
        function addCustomAmenity() {
            const input = document.getElementById('customAmenity');
            const amenity = input.value.trim();
            
            if (amenity && !customAmenities.includes(amenity)) {
                customAmenities.push(amenity);
                updateCustomAmenities();
                input.value = '';
                selectedCount++;
                document.getElementById('selectedCount').textContent = selectedCount;
            }
        }
        
        // Remove custom amenity
        function removeCustomAmenity(index) {
            customAmenities.splice(index, 1);
            updateCustomAmenities();
            selectedCount--;
            document.getElementById('selectedCount').textContent = selectedCount;
        }
        
        // Update custom amenities display
        function updateCustomAmenities() {
            const customList = document.getElementById('customList');
            const inputField = document.getElementById('customAmenitiesInput');
            
            customList.innerHTML = '';
            customAmenities.forEach((amenity, index) => {
                const tag = document.createElement('div');
                tag.className = 'custom-tag';
                tag.innerHTML = `
                    ${amenity}
                    <i class="fas fa-times" onclick="removeCustomAmenity(${index})"></i>
                `;
                customList.appendChild(tag);
            });
            
            inputField.value = customAmenities.join(',');
        }
        
        // Form validation
        function validateForm() {
            const checkboxes = document.querySelectorAll('input[name="amenities"]:checked');
            if (checkboxes.length === 0 && customAmenities.length === 0) {
                alert('Please select at least one amenity or add a custom amenity.');
                return false;
            }
            return true;
        }
        
        // Submit form
        function submitForm() {
            if (validateForm()) {
                // Show loading state
                const nextBtn = document.querySelector('.btn-next');
                const originalText = nextBtn.innerHTML;
                nextBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
                nextBtn.disabled = true;
                
                // Submit the form
                document.getElementById('amenitiesForm').submit();
            }
        }
        
        // Add keyboard support for custom input
        document.getElementById('customAmenity').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                addCustomAmenity();
            }
        });
        
        // Initialize selected count
        document.addEventListener('DOMContentLoaded', function() {
            // Check for pre-selected amenities
            const preSelected = document.querySelectorAll('input[name="amenities"]:checked');
            selectedCount = preSelected.length;
            document.getElementById('selectedCount').textContent = selectedCount;
            
            // Add selected class to pre-checked items
            preSelected.forEach(checkbox => {
                checkbox.parentElement.classList.add('selected');
            });
        });
    </script>
</body>
</html>