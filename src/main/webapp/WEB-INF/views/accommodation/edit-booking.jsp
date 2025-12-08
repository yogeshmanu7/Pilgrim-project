<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Booking - GlobalPiligrim Accommodation</title>
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
            background: linear-gradient(to bottom, #f8f9fa 0%, #e9ecef 100%);
            min-height: 100vh;
            background-image: url('https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&auto=format&fit=crop&w=2000&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            background-blend-mode: overlay;
            padding: 20px;
        }
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(248, 249, 250, 0.9);
            z-index: -1;
        }
        .header {
            background: white;
            padding: 20px 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            border-radius: 12px;
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
        .container {
            max-width: 900px;
            margin: 0 auto;
        }
        .edit-booking-card {
            background: white;
            border-radius: 16px;
            padding: 40px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }
        .page-title {
            font-size: 2rem;
            color: #333;
            margin-bottom: 10px;
        }
        .page-subtitle {
            color: #666;
            margin-bottom: 30px;
        }
        .property-info {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 30px;
        }
        .property-info h3 {
            color: #333;
            margin-bottom: 10px;
        }
        .property-info p {
            color: #666;
            margin: 5px 0;
        }
        .form-group {
            margin-bottom: 25px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
        }
        input[type="date"],
        input[type="number"],
        select {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s;
            font-family: 'Poppins', sans-serif;
        }
        input:focus,
        select:focus {
            outline: none;
            border-color: #667eea;
        }
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .btn-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s;
            font-weight: 500;
        }
        .btn-primary {
            background: #667eea;
            color: white;
        }
        .btn-primary:hover {
            background: #5568d3;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }
        .btn-secondary {
            background: #e0e0e0;
            color: #333;
        }
        .btn-secondary:hover {
            background: #d0d0d0;
        }
        .booking-summary {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 12px;
            margin-top: 20px;
        }
        .booking-summary h4 {
            color: #333;
            margin-bottom: 15px;
        }
        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #e0e0e0;
        }
        .summary-row:last-child {
            border-bottom: none;
            font-weight: 600;
            font-size: 1.1rem;
            color: #667eea;
        }
        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
            }
            .btn-group {
                flex-direction: column;
            }
            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1><i class="fas fa-building"></i> GlobalPiligrim Accommodation</h1>
        <div class="nav-links">
            <a href="/pilgrim/accommodation/user/dashboard">Dashboard</a>
            <a href="/pilgrim/accommodation/user/bookings">My Bookings</a>
            <a href="/pilgrim/accommodation/logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <div class="edit-booking-card">
            <h2 class="page-title"><i class="fas fa-edit"></i> Edit Booking</h2>
            <p class="page-subtitle">Update your booking details</p>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>
            
            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> ${success}
                </div>
            </c:if>

            <div class="property-info">
                <h3>
                    <c:choose>
                        <c:when test="${booking.property.details != null && booking.property.details.propertyName != null}">
                            ${booking.property.details.propertyName}
                        </c:when>
                        <c:otherwise>
                            Property #${booking.property.id}
                        </c:otherwise>
                    </c:choose>
                </h3>
                <p><i class="fas fa-hashtag"></i> Reference: ${booking.referenceNumber}</p>
                <p><i class="fas fa-info-circle"></i> Status: <strong>${booking.status}</strong></p>
            </div>

            <form method="post" action="/pilgrim/accommodation/user/booking/${booking.id}/edit">
                <div class="form-row">
                    <div class="form-group">
                        <label><i class="fas fa-calendar-check"></i> Check-in Date</label>
                        <input type="date" name="checkInDate" value="${booking.checkInDate}" required>
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-calendar-times"></i> Check-out Date</label>
                        <input type="date" name="checkOutDate" value="${booking.checkOutDate}" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label><i class="fas fa-users"></i> Number of Guests</label>
                        <input type="number" name="numberOfGuests" value="${booking.numberOfGuests}" min="1" required>
                    </div>
                    <c:if test="${not empty rooms && rooms.size() > 0}">
                        <div class="form-group">
                            <label><i class="fas fa-bed"></i> Room</label>
                            <select name="roomId">
                                <c:forEach var="room" items="${rooms}">
                                    <option value="${room.id}">
                                        ${room.roomType} - ₹${room.minimumRoomRate}/night
                                        <c:if test="${room.totalOccupancy != null}">
                                            (Max ${room.totalOccupancy} guests)
                                        </c:if>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </c:if>
                </div>

                <div class="booking-summary">
                    <h4><i class="fas fa-calculator"></i> Booking Summary</h4>
                    <div class="summary-row">
                        <span>Current Total:</span>
                        <span>₹${booking.totalAmount}</span>
                    </div>
                    <div class="summary-row">
                        <span>Note:</span>
                        <span>Total will be recalculated after update</span>
                    </div>
                </div>

                <div class="btn-group">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Update Booking
                    </button>
                    <a href="/pilgrim/accommodation/user/bookings" class="btn btn-secondary">
                        <i class="fas fa-times"></i> Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Set minimum date to today
        const today = new Date().toISOString().split('T')[0];
        document.querySelector('input[name="checkInDate"]').setAttribute('min', today);
        document.querySelector('input[name="checkOutDate"]').setAttribute('min', today);
        
        // Update check-out minimum date when check-in changes
        document.querySelector('input[name="checkInDate"]').addEventListener('change', function() {
            const checkInDate = this.value;
            const checkOutInput = document.querySelector('input[name="checkOutDate"]');
            if (checkInDate) {
                const nextDay = new Date(checkInDate);
                nextDay.setDate(nextDay.getDate() + 1);
                checkOutInput.setAttribute('min', nextDay.toISOString().split('T')[0]);
            }
        });
    </script>
</body>
</html>

