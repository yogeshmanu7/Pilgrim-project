<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Step 7/8 - Profile Details - GlobalPiligrim Accommodation</title>
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
        .section-title {
            color: #667eea;
            font-size: 1.3rem;
            margin: 30px 0 20px 0;
            padding-bottom: 10px;
            border-bottom: 2px solid #e0e0e0;
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
        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
        }
        input[type="text"],
        input[type="email"],
        input[type="tel"],
        input[type="date"],
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
            background: #e0e0e0;
            color: #333;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="step-header">
            <div class="step-indicator">👤 STEP 7/8 — PROFILE DETAILS</div>
            <h1><i class="fas fa-user"></i> Profile Details</h1>
        </div>
        
        <form method="post" action="/pilgrim/accommodation/property/listing/step7" class="form-container">
            <div class="section-title">Account Holder Information</div>
            
            <div class="form-row">
                <div class="form-group">
                    <label><i class="fas fa-user"></i> First Name</label>
                    <input type="text" name="firstName" value="${user.firstName}" required>
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-user"></i> Last Name</label>
                    <input type="text" name="lastName" value="${user.lastName}" required>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label><i class="fas fa-flag"></i> Nationality</label>
                    <input type="text" name="nationality" value="${user.nationality}">
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-calendar"></i> Date of Birth</label>
                    <input type="date" name="dateOfBirth" value="${user.dateOfBirth}">
                </div>
            </div>
            
            <div class="section-title">Residence Information</div>
            
            <div class="form-row">
                <div class="form-group">
                    <label><i class="fas fa-globe"></i> Country</label>
                    <input type="text" name="residenceCountry" value="${user.residenceCountry}" required>
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-map"></i> State</label>
                    <input type="text" name="residenceState" value="${user.residenceState}" required>
                </div>
            </div>
            
            <div class="form-group">
                <label><i class="fas fa-city"></i> City</label>
                <input type="text" name="residenceCity" value="${user.residenceCity}" required>
            </div>
            
            <div class="section-title">Contact Details</div>
            
            <div class="form-row">
                <div class="form-group">
                    <label><i class="fas fa-language"></i> Preferred Language</label>
                    <select name="preferredLanguage" required>
                        <option value="English">English</option>
                        <option value="Hindi">Hindi</option>
                        <option value="Spanish">Spanish</option>
                        <option value="French">French</option>
                        <option value="German">German</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-phone"></i> Country Code</label>
                    <input type="text" name="countryCode" value="${user.countryCode}" placeholder="+91" required>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label><i class="fas fa-phone"></i> Phone Number</label>
                    <input type="tel" name="contactPhoneNumber" value="${user.contactPhoneNumber}" required>
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-envelope"></i> Email</label>
                    <input type="email" name="contactEmail" value="${user.contactEmail}" required>
                </div>
            </div>
            
            <div class="btn-group">
                <a href="/pilgrim/accommodation/property/listing/step6" class="btn btn-secondary">Back</a>
                <button type="submit" class="btn btn-primary">Next Step <i class="fas fa-arrow-right"></i></button>
            </div>
        </form>
    </div>
</body>
</html>

