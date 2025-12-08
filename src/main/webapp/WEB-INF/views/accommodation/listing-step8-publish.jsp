<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Step 8/8 - Publish Property - GlobalPiligrim Accommodation</title>
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
            max-width: 1000px;
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
        .summary-section {
            background: #f9f9f9;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 30px;
        }
        .summary-section h3 {
            color: #667eea;
            margin-bottom: 20px;
        }
        .summary-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #e0e0e0;
        }
        .summary-item:last-child {
            border-bottom: none;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
        }
        input[type="text"] {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
        }
        input:focus {
            outline: none;
            border-color: #667eea;
        }
        .checkbox-group {
            margin-top: 20px;
        }
        .checkbox-group label {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 15px;
        }
        .checkbox-group input[type="checkbox"] {
            width: auto;
        }
        .warning {
            background: #fff3cd;
            border: 2px solid #ffc107;
            padding: 15px;
            border-radius: 8px;
            margin-top: 20px;
            color: #856404;
        }
        .btn-group {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }
        .btn {
            padding: 15px 40px;
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
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
            <div class="step-indicator">🚀 STEP 8/8 — PUBLISH PROPERTY</div>
            <h1><i class="fas fa-rocket"></i> Publish Your Property</h1>
        </div>
        
        <form method="post" action="/pilgrim/accommodation/property/listing/step8" class="form-container">
            <div class="summary-section">
                <h3><i class="fas fa-info-circle"></i> Property Summary</h3>
                <div class="summary-item">
                    <strong>Property Name:</strong>
                    <span>${property.details.propertyName != null ? property.details.propertyName : 'Not set'}</span>
                </div>
                <div class="summary-item">
                    <strong>Address:</strong>
                    <span>${property.location != null ? property.location.streetAddress : 'Not set'}, ${property.location != null ? property.location.city : ''}, ${property.location != null ? property.location.state : ''}</span>
                </div>
                <div class="summary-item">
                    <strong>Property Type:</strong>
                    <span>${property.propertyType}</span>
                </div>
                <div class="summary-item">
                    <strong>Rooms:</strong>
                    <span>${rooms.size()} room(s)</span>
                </div>
            </div>
            
            <div class="form-group">
                <label><i class="fas fa-id-card"></i> PAN</label>
                <input type="text" name="pan" required>
            </div>
            
            <div class="form-group">
                <label><i class="fas fa-file-invoice"></i> GST (Optional)</label>
                <input type="text" name="gst">
            </div>
            
            <div class="checkbox-group">
                <label>
                    <input type="checkbox" required>
                    <span>I accept the Terms and Conditions</span>
                </label>
                
                <label>
                    <input type="checkbox" required>
                    <span>I accept the Privacy Policy</span>
                </label>
            </div>
            
            <div class="warning">
                <i class="fas fa-exclamation-triangle"></i>
                <strong>DSA Compliance Warning:</strong> If your property is located in EU/EEA, please ensure compliance with Digital Services Act requirements.
            </div>
            
            <div class="btn-group">
                <a href="/pilgrim/accommodation/property/listing/step7" class="btn btn-secondary">Back</a>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-check"></i> PUBLISH LISTING
                </button>
            </div>
        </form>
    </div>
</body>
</html>

