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
            background: #EFDFBB; /* Dutch White - CHANGED */
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .success-container {
            background: #EFDFBB; /* Dutch White - CHANGED */
            border: 3px solid #722F37; /* Wine - CHANGED */
            border-radius: 20px;
            padding: 60px;
            max-width: 700px;
            width: 100%;
            box-shadow: 0 10px 40px rgba(114, 47, 55, 0.2); /* Wine with opacity - CHANGED */
            text-align: center;
        }
        .success-icon {
            font-size: 5rem;
            color: #722F37; /* Wine - CHANGED */
            margin-bottom: 30px;
        }
        h1 {
            color: #722F37; /* Wine - CHANGED */
            margin-bottom: 20px;
            font-size: 2.5rem;
        }
        .status-message {
            background: rgba(114, 47, 55, 0.1); /* Wine with opacity - CHANGED */
            padding: 20px;
            border-radius: 10px;
            margin: 30px 0;
            color: #722F37; /* Wine - CHANGED */
            border: 2px solid #722F37; /* Wine - CHANGED */
        }
        .status-message i {
            color: #722F37; /* Wine - CHANGED */
            margin-right: 10px;
        }
        .reference-id {
            background: rgba(114, 47, 55, 0.05); /* Wine with very low opacity - CHANGED */
            padding: 15px;
            border-radius: 8px;
            margin: 20px 0;
            font-size: 1.2rem;
            font-weight: bold;
            color: #722F37; /* Wine - CHANGED */
            border: 2px dashed #722F37; /* Wine - CHANGED */
        }
        .reference-id i {
            color: #722F37; /* Wine - CHANGED */
            margin-right: 10px;
        }
        .info-message {
            color: #722F37; /* Wine - CHANGED */
            margin: 20px 0;
            line-height: 1.6;
            opacity: 0.9;
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
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            font-weight: 500;
        }
        .btn-primary {
            background: #722F37; /* Wine - CHANGED */
            color: #EFDFBB; /* Dutch White - CHANGED */
            border: 2px solid #722F37; /* Wine - CHANGED */
        }
        .btn-primary:hover {
            background: #5a2530; /* Darker Wine - CHANGED */
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(114, 47, 55, 0.3); /* Wine with opacity - CHANGED */
        }
        .btn-secondary {
            background: #EFDFBB; /* Dutch White - CHANGED */
            color: #722F37; /* Wine - CHANGED */
            border: 2px solid #722F37; /* Wine - CHANGED */
        }
        .btn-secondary:hover {
            background: #722F37; /* Wine - CHANGED */
            color: #EFDFBB; /* Dutch White - CHANGED */
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(114, 47, 55, 0.2); /* Wine with opacity - CHANGED */
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