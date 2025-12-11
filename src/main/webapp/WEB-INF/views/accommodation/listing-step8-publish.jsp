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
            background: #EFDFBB; /* Dutch White */
            padding: 40px 20px;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
        }
        
        /* Progress Indicator */
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
        
        .step-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .step-indicator {
            color: #722F37; /* Wine */
            font-weight: bold;
            margin-bottom: 10px;
            font-size: 1.2rem;
        }
        .step-header h1 {
            color: #722F37; /* Wine */
            margin-bottom: 10px;
        }
        .form-container {
            background: #EFDFBB; /* Dutch White */
            border: 2px solid #722F37; /* Wine */
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 4px 15px rgba(114, 47, 55, 0.1); /* Wine with opacity */
        }
        .summary-section {
            background: rgba(114, 47, 55, 0.05); /* Wine with very low opacity */
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 30px;
            border: 2px solid #722F37; /* Wine */
        }
        .summary-section h3 {
            color: #722F37; /* Wine */
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .summary-item {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid rgba(114, 47, 55, 0.2); /* Wine with opacity */
        }
        .summary-item:last-child {
            border-bottom: none;
        }
        .summary-item strong {
            color: #722F37; /* Wine */
            font-weight: 600;
        }
        .summary-item span {
            color: #722F37; /* Wine */
            opacity: 0.8;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 8px;
            color: #722F37; /* Wine */
            font-weight: 500;
        }
        label i {
            color: #722F37; /* Wine */
        }
        input[type="text"] {
            width: 100%;
            padding: 12px;
            border: 2px solid #722F37; /* Wine */
            border-radius: 8px;
            font-size: 1rem;
            background: rgba(255, 255, 255, 0.9);
            color: #722F37; /* Wine */
        }
        input:focus {
            outline: none;
            border-color: #5a2530; /* Darker Wine */
            box-shadow: 0 0 0 2px rgba(114, 47, 55, 0.2);
        }
        .checkbox-group {
            margin-top: 20px;
        }
        .checkbox-group label {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 15px;
            cursor: pointer;
        }
        .checkbox-group input[type="checkbox"] {
            width: 20px;
            height: 20px;
            accent-color: #722F37; /* Wine */
        }
        .warning {
            background: rgba(114, 47, 55, 0.1); /* Wine with opacity */
            border: 2px solid #722F37; /* Wine */
            padding: 15px;
            border-radius: 8px;
            margin-top: 20px;
            color: #722F37; /* Wine */
        }
        .warning i {
            color: #722F37; /* Wine */
            margin-right: 10px;
        }
        .warning strong {
            color: #722F37; /* Wine */
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
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: 600;
        }
        .btn-primary {
            background: #722F37; /* Wine */
            color: #EFDFBB; /* Dutch White */
            border: 2px solid #722F37; /* Wine */
        }
        .btn-primary:hover {
            background: #5a2530; /* Darker Wine */
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(114, 47, 55, 0.3);
        }
        .btn-secondary {
            background: #EFDFBB; /* Dutch White */
            color: #722F37; /* Wine */
            border: 2px solid #722F37; /* Wine */
        }
        .btn-secondary:hover {
            background: #722F37; /* Wine */
            color: #EFDFBB; /* Dutch White */
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(114, 47, 55, 0.2);
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Progress Indicator -->
        <div class="progress-container">
            <div class="step-line"></div>
            <div class="progress-steps">
                <div class="step completed">1</div>
                <div class="step completed">2</div>
                <div class="step completed">3</div>
                <div class="step completed">4</div>
                <div class="step completed">5</div>
                <div class="step completed">6</div>
                <div class="step completed">7</div>
                <div class="step active">8</div>
            </div>
        </div>
        
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
                <input type="text" name="pan" required placeholder="Enter your PAN number">
            </div>
            
            <div class="form-group">
                <label><i class="fas fa-file-invoice"></i> GST (Optional)</label>
                <input type="text" name="gst" placeholder="Enter your GST number (optional)">
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
                <a href="/pilgrim/accommodation/property/listing/step7" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back
                </a>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-check"></i> PUBLISH LISTING
                </button>
            </div>
        </form>
    </div>
</body>
</html>