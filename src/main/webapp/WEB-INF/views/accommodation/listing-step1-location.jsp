<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Step 1/8 - Location Details - GlobalPiligrim Accommodation</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
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
        .search-container {
            margin-bottom: 20px;
        }
        .search-box {
            position: relative;
            width: 100%;
            max-width: 600px;
        }
        .search-box input {
            width: 100%;
            padding: 15px 50px 15px 50px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
        }
        .search-box input:focus {
            outline: none;
            border-color: #667eea;
        }
        .search-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
        }
        .manual-entry {
            margin-top: 15px;
            color: #666;
        }
        .manual-entry a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
        }
        .map-container {
            margin: 30px 0;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            height: 500px;
            position: relative;
        }
        #map {
            width: 100%;
            height: 100%;
        }
        .map-instruction {
            color: #666;
            font-size: 0.95rem;
            margin-top: 15px;
            text-align: center;
            padding: 10px;
            background: #f8f9fa;
            border-radius: 8px;
        }
        .form-fields {
            display: block;
            margin-top: 30px;
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
        .footer-nav {
            background: white;
            padding: 20px 40px;
            border-top: 1px solid #e0e0e0;
            display: flex;
            justify-content: space-between;
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
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
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
            <li class="step-item active">
                <div class="step-number">1</div>
                <div class="step-name">Location</div>
            </li>
            <li class="step-item">
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
            <div class="step-indicator">Step 1/8</div>
            <h1>Location</h1>
        </div>
        
        <div class="content-body">
            <form method="post" action="/pilgrim/accommodation/property/listing/step1" id="locationForm">
                <div class="form-fields" id="manualFields">
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
                </div>
                
                <!-- Interactive Map -->
                <div class="map-container">
                    <div id="map"></div>
                </div>
                <div class="map-instruction">
                    <i class="fas fa-info-circle"></i> Click on the map to select your property location. The address fields will be automatically filled.
                </div>
            </form>
        </div>
        
        <div class="footer-nav">
            <button type="button" class="btn btn-back" onclick="window.history.back()">Back</button>
            <button type="button" class="btn btn-next" onclick="document.getElementById('locationForm').submit()">Next</button>
        </div>
    </div>
    
    <script>
        let map, marker;
        let defaultLat = 20.5937; // India default
        let defaultLng = 78.9629;
        
        // Initialize map
        document.addEventListener('DOMContentLoaded', function() {
            // Initialize map
            map = L.map('map').setView([defaultLat, defaultLng], 6);
            
            // Add OpenStreetMap tiles
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '© OpenStreetMap contributors',
                maxZoom: 19
            }).addTo(map);
            
            // Add default marker
            marker = L.marker([defaultLat, defaultLng], {draggable: true}).addTo(map);
            
            // Initialize form fields with default values
            document.getElementById('latitude').value = defaultLat;
            document.getElementById('longitude').value = defaultLng;
            
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

