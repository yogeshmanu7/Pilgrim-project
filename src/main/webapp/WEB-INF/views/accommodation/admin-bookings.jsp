<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Management - Admin - GlobalPiligrim Accommodation</title>
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
        .nav-menu {
            background: white;
            padding: 15px 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .nav-menu ul {
            list-style: none;
            display: flex;
            gap: 30px;
        }
        .nav-menu a {
            color: #666;
            text-decoration: none;
            font-weight: 500;
            padding: 8px 0;
            border-bottom: 2px solid transparent;
        }
        .nav-menu a:hover,
        .nav-menu a.active {
            color: #667eea;
            border-bottom-color: #667eea;
        }
        .container {
            max-width: 1400px;
            margin: 30px auto;
            padding: 0 20px;
        }
        .filters {
            background: white;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
        }
        .filter-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .filter-group label {
            color: #666;
            font-weight: 500;
        }
        .filter-group select {
            padding: 8px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 0.95rem;
            cursor: pointer;
        }
        .filter-group select:focus {
            outline: none;
            border-color: #667eea;
        }
        .bookings-section {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }
        .section-header h2 {
            color: #333;
            font-size: 1.5rem;
        }
        .bookings-table {
            width: 100%;
            border-collapse: collapse;
        }
        .bookings-table thead {
            background: #f8f9fa;
        }
        .bookings-table th {
            padding: 15px;
            text-align: left;
            color: #666;
            font-weight: 600;
            border-bottom: 2px solid #e0e0e0;
        }
        .bookings-table td {
            padding: 15px;
            border-bottom: 1px solid #e0e0e0;
        }
        .bookings-table tbody tr:hover {
            background: #f8f9fa;
        }
        .booking-info {
            max-width: 200px;
        }
        .booking-info h4 {
            color: #333;
            margin-bottom: 5px;
        }
        .booking-info p {
            color: #666;
            font-size: 0.85rem;
            margin: 2px 0;
        }
        .amount {
            font-size: 1.1rem;
            font-weight: 700;
            color: #667eea;
        }
        .status-badge {
            padding: 6px 12px;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: 600;
            display: inline-block;
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
            background: #c8e6c9;
            color: #2e7d32;
        }
        .action-buttons {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.85rem;
            font-weight: 500;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s;
        }
        .btn-approve {
            background: #4caf50;
            color: white;
        }
        .btn-approve:hover {
            background: #388e3c;
        }
        .btn-reject {
            background: #f44336;
            color: white;
        }
        .btn-reject:hover {
            background: #d32f2f;
        }
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }
        .empty-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            color: #ccc;
        }
        .empty-state h3 {
            color: #666;
            margin-bottom: 10px;
        }
        .success-message {
            background: #e8f5e9;
            color: #2e7d32;
            padding: 12px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .error-message {
            background: #ffebee;
            color: #c62828;
            padding: 12px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .date-info {
            color: #666;
            font-size: 0.85rem;
        }
        .reference-number {
            color: #667eea;
            font-weight: 600;
            font-family: monospace;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1><i class="fas fa-shield-alt"></i> Admin Panel</h1>
        <div class="user-info">
            <span>Welcome, Admin</span>
            <a href="/pilgrim/accommodation/logout" style="color: #667eea; text-decoration: none;">Logout</a>
        </div>
    </div>
    
    <div class="nav-menu">
        <ul>
            <li><a href="/pilgrim/accommodation/admin/dashboard">Dashboard</a></li>
            <li><a href="/pilgrim/accommodation/admin/properties">Properties</a></li>
            <li><a href="/pilgrim/accommodation/admin/users">Users</a></li>
            <li><a href="/pilgrim/accommodation/admin/complaints">Complaints</a></li>
            <li><a href="/pilgrim/accommodation/admin/refunds">Refunds</a></li>
            <li><a href="/pilgrim/accommodation/admin/payouts">Payouts</a></li>
            <li><a href="/pilgrim/accommodation/admin/bookings" class="active">Bookings</a></li>
        </ul>
    </div>
    
    <div class="container">
        <c:if test="${not empty success}">
            <div class="success-message">
                <i class="fas fa-check-circle"></i> ${success}
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>
        
        <div class="filters">
            <div class="filter-group">
                <label for="statusFilter"><i class="fas fa-filter"></i> Filter by Status:</label>
                <select id="statusFilter" onchange="window.location.href='/pilgrim/accommodation/admin/bookings?status=' + this.value">
                    <option value="">All Bookings</option>
                    <option value="PENDING" ${currentStatus == 'PENDING' ? 'selected' : ''}>Pending</option>
                    <option value="CONFIRMED" ${currentStatus == 'CONFIRMED' ? 'selected' : ''}>Confirmed</option>
                    <option value="CANCELLED" ${currentStatus == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                    <option value="COMPLETED" ${currentStatus == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                </select>
            </div>
        </div>
        
        <div class="bookings-section">
            <div class="section-header">
                <h2><i class="fas fa-calendar-check"></i> Booking Management</h2>
                <span style="color: #666;">Total: ${fn:length(bookings)} bookings</span>
            </div>
            
            <c:choose>
                <c:when test="${not empty bookings}">
                    <table class="bookings-table">
                        <thead>
                            <tr>
                                <th>Reference</th>
                                <th>Guest/User</th>
                                <th>Property</th>
                                <th>Check-in</th>
                                <th>Check-out</th>
                                <th>Guests</th>
                                <th>Amount</th>
                                <th>Status</th>
                                <th>Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="booking" items="${bookings}">
                                <tr>
                                    <td>
                                        <span class="reference-number">${booking.referenceNumber != null ? booking.referenceNumber : 'N/A'}</span>
                                    </td>
                                    <td>
                                        <div class="booking-info">
                                            <c:choose>
                                                <c:when test="${booking.user != null}">
                                                    <h4>${booking.user.fullName}</h4>
                                                    <p>${booking.user.email}</p>
                                                </c:when>
                                                <c:when test="${booking.guestName != null}">
                                                    <h4>${booking.guestName}</h4>
                                                    <p>${booking.guestEmail}</p>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: #999;">N/A</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${booking.property != null}">
                                                <div class="booking-info">
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
                                                    <p>ID: ${booking.property.id}</p>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color: #999;">N/A</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="date-info">
                                            ${booking.checkInDate}
                                        </div>
                                    </td>
                                    <td>
                                        <div class="date-info">
                                            ${booking.checkOutDate}
                                        </div>
                                    </td>
                                    <td>${booking.numberOfGuests}</td>
                                    <td>
                                        <span class="amount">₹${booking.totalAmount}</span>
                                    </td>
                                    <td>
                                        <span class="status-badge ${booking.status}">${booking.status}</span>
                                    </td>
                                    <td>
                                        <div class="date-info">
                                            ${booking.createdAt}
                                        </div>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <c:if test="${booking.status == 'PENDING'}">
                                                <form method="post" action="/pilgrim/accommodation/admin/booking/${booking.id}/approve" style="display: inline;">
                                                    <button type="submit" class="btn btn-approve">
                                                        <i class="fas fa-check"></i> Approve
                                                    </button>
                                                </form>
                                                <form method="post" action="/pilgrim/accommodation/admin/booking/${booking.id}/reject" style="display: inline;" 
                                                      onsubmit="return confirm('Are you sure you want to reject this booking?');">
                                                    <button type="submit" class="btn btn-reject">
                                                        <i class="fas fa-times"></i> Reject
                                                    </button>
                                                </form>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-calendar-check"></i>
                        <h3>No Bookings Found</h3>
                        <p>There are no bookings matching the selected criteria.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>

