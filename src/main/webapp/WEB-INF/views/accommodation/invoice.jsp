<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice - ${booking.referenceNumber} - GlobalPiligrim Accommodation</title>
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
            padding: 20px;
        }
        .invoice-container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 40px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .invoice-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 40px;
            padding-bottom: 20px;
            border-bottom: 3px solid #667eea;
        }
        .logo-section h1 {
            color: #667eea;
            font-size: 2rem;
            margin-bottom: 5px;
        }
        .logo-section p {
            color: #666;
            font-size: 0.9rem;
        }
        .invoice-info {
            text-align: right;
        }
        .invoice-info h2 {
            color: #333;
            font-size: 1.5rem;
            margin-bottom: 10px;
        }
        .invoice-info p {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 5px;
        }
        .invoice-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 40px;
        }
        .detail-section h3 {
            color: #333;
            font-size: 1.1rem;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #e0e0e0;
        }
        .detail-item {
            margin-bottom: 10px;
        }
        .detail-label {
            color: #666;
            font-size: 0.9rem;
            display: block;
            margin-bottom: 3px;
        }
        .detail-value {
            color: #333;
            font-weight: 600;
        }
        .booking-items {
            margin-bottom: 40px;
        }
        .items-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .items-table th {
            background: #f9f9f9;
            padding: 12px;
            text-align: left;
            color: #333;
            font-weight: 600;
            border-bottom: 2px solid #e0e0e0;
        }
        .items-table td {
            padding: 12px;
            border-bottom: 1px solid #e0e0e0;
            color: #666;
        }
        .items-table tr:last-child td {
            border-bottom: none;
        }
        .text-right {
            text-align: right;
        }
        .text-bold {
            font-weight: 600;
            color: #333;
        }
        .total-section {
            background: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        .total-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            font-size: 1.1rem;
        }
        .total-row.grand-total {
            font-size: 1.5rem;
            font-weight: 700;
            color: #667eea;
            border-top: 2px solid #667eea;
            padding-top: 15px;
            margin-top: 10px;
        }
        .payment-info {
            background: #e8f5e9;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        .payment-info h3 {
            color: #2e7d32;
            margin-bottom: 10px;
        }
        .payment-info p {
            color: #1b5e20;
            margin-bottom: 5px;
        }
        .footer {
            text-align: center;
            color: #666;
            font-size: 0.85rem;
            margin-top: 40px;
            padding-top: 20px;
            border-top: 1px solid #e0e0e0;
        }
        .action-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 30px;
        }
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
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
        @media print {
            body {
                background: white;
                padding: 0;
            }
            .action-buttons {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="invoice-container">
        <div class="invoice-header">
            <div class="logo-section">
                <h1><i class="fas fa-building"></i> GlobalPiligrim Accommodation</h1>
                <p>Your trusted accommodation platform</p>
            </div>
            <div class="invoice-info">
                <h2>INVOICE</h2>
                <p><strong>Invoice #:</strong> ${booking.referenceNumber}</p>
                <p><strong>Date:</strong> ${booking.createdAt}</p>
                <p><strong>Status:</strong> ${booking.status}</p>
            </div>
        </div>

        <div class="invoice-details">
            <div class="detail-section">
                <h3>Booking Details</h3>
                <div class="detail-item">
                    <span class="detail-label">Property</span>
                    <span class="detail-value">
                        <c:choose>
                            <c:when test="${booking.property.details != null && booking.property.details.propertyName != null}">
                                ${booking.property.details.propertyName}
                            </c:when>
                            <c:otherwise>
                                Property #${booking.property.id}
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">Check-in Date</span>
                    <span class="detail-value">${booking.checkInDate}</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">Check-out Date</span>
                    <span class="detail-value">${booking.checkOutDate}</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">Number of Guests</span>
                    <span class="detail-value">${booking.numberOfGuests}</span>
                </div>
                <c:if test="${booking.numberOfRooms != null}">
                    <div class="detail-item">
                        <span class="detail-label">Number of Rooms</span>
                        <span class="detail-value">${booking.numberOfRooms}</span>
                    </div>
                </c:if>
            </div>
            
            <div class="detail-section">
                <h3>Guest Information</h3>
                <div class="detail-item">
                    <span class="detail-label">Name</span>
                    <span class="detail-value">${booking.user.fullName != null ? booking.user.fullName : booking.user.username}</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">Email</span>
                    <span class="detail-value">${booking.user.email}</span>
                </div>
                <c:if test="${booking.user.contactPhoneNumber != null}">
                    <div class="detail-item">
                        <span class="detail-label">Phone</span>
                        <span class="detail-value">${booking.user.countryCode != null ? booking.user.countryCode : ''} ${booking.user.contactPhoneNumber}</span>
                    </div>
                </c:if>
                <c:if test="${booking.property.location != null}">
                    <div class="detail-item">
                        <span class="detail-label">Property Location</span>
                        <span class="detail-value">
                            <c:choose>
                                <c:when test="${booking.property.location.streetAddress != null}">
                                    ${booking.property.location.streetAddress}<br>
                                </c:when>
                            </c:choose>
                            <c:choose>
                                <c:when test="${booking.property.location.city != null}">
                                    ${booking.property.location.city}
                                </c:when>
                            </c:choose>
                            <c:if test="${booking.property.location.state != null}">
                                , ${booking.property.location.state}
                            </c:if>
                            <c:if test="${booking.property.location.country != null}">
                                , ${booking.property.location.country}
                            </c:if>
                        </span>
                    </div>
                </c:if>
            </div>
        </div>

        <div class="booking-items">
            <h3 style="margin-bottom: 15px; color: #333;">Booking Summary</h3>
            <table class="items-table">
                <thead>
                    <tr>
                        <th>Description</th>
                        <th class="text-right">Amount</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            Accommodation
                            <c:if test="${booking.checkInDate != null && booking.checkOutDate != null}">
                                <br><small style="color: #999;">
                                    ${booking.checkInDate} to ${booking.checkOutDate}
                                </small>
                            </c:if>
                        </td>
                        <td class="text-right text-bold">₹${booking.totalAmount}</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="total-section">
            <div class="total-row">
                <span>Subtotal</span>
                <span>₹${booking.totalAmount}</span>
            </div>
            <div class="total-row">
                <span>Tax (Included)</span>
                <span>₹0.00</span>
            </div>
            <div class="total-row grand-total">
                <span>Total Amount</span>
                <span>₹${booking.totalAmount}</span>
            </div>
        </div>

        <c:if test="${payment != null}">
            <div class="payment-info">
                <h3><i class="fas fa-check-circle"></i> Payment Information</h3>
                <p><strong>Payment Method:</strong> ${fn:replace(fn:toLowerCase(payment.paymentMethod), '_', ' ')}</p>
                <p><strong>Transaction ID:</strong> ${payment.transactionId}</p>
                <p><strong>Payment Status:</strong> ${payment.status}</p>
                <p><strong>Paid Amount:</strong> ₹${payment.amount}</p>
                <p><strong>Payment Date:</strong> ${payment.processedAt != null ? payment.processedAt : payment.createdAt}</p>
            </div>
        </c:if>

        <div class="footer">
            <p>Thank you for choosing GlobalPiligrim Accommodation!</p>
            <p>For any queries, please contact us at support@globalpiligrim.com</p>
            <p style="margin-top: 10px; color: #999;">
                This is an auto-generated invoice. No signature required.
            </p>
        </div>

        <div class="action-buttons">
            <button onclick="window.print()" class="btn btn-primary">
                <i class="fas fa-print"></i> Print Invoice
            </button>
            <a href="/pilgrim/accommodation/user/bookings" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Back to Bookings
            </a>
        </div>
    </div>
</body>
</html>

