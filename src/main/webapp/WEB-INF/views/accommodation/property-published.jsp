<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Property Published - GlobalPiligrim Accommodation</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .success-container {
            background: white;
            border-radius: 20px;
            padding: 60px;
            max-width: 700px;
            width: 100%;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            text-align: center;
        }
        .success-icon {
            font-size: 5rem;
            color: #4caf50;
            margin-bottom: 30px;
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
            font-size: 2.5rem;
        }
        .status-message {
            background: #e8f5e9;
            padding: 20px;
            border-radius: 10px;
            margin: 30px 0;
            color: #2e7d32;
        }
        .reference-id {
            background: #f5f5f5;
            padding: 15px;
            border-radius: 8px;
            margin: 20px 0;
            font-size: 1.2rem;
            font-weight: bold;
            color: #667eea;
        }
        .info-message {
            color: #666;
            margin: 20px 0;
            line-height: 1.6;
        }
        .action-buttons {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-top: 40px;
        }
        .btn {
            padding: 15px 30px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s;
        }
        .btn-primary {
            background: #667eea;
            color: white;
        }
        .btn-primary:hover {
            background: #5568d3;
        }
        .btn-secondary {
            background: #e0e0e0;
            color: #333;
        }
        .btn-secondary:hover {
            background: #d0d0d0;
        }
    </style>
</head>
<body>
    <div class="success-container">
        <div class="success-icon">
            <i class="fas fa-check-circle"></i>
        </div>
        
        <h1>🎉 Publishing in Progress</h1>
        
        <div class="status-message">
            <i class="fas fa-hourglass-half"></i> We will review and notify you once the listing is live.
        </div>
        
        <c:if test="${not empty referenceId}">
            <div class="reference-id">
                <i class="fas fa-hashtag"></i> Reference ID: ${referenceId}
            </div>
        </c:if>
        
        <div class="info-message">
            <p>Your property listing has been submitted successfully!</p>
            <p>Our team will review your listing and you'll receive a notification once it's approved and live.</p>
        </div>
        
        <div class="action-buttons">
            <a href="/pilgrim/accommodation/property/type-selection" class="btn btn-primary">
                <i class="fas fa-plus"></i> Add New Listing
            </a>
            <a href="/pilgrim/accommodation/property/manage" class="btn btn-secondary">
                <i class="fas fa-cog"></i> Manage Listings
            </a>
            <a href="/pilgrim/accommodation/property/drafts" class="btn btn-secondary">
                <i class="fas fa-file-alt"></i> Complete Draft Listings
            </a>
        </div>
    </div>
</body>
</html>

