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
        }
        .form-container {
            background: #EFDFBB; /* Dutch White */
            border: 2px solid #722F37; /* Wine */
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 4px 15px rgba(114, 47, 55, 0.1); /* Wine with opacity */
        }
        .section-title {
            color: #722F37; /* Wine */
            font-size: 1.3rem;
            margin: 30px 0 20px 0;
            padding-bottom: 10px;
            border-bottom: 2px solid #722F37; /* Wine */
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
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 8px;
            color: #722F37; /* Wine */
            font-weight: 500;
        }
        label i {
            color: #722F37; /* Wine */
        }
        input[type="text"],
        input[type="email"],
        input[type="tel"],
        input[type="date"],
        select {
            width: 100%;
            padding: 12px;
            border: 2px solid #722F37; /* Wine */
            border-radius: 8px;
            font-size: 1rem;
            background: rgba(255, 255, 255, 0.9);
            color: #722F37; /* Wine */
        }
        input:focus, select:focus {
            outline: none;
            border-color: #5a2530; /* Darker Wine */
            box-shadow: 0 0 0 2px rgba(114, 47, 55, 0.2);
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
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .btn-primary {
            background: #722F37; /* Wine */
            color: #EFDFBB; /* Dutch White */
            border: 2px solid #722F37; /* Wine */
        }
        .btn-primary:hover {
            background: #5a2530; /* Darker Wine */
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(114, 47, 55, 0.2);
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
                <div class="step active">7</div>
                <div class="step">8</div>
            </div>
        </div>
        
        <div class="step-header">
            <div class="step-indicator">👤 STEP 7/8 — PROFILE DETAILS</div>
            <h1><i class="fas fa-user"></i> Profile Details</h1>
        </div>
        
        <form method="post" action="/pilgrim/accommodation/property/listing/step7" class="form-container">
            <div class="section-title">Account Holder Information</div>
            
            <div class="form-row">
                <div class="form-group">
                    <label><i class="fas fa-user"></i> First Name</label>
                    <input type="text" name="firstName" value="${user.firstName}" required placeholder="Enter your first name">
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-user"></i> Last Name</label>
                    <input type="text" name="lastName" value="${user.lastName}" required placeholder="Enter your last name">
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label><i class="fas fa-flag"></i> Nationality</label>
                    <input type="text" name="nationality" value="${user.nationality}" placeholder="Your nationality">
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
                    <input type="text" name="residenceCountry" value="${user.residenceCountry}" required placeholder="Your country of residence">
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-map"></i> State</label>
                    <input type="text" name="residenceState" value="${user.residenceState}" required placeholder="Your state/province">
                </div>
            </div>
            
            <div class="form-group">
                <label><i class="fas fa-city"></i> City</label>
                <input type="text" name="residenceCity" value="${user.residenceCity}" required placeholder="Your city">
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
                    <input type="tel" name="contactPhoneNumber" value="${user.contactPhoneNumber}" required placeholder="Your phone number">
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-envelope"></i> Email</label>
                    <input type="email" name="contactEmail" value="${user.contactEmail}" required placeholder="Your email address">
                </div>
            </div>
            
            <div class="btn-group">
                <a href="/pilgrim/accommodation/property/listing/step6" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back
                </a>
                <button type="submit" class="btn btn-primary">
                    Next Step <i class="fas fa-arrow-right"></i>
                </button>
            </div>
        </form>
    </div>
</body>
</html>