<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - GlobalPiligrim Accommodation</title>
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
        .container {
            max-width: 900px;
            margin: 30px auto;
            padding: 0 20px;
        }
        .payment-container {
            display: grid;
            grid-template-columns: 1fr 400px;
            gap: 30px;
        }
        .payment-form-section {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .booking-summary {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            height: fit-content;
            position: sticky;
            top: 20px;
        }
        .section-title {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #e0e0e0;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            color: #666;
            font-weight: 500;
            margin-bottom: 8px;
        }
        .form-group select,
        .form-group input {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
        }
        .form-group select:focus,
        .form-group input:focus {
            outline: none;
            border-color: #667eea;
        }
        .payment-method-options {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
            margin-top: 10px;
        }
        .payment-method-card {
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            padding: 15px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
        }
        .payment-method-card:hover {
            border-color: #667eea;
            background: #f5f5ff;
        }
        .payment-method-card input[type="radio"] {
            display: none;
        }
        .payment-method-card input[type="radio"]:checked + label {
            color: #667eea;
            font-weight: 600;
        }
        .payment-method-card input[type="radio"]:checked ~ .method-icon {
            color: #667eea;
        }
        .payment-method-card.selected {
            border-color: #667eea;
            background: #f5f5ff;
        }
        .method-icon {
            font-size: 2rem;
            color: #999;
            margin-bottom: 10px;
        }
        .method-label {
            font-size: 0.9rem;
            color: #666;
            display: block;
        }
        .summary-item {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #e0e0e0;
        }
        .summary-item:last-child {
            border-bottom: none;
        }
        .summary-label {
            color: #666;
        }
        .summary-value {
            color: #333;
            font-weight: 600;
        }
        .summary-total {
            font-size: 1.3rem;
            color: #667eea;
            font-weight: 700;
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
            width: 100%;
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
            margin-top: 10px;
        }
        .btn-secondary:hover {
            background: #d0d0d0;
        }
        .property-info {
            background: #f9f9f9;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
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
        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .alert-info {
            background: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }
    </style>
    <script>
        function selectPaymentMethod(method) {
            document.querySelectorAll('.payment-method-card').forEach(card => {
                card.classList.remove('selected');
            });
            event.currentTarget.classList.add('selected');
            document.getElementById('paymentMethod').value = method;
        }
    </script>
</head>
<body>
    <div class="header">
        <h1><i class="fas fa-building"></i> GlobalPiligrim Accommodation</h1>
        <div class="nav-links">
            <a href="/pilgrim/accommodation/">Home</a>
            <a href="/pilgrim/accommodation/user/dashboard">Dashboard</a>
            <a href="/pilgrim/accommodation/logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <c:if test="${not empty booking}">
            <div class="payment-container">
                <div class="payment-form-section">
                    <h2 class="section-title"><i class="fas fa-credit-card"></i> Payment Details</h2>
                    
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle"></i> This is a demo payment. Your booking will be confirmed after payment.
                    </div>
                    
                    <form method="post" action="/pilgrim/accommodation/user/payment/process">
                        <input type="hidden" name="bookingId" value="${booking.id}">
                        
                        <div class="form-group">
                            <label>Select Payment Method</label>
                            <div class="payment-method-options">
                                <c:forEach var="method" items="${paymentMethods}">
                                    <div class="payment-method-card" onclick="selectPaymentMethod('${method}')">
                                        <input type="radio" name="paymentMethod" value="${method}" id="method_${method}" required>
                                        <div class="method-icon">
                                            <c:choose>
                                                <c:when test="${method == 'CREDIT_CARD'}"><i class="fas fa-credit-card"></i></c:when>
                                                <c:when test="${method == 'DEBIT_CARD'}"><i class="fas fa-credit-card"></i></c:when>
                                                <c:when test="${method == 'UPI'}"><i class="fas fa-mobile-alt"></i></c:when>
                                                <c:when test="${method == 'NET_BANKING'}"><i class="fas fa-university"></i></c:when>
                                                <c:when test="${method == 'WALLET'}"><i class="fas fa-wallet"></i></c:when>
                                                <c:otherwise><i class="fas fa-money-bill"></i></c:otherwise>
                                            </c:choose>
                                        </div>
                                        <label for="method_${method}" class="method-label">
                                            ${fn:replace(fn:toLowerCase(method), '_', ' ')}
                                        </label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-lock"></i> Pay ₹${booking.totalAmount}
                        </button>
                    </form>
                </div>
                
                <div class="booking-summary">
                    <h3 class="section-title">Booking Summary</h3>
                    
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
                                <c:when test="${booking.property.location != null && booking.property.location.city != null}">
                                    ${booking.property.location.city}, ${booking.property.location.state}
                                </c:when>
                                <c:otherwise>
                                    Location not available
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                    
                    <div class="summary-item">
                        <span class="summary-label">Check-in</span>
                        <span class="summary-value">${booking.checkInDate}</span>
                    </div>
                    <div class="summary-item">
                        <span class="summary-label">Check-out</span>
                        <span class="summary-value">${booking.checkOutDate}</span>
                    </div>
                    <div class="summary-item">
                        <span class="summary-label">Guests</span>
                        <span class="summary-value">${booking.numberOfGuests}</span>
                    </div>
                    <c:if test="${booking.numberOfRooms != null}">
                        <div class="summary-item">
                            <span class="summary-label">Rooms</span>
                            <span class="summary-value">${booking.numberOfRooms}</span>
                        </div>
                    </c:if>
                    <div class="summary-item">
                        <span class="summary-label">Booking Reference</span>
                        <span class="summary-value">${booking.referenceNumber}</span>
                    </div>
                    
                    <div class="summary-item" style="margin-top: 20px; padding-top: 20px; border-top: 2px solid #e0e0e0;">
                        <span class="summary-label summary-total">Total Amount</span>
                        <span class="summary-value summary-total">₹${booking.totalAmount}</span>
                    </div>
                    
                    <div style="margin-top: 20px; padding-top: 20px; border-top: 2px solid #e0e0e0;">
                        <p style="color: #666; font-size: 0.85rem; text-align: center;">
                            <i class="fas fa-shield-alt"></i> Secure Payment
                        </p>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
</body>
</html>

