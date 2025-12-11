<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Step 1/8 - Location Details - GlobalPiligrim Accommodation</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Merriweather:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
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
        }
        
        .step-item.active .step-number {
            background: var(--wine);
            color: var(--dutch-white);
            border: 2px solid var(--dutch-white);
        }
        
        .step-item.completed .step-number {
            background: var(--dutch-white);
            color: var(--wine);
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
        
        /* Form Container */
        .form-container {
            max-width: 900px;
            margin: 0 auto;
        }
        
        /* Map Container */
        .map-container {
            margin: 30px 0;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: var(--shadow-wine);
            height: 450px;
            position: relative;
            border: 3px solid var(--wine);
        }
        
        #map {
            width: 100%;
            height: 100%;
        }
        
        .map-instruction {
            color: var(--wine-light);
            font-size: 0.95rem;
            margin-top: 15px;
            text-align: center;
            padding: 15px;
            background: var(--wine-pale);
            border-radius: 12px;
            border: 2px solid var(--border-wine);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        /* Form Fields */
        .form-fields {
            margin-top: 40px;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-bottom: 25px;
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
        
        input[type="text"],
        select {
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
        select:focus {
            outline: none;
            border-color: var(--wine);
            box-shadow: 0 0 0 3px var(--wine-transparent);
        }
        
        input::placeholder {
            color: var(--wine-light);
            opacity: 0.6;
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
        
        /* Progress Indicator */
        .progress-info {
            color: var(--wine);
            font-weight: 600;
            font-size: 0.95rem;
        }
        
        /* Form Validation */
        .form-message {
            padding: 15px;
            border-radius: 12px;
            margin-bottom: 25px;
            display: none;
        }
        
        .form-message.error {
            background: rgba(220, 53, 69, 0.1);
            border: 2px solid #dc3545;
            color: #dc3545;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .form-message.success {
            background: rgba(40, 167, 69, 0.1);
            border: 2px solid #28a745;
            color: #28a745;
            display: flex;
            align-items: center;
            gap: 10px;
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
            
            .form-row {
                grid-template-columns: 1fr;
                gap: 20px;
            }
            
            .content-header {
                padding: 20px;
            }
            
            .content-body {
                padding: 30px 20px;
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
            
            .map-container {
                height: 350px;
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
            
            .step-indicator {
                font-size: 0.9rem;
            }
            
            .form-fields {
                margin-top: 30px;
            }
            
            .form-group {
                margin-bottom: 20px;
            }
            
            input[type="text"],
            select {
                padding: 12px 15px;
                font-size: 0.95rem;
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
            <li class="step-item active">
                <div class="step-number">1</div>
                <div>
                    <div class="step-name">Location</div>
                    <div class="step-description">Set your property location</div>
                </div>
            </li>
            <li class="step-item">
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
                <i class="fas fa-map-marker-alt"></i> Step 1 of 8
            </div>
            <h1>Location Details</h1>
        </div>
        
        <!-- Form -->
        <div class="content-body">
            <div class="form-container">
                <!-- Map Section -->
                <div class="map-container">
                    <div id="map"></div>
                </div>
                
                <div class="map-instruction">
                    <i class="fas fa-mouse-pointer"></i> Click on the map to select your property location. The address will be automatically filled.
                </div>
                
                <!-- Form Fields -->
                <div class="form-fields" id="manualFields">
                    <form method="post" action="/pilgrim/accommodation/property/listing/step1" id="locationForm">
                        <div class="form-row">
                            <div class="form-group">
                                <label><i class="fas fa-globe"></i> Country</label>
                                <input type="text" name="country" id="country" list="countries" required>
                                <datalist id="countries">
                                    <option value="India">India</option>
                                    <option value="United States">United States</option>
                                    <option value="United Kingdom">United Kingdom</option>
                                    <option value="Canada">Canada</option>
                                    <option value="Australia">Australia</option>
                                </datalist>
                            </div>
                            
                            <div class="form-group">
                                <label><i class="fas fa-map"></i> State / Province</label>
                                <input type="text" name="state" id="state" required>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label><i class="fas fa-city"></i> City</label>
                                <input type="text" name="city" id="city" required>
                            </div>
                            
                            <div class="form-group">
                                <label><i class="fas fa-map-pin"></i> ZIP / Postal Code</label>
                                <input type="text" name="zipPostalCode" id="zipPostalCode">
                            </div>
                        </div>
                        
                        <div class="form-group full-width">
                            <label><i class="fas fa-road"></i> Street Address</label>
                            <input type="text" name="streetAddress" id="streetAddress" required>
                        </div>
                        
                        <div class="form-group full-width">
                            <label><i class="fas fa-building"></i> Building / Floor / Unit (Optional)</label>
                            <input type="text" name="buildingFloorUnit" id="buildingFloorUnit">
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label><i class="fas fa-map-marked-alt"></i> Latitude</label>
                                <input type="text" name="latitude" id="latitude" placeholder="e.g., 20.5937" required>
                            </div>
                            
                            <div class="form-group">
                                <label><i class="fas fa-map-marked-alt"></i> Longitude</label>
                                <input type="text" name="longitude" id="longitude" placeholder="e.g., 78.9629" required>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <!-- Footer Navigation -->
        <div class="footer-nav">
            <div class="progress-info">
                <i class="fas fa-spinner fa-spin"></i> Completing this step: 1 of 8
            </div>
            
            <div style="display: flex; gap: 15px;">
                <button type="button" class="btn btn-back" onclick="window.history.back()">
                    <i class="fas fa-arrow-left"></i> Back
                </button>
                <button type="button" class="btn btn-next" onclick="submitForm()">
                    Next Step <i class="fas fa-arrow-right"></i>
                </button>
            </div>
        </div>
    </div>
    
    <script>
        let map, marker;
        let defaultLat = 20.5937; // India default
        let defaultLng = 78.9629;
        
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
        
        // Form validation
        function validateForm() {
            const requiredFields = ['country', 'state', 'city', 'streetAddress', 'latitude', 'longitude'];
            let isValid = true;
            
            requiredFields.forEach(field => {
                const input = document.getElementById(field);
                if (!input.value.trim()) {
                    isValid = false;
                    input.style.borderColor = '#dc3545';
                } else {
                    input.style.borderColor = 'var(--border-wine)';
                }
            });
            
            // Validate coordinates
            const lat = parseFloat(document.getElementById('latitude').value);
            const lng = parseFloat(document.getElementById('longitude').value);
            
            if (isNaN(lat) || lat < -90 || lat > 90) {
                document.getElementById('latitude').style.borderColor = '#dc3545';
                isValid = false;
            }
            
            if (isNaN(lng) || lng < -180 || lng > 180) {
                document.getElementById('longitude').style.borderColor = '#dc3545';
                isValid = false;
            }
            
            return isValid;
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
                document.getElementById('locationForm').submit();
            } else {
                alert('Please fill in all required fields with valid data.');
            }
        }
        
        // Initialize map
        document.addEventListener('DOMContentLoaded', function() {
            // Initialize map
            map = L.map('map').setView([defaultLat, defaultLng], 6);
            
            // Add OpenStreetMap tiles
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '© OpenStreetMap contributors',
                maxZoom: 19
            }).addTo(map);
            
            // Custom marker icon
            const markerIcon = L.divIcon({
                className: 'custom-marker',
                html: '<div style="background: var(--wine); color: var(--dutch-white); width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; border: 3px solid var(--dutch-white); box-shadow: 0 2px 10px rgba(0,0,0,0.3);"><i class="fas fa-map-marker-alt"></i></div>',
                iconSize: [40, 40],
                iconAnchor: [20, 40]
            });
            
            // Add default marker
            marker = L.marker([defaultLat, defaultLng], {
                draggable: true,
                icon: markerIcon
            }).addTo(map);
            
            // Initialize form fields with default values
            document.getElementById('latitude').value = defaultLat;
            document.getElementById('longitude').value = defaultLng;
            document.getElementById('country').value = 'India';
            
            // Handle map click
            map.on('click', function(e) {
                const lat = e.latlng.lat;
                const lng = e.latlng.lng;
                
                // Update marker position
                marker.setLatLng([lat, lng]);
                
                // Update form fields
                document.getElementById('latitude').value = lat.toFixed(6);
                document.getElementById('longitude').value = lng.toFixed(6);
                
                // Reverse geocode to get address
                reverseGeocode(lat, lng);
                
                // Update map view
                map.setView([lat, lng], 15);
            });
            
            // Handle marker drag
            marker.on('dragend', function(e) {
                const lat = e.target.getLatLng().lat;
                const lng = e.target.getLatLng().lng;
                
                // Update form fields
                document.getElementById('latitude').value = lat.toFixed(6);
                document.getElementById('longitude').value = lng.toFixed(6);
                
                // Reverse geocode to get address
                reverseGeocode(lat, lng);
            });
            
            // Update map when coordinates are manually entered
            const latField = document.getElementById('latitude');
            const lngField = document.getElementById('longitude');
            
            latField.addEventListener('change', function() {
                const lat = parseFloat(latField.value);
                const lng = parseFloat(lngField.value);
                if (!isNaN(lat) && !isNaN(lng)) {
                    map.setView([lat, lng], 15);
                    marker.setLatLng([lat, lng]);
                    reverseGeocode(lat, lng);
                }
            });
            
            lngField.addEventListener('change', function() {
                const lat = parseFloat(latField.value);
                const lng = parseFloat(lngField.value);
                if (!isNaN(lat) && !isNaN(lng)) {
                    map.setView([lat, lng], 15);
                    marker.setLatLng([lat, lng]);
                    reverseGeocode(lat, lng);
                }
            });
            
            // Auto-detect location
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function(position) {
                    const userLat = position.coords.latitude;
                    const userLng = position.coords.longitude;
                    
                    // Set marker to user location
                    marker.setLatLng([userLat, userLng]);
                    map.setView([userLat, userLng], 13);
                    
                    // Update form fields
                    document.getElementById('latitude').value = userLat.toFixed(6);
                    document.getElementById('longitude').value = userLng.toFixed(6);
                    
                    // Reverse geocode
                    reverseGeocode(userLat, userLng);
                });
            }
        });
        
        // Reverse geocode function using Nominatim (OpenStreetMap)
        function reverseGeocode(lat, lng) {
            const url = `https://nominatim.openstreetmap.org/reverse?format=json&lat=${lat}&lon=${lng}&zoom=18&addressdetails=1`;
            
            fetch(url)
                .then(response => response.json())
                .then(data => {
                    if (data && data.address) {
                        const addr = data.address;
                        
                        // Fill address fields
                        if (addr.road || addr.house_number) {
                            document.getElementById('streetAddress').value = 
                                (addr.house_number || '') + ' ' + (addr.road || '').trim();
                        }
                        if (addr.city || addr.town || addr.village) {
                            document.getElementById('city').value = addr.city || addr.town || addr.village || '';
                        }
                        if (addr.state) {
                            document.getElementById('state').value = addr.state;
                        }
                        if (addr.country) {
                            document.getElementById('country').value = addr.country;
                        }
                        if (addr.postcode) {
                            document.getElementById('zipPostalCode').value = addr.postcode;
                        }
                    }
                })
                .catch(error => {
                    console.error('Reverse geocoding error:', error);
                });
        }
    </script>
</body>
</html>