<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation - GlobalPiligrim Accommodation</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Poppins', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to bottom, rgba(248, 249, 250, 0.95) 0%, rgba(233, 236, 239, 0.95) 100%);
            background-image: url('https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&auto=format&fit=crop&w=2000&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            min-height: 100vh;
            position: relative;
        }
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.08) 0%, rgba(118, 75, 162, 0.08) 100%);
            z-index: -1;
        }
        .header {
            background: white;
            padding: 20px 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header h1 {
            color: #667eea;
            font-size: 1.5rem;
        }
        .container {
            max-width: 800px;
            margin: 30px auto;
            padding: 0 20px;
        }
        .confirmation-card {
            background: white;
            border-radius: 20px;
            padding: 50px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.15);
            text-align: center;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        .success-icon {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, #4caf50 0%, #45a049 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 25px;
            color: white;
            font-size: 3rem;
            box-shadow: 0 8px 25px rgba(76, 175, 80, 0.3);
            animation: successPulse 2s infinite;
        }
        @keyframes successPulse {
            0%, 100% {
                transform: scale(1);
                box-shadow: 0 8px 25px rgba(76, 175, 80, 0.3);
            }
            50% {
                transform: scale(1.05);
                box-shadow: 0 12px 35px rgba(76, 175, 80, 0.5);
            }
        }
        .confirmation-title {
            font-size: 2rem;
            color: #333;
            margin-bottom: 10px;
        }
        .confirmation-message {
            color: #666;
            font-size: 1.1rem;
            margin-bottom: 30px;
        }
        .booking-details {
            background: #f9f9f9;
            border-radius: 8px;
            padding: 25px;
            margin: 30px 0;
            text-align: left;
        }
        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #e0e0e0;
        }
        .detail-row:last-child {
            border-bottom: none;
        }
        .detail-label {
            color: #666;
            font-weight: 500;
        }
        .detail-value {
            color: #333;
            font-weight: 600;
        }
        .reference-number {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 18px 35px;
            border-radius: 12px;
            font-size: 1.3rem;
            font-weight: 700;
            margin: 25px 0;
            display: inline-block;
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.3);
            letter-spacing: 1px;
        }
        .property-info {
            background: white;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            padding: 20px;
            margin: 20px 0;
            text-align: left;
        }
        .property-info h4 {
            color: #333;
            margin-bottom: 10px;
        }
        .property-info p {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 5px;
        }
        .btn {
            padding: 15px 30px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            transition: all 0.3s;
            margin: 10px;
        }
        .btn-primary {
            background: #667eea;
            color: white;
            font-weight: 600;
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
        .info-box {
            background: #d1ecf1;
            border: 1px solid #bee5eb;
            border-radius: 8px;
            padding: 15px;
            margin: 20px 0;
            color: #0c5460;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1><i class="fas fa-building"></i> GlobalPiligrim Accommodation</h1>
        <a href="/pilgrim/accommodation/" style="color: #667eea; text-decoration: none; font-weight: 500;">
            <i class="fas fa-home"></i> Home
        </a>
    </div>

    <div class="container">
        <c:if test="${not empty booking}">
            <div class="confirmation-card">
                <div class="success-icon">
                    <i class="fas fa-check"></i>
                </div>
                <h2 class="confirmation-title">Booking Confirmed!</h2>
                <p class="confirmation-message">Your booking has been successfully confirmed.</p>
                
                <div class="reference-number">
                    Reference: ${booking.referenceNumber}
                </div>
                
                <div class="info-box">
                    <i class="fas fa-info-circle"></i> 
                    Please save your booking reference number for future reference. 
                    <c:if test="${booking.guestEmail != null}">
                        A confirmation email has been sent to ${booking.guestEmail}.
                    </c:if>
                </div>
                
                <div class="booking-details">
                    <h3 style="margin-bottom: 20px; color: #333;">Booking Details</h3>
                    
                    <div class="property-info">
                        <h4>
                            <c:choose>
                                <c:when test="${booking.property.details != null && booking.property.details.propertyName != null}">
                                    ${booking.property.details.propertyName}
                                </c:when>
                                <c:otherwise>
                                    Property #${booking.property.id}
                                </c:otherwise>
                            </c:choose>
                        </h4>
                        <p><i class="fas fa-map-marker-alt"></i> 
                            <c:choose>
                                <c:when test="${booking.property.location != null}">
                                    ${booking.property.location.streetAddress != null ? booking.property.location.streetAddress : ''}
                                    ${booking.property.location.city != null ? booking.property.location.city : ''}
                                    ${booking.property.location.state != null ? booking.property.location.state : ''}
                                    ${booking.property.location.country != null ? booking.property.location.country : ''}
                                </c:when>
                                <c:otherwise>
                                    Location not available
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                    
                    <div class="detail-row">
                        <span class="detail-label">Check-in Date</span>
                        <span class="detail-value">${booking.checkInDate}</span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Check-out Date</span>
                        <span class="detail-value">${booking.checkOutDate}</span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Number of Guests</span>
                        <span class="detail-value">${booking.numberOfGuests}</span>
                    </div>
                    <c:if test="${booking.numberOfRooms != null}">
                        <div class="detail-row">
                            <span class="detail-label">Number of Rooms</span>
                            <span class="detail-value">${booking.numberOfRooms}</span>
                        </div>
                    </c:if>
                    <c:if test="${booking.guestName != null}">
                        <div class="detail-row">
                            <span class="detail-label">Guest Name</span>
                            <span class="detail-value">${booking.guestName}</span>
                        </div>
                    </c:if>
                    <c:if test="${booking.guestEmail != null}">
                        <div class="detail-row">
                            <span class="detail-label">Email</span>
                            <span class="detail-value">${booking.guestEmail}</span>
                        </div>
                    </c:if>
                    <c:if test="${booking.guestPhone != null}">
                        <div class="detail-row">
                            <span class="detail-label">Phone</span>
                            <span class="detail-value">${booking.guestPhone}</span>
                        </div>
                    </c:if>
                    <div class="detail-row" style="margin-top: 20px; padding-top: 20px; border-top: 3px solid #667eea; background: linear-gradient(135deg, rgba(102, 126, 234, 0.05) 0%, rgba(118, 75, 162, 0.05) 100%); padding: 20px; border-radius: 12px;">
                        <span class="detail-label" style="font-size: 1.4rem; color: #667eea; font-weight: 700;">Total Amount</span>
                        <span class="detail-value" style="font-size: 1.6rem; color: #667eea; font-weight: 800;">₹${booking.totalAmount}</span>
                    </div>
                </div>
                
                <div style="margin-top: 30px;">
                    <a href="/pilgrim/accommodation/" class="btn btn-primary">
                        <i class="fas fa-home"></i> Back to Home
                    </a>
                    <a href="/pilgrim/accommodation/user/search" class="btn btn-secondary">
                        <i class="fas fa-search"></i> Search More Properties
                    </a>
                </div>
            </div>
        </c:if>
    </div>
</body>
</html>

