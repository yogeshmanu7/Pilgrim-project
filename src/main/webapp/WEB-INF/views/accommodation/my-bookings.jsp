<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings - GlobalPiligrim Accommodation</title>
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
        .nav-links {
            display: flex;
            gap: 20px;
            align-items: center;
        }
        .nav-links a {
            color: #333;
            text-decoration: none;
            font-weight: 500;
        }
        .nav-links a:hover {
            color: #667eea;
        }
        .btn-signin {
            background: #667eea;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
        }
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }
        .page-title {
            font-size: 2rem;
            color: #333;
            margin-bottom: 30px;
        }
        .bookings-list {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        .booking-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .booking-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #e0e0e0;
        }
        .booking-info h3 {
            color: #333;
            font-size: 1.3rem;
            margin-bottom: 8px;
        }
        .booking-ref {
            color: #666;
            font-size: 0.9rem;
        }
        .status-badge {
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
        }
        .status-badge.PENDING {
            background: #fff3cd;
            color: #856404;
        }
        .status-badge.CONFIRMED {
            background: #d4edda;
            color: #155724;
        }
        .status-badge.CANCELLED {
            background: #f8d7da;
            color: #721c24;
        }
        .status-badge.COMPLETED {
            background: #d1ecf1;
            color: #0c5460;
        }
        .booking-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }
        .detail-item {
            display: flex;
            flex-direction: column;
        }
        .detail-label {
            color: #666;
            font-size: 0.85rem;
            margin-bottom: 5px;
        }
        .detail-value {
            color: #333;
            font-weight: 600;
        }
        .booking-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            font-size: 0.9rem;
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
        .btn-danger {
            background: #f44336;
            color: white;
        }
        .btn-danger:hover {
            background: #d32f2f;
        }
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .empty-state i {
            font-size: 4rem;
            color: #ccc;
            margin-bottom: 20px;
        }
        .empty-state h3 {
            color: #666;
            margin-bottom: 10px;
        }
        .empty-state p {
            color: #999;
            margin-bottom: 30px;
        }
        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .cancel-form {
            display: inline;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1><i class="fas fa-building"></i> GlobalPiligrim Accommodation</h1>
        <div class="nav-links">
            <a href="/pilgrim/accommodation/">Home</a>
            <a href="/pilgrim/accommodation/property/manage">My Properties</a>
            <a href="/pilgrim/accommodation/property/type-selection" class="btn-signin">
                <i class="fas fa-plus"></i> Add New Listing
            </a>
            <a href="/pilgrim/accommodation/logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <h1 class="page-title"><i class="fas fa-calendar-check"></i> My Bookings</h1>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> ${success}
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>

        <c:choose>
            <c:when test="${not empty bookings && bookings.size() > 0}">
                <div class="bookings-list">
                    <c:forEach var="booking" items="${bookings}">
                        <div class="booking-card">
                            <div class="booking-header">
                                <div class="booking-info">
                                    <h3><c:choose><c:when test="${booking.property.details != null && booking.property.details.propertyName != null}">${booking.property.details.propertyName}</c:when><c:otherwise>Property #${booking.property.id}</c:otherwise></c:choose></h3>
                                    <div class="booking-ref">
                                        <i class="fas fa-hashtag"></i> Reference: ${booking.referenceNumber}
                                    </div>
                                </div>
                                <span class="status-badge ${booking.status}">${booking.status}</span>
                            </div>
                            
                            <div class="booking-details">
                                <div class="detail-item">
                                    <span class="detail-label"><i class="fas fa-calendar-check"></i> Check-in</span>
                                    <span class="detail-value">${booking.checkInDate}</span>
                                </div>
                                <div class="detail-item">
                                    <span class="detail-label"><i class="fas fa-calendar-times"></i> Check-out</span>
                                    <span class="detail-value">${booking.checkOutDate}</span>
                                </div>
                                <div class="detail-item">
                                    <span class="detail-label"><i class="fas fa-users"></i> Guests</span>
                                    <span class="detail-value">${booking.numberOfGuests}</span>
                                </div>
                                <c:if test="${booking.numberOfRooms != null}">
                                    <div class="detail-item">
                                        <span class="detail-label"><i class="fas fa-bed"></i> Rooms</span>
                                        <span class="detail-value">${booking.numberOfRooms}</span>
                                    </div>
                                </c:if>
                                <div class="detail-item">
                                    <span class="detail-label"><i class="fas fa-rupee-sign"></i> Total Amount</span>
                                    <span class="detail-value">₹${booking.totalAmount}</span>
                                </div>
                                <div class="detail-item">
                                    <span class="detail-label"><i class="fas fa-clock"></i> Booked On</span>
                                    <span class="detail-value">${booking.createdAt}</span>
                                </div>
                            </div>
                            
                            <c:if test="${booking.cancellationReason != null}">
                                <div style="background: #fff3cd; padding: 10px; border-radius: 8px; margin-bottom: 15px;">
                                    <strong>Cancellation Reason:</strong> ${booking.cancellationReason}
                                    <c:if test="${booking.cancelledAt != null}">
                                        <br><small>Cancelled on: ${booking.cancelledAt}</small>
                                    </c:if>
                                </div>
                            </c:if>
                            
                            <div class="booking-actions">
                                <c:if test="${booking.status == 'CONFIRMED' || booking.status == 'PENDING'}">
                                    <a href="/pilgrim/accommodation/user/booking/${booking.id}/edit" class="btn btn-primary">
                                        <i class="fas fa-edit"></i> Edit Booking
                                    </a>
                                    <form method="post" action="/pilgrim/accommodation/user/booking/${booking.id}/cancel" class="cancel-form" 
                                          onsubmit="return confirm('Are you sure you want to cancel this booking?');">
                                        <input type="hidden" name="reason" value="Cancelled by user">
                                        <button type="submit" class="btn btn-danger">
                                            <i class="fas fa-times"></i> Cancel Booking
                                        </button>
                                    </form>
                                </c:if>
                                
                                <c:if test="${booking.status == 'CONFIRMED' || booking.status == 'COMPLETED'}">
                                    <a href="/pilgrim/accommodation/user/booking/${booking.id}/invoice" class="btn btn-secondary">
                                        <i class="fas fa-file-invoice"></i> Download Invoice
                                    </a>
                                </c:if>
                                
                                <c:if test="${booking.status == 'COMPLETED'}">
                                    <a href="/pilgrim/accommodation/user/booking/${booking.id}/review" class="btn btn-primary">
                                        <i class="fas fa-star"></i> Rate & Review
                                    </a>
                                </c:if>
                                
                                <a href="/pilgrim/accommodation/property/view/${booking.property.id}" class="btn btn-secondary">
                                    <i class="fas fa-eye"></i> View Property
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <i class="fas fa-calendar-times"></i>
                    <h3>No Bookings Yet</h3>
                    <p>You haven't made any bookings. Start exploring properties and book your perfect stay!</p>
                    <a href="/pilgrim/accommodation/" class="btn btn-primary">
                        <i class="fas fa-search"></i> Search Properties
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>

