<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard - GlobalPiligrim Accommodation</title>
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
        }
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(248, 249, 250, 0.85);
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
        .nav-links span {
            color: #667eea;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
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
        .welcome-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 12px;
            padding: 40px;
            color: white;
            margin-bottom: 30px;
        }
        .welcome-section h2 {
            font-size: 2rem;
            margin-bottom: 10px;
        }
        .welcome-section p {
            font-size: 1.1rem;
            opacity: 0.9;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: white;
        }
        .stat-icon.properties {
            background: #667eea;
        }
        .stat-icon.bookings {
            background: #4caf50;
        }
        .stat-icon.reviews {
            background: #ff9800;
        }
        .stat-info h3 {
            font-size: 2rem;
            color: #333;
            margin-bottom: 5px;
        }
        .stat-info p {
            color: #666;
            font-size: 0.9rem;
        }
        .section {
            background: white;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            margin-bottom: 30px;
            transition: box-shadow 0.3s;
        }
        .section:hover {
            box-shadow: 0 6px 30px rgba(0,0,0,0.12);
        }
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #e0e0e0;
        }
        .section-title {
            font-size: 1.5rem;
            color: #333;
        }
        .btn {
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 0.9rem;
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
        .list-item {
            padding: 15px;
            border-bottom: 1px solid #e0e0e0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .list-item:last-child {
            border-bottom: none;
        }
        .list-item-info h4 {
            color: #333;
            margin-bottom: 5px;
        }
        .list-item-info p {
            color: #666;
            font-size: 0.85rem;
        }
        .status-badge {
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 500;
        }
        .status-badge.CONFIRMED {
            background: #d4edda;
            color: #155724;
        }
        .status-badge.PENDING {
            background: #fff3cd;
            color: #856404;
        }
        .status-badge.CANCELLED {
            background: #f8d7da;
            color: #721c24;
        }
        .status-badge.COMPLETED {
            background: #d1ecf1;
            color: #0c5460;
        }
        .empty-state {
            text-align: center;
            padding: 40px;
            color: #999;
        }
        .empty-state i {
            font-size: 3rem;
            margin-bottom: 10px;
        }
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-top: 20px;
        }
        .quick-action-card {
            background: #f9f9f9;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            transition: all 0.3s;
            cursor: pointer;
            text-decoration: none;
            color: #333;
        }
        .quick-action-card:hover {
            background: #667eea;
            color: white;
            transform: translateY(-3px);
        }
        .quick-action-card i {
            font-size: 2rem;
            margin-bottom: 10px;
        }
        .quick-action-card h4 {
            font-size: 1rem;
            margin-bottom: 5px;
        }
        .quick-action-card p {
            font-size: 0.85rem;
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1><i class="fas fa-building"></i> GlobalPiligrim Accommodation</h1>
        <div class="nav-links">
            <a href="/pilgrim/accommodation">Home</a>
            <a href="/pilgrim/accommodation/user/search">Search</a>
            <a href="/pilgrim/accommodation/user/bookings">My Bookings</a>
            <a href="/pilgrim/accommodation/property/manage">My Properties</a>
            <a href="/pilgrim/accommodation/property/type-selection" class="btn-signin">
                <i class="fas fa-plus"></i> Add New Listing
            </a>
            <span style="color: #667eea; font-weight: 600; padding: 0 15px; display: flex; align-items: center; gap: 8px;">
                <i class="fas fa-user-circle"></i> ${user.fullName != null && !user.fullName.isEmpty() ? user.fullName : user.username}
            </span>
            <a href="/pilgrim/accommodation/logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <div class="welcome-section">
            <h2>Welcome back, <span style="text-transform: capitalize;">${user.fullName != null && !user.fullName.isEmpty() ? user.fullName : user.username}</span>!</h2>
            <p><i class="fas fa-envelope"></i> ${user.email} | <i class="fas fa-phone"></i> ${user.phoneNumber != null ? user.phoneNumber : 'Not provided'}</p>
            <p style="margin-top: 10px; opacity: 0.95;">Manage your properties, bookings, and reviews from your dashboard</p>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon properties">
                    <i class="fas fa-home"></i>
                </div>
                <div class="stat-info">
                    <h3>${totalProperties}</h3>
                    <p>Properties Listed</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon bookings">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <div class="stat-info">
                    <h3>${totalBookings}</h3>
                    <p>Total Bookings</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon reviews">
                    <i class="fas fa-star"></i>
                </div>
                <div class="stat-info">
                    <h3>0</h3>
                    <p>Reviews Given</p>
                </div>
            </div>
        </div>

        <div class="section">
            <div class="section-header">
                <h3 class="section-title"><i class="fas fa-bolt"></i> Quick Actions</h3>
            </div>
            <div class="quick-actions">
                <a href="/pilgrim/accommodation/property/type-selection" class="quick-action-card">
                    <i class="fas fa-plus-circle"></i>
                    <h4>Add Property</h4>
                    <p>List a new property</p>
                </a>
                <a href="/pilgrim/accommodation/user/bookings" class="quick-action-card">
                    <i class="fas fa-calendar-alt"></i>
                    <h4>My Bookings</h4>
                    <p>View all bookings</p>
                </a>
                <a href="/pilgrim/accommodation/property/manage" class="quick-action-card">
                    <i class="fas fa-cog"></i>
                    <h4>Manage Properties</h4>
                    <p>Edit your listings</p>
                </a>
                <a href="/pilgrim/accommodation/user/search" class="quick-action-card">
                    <i class="fas fa-search"></i>
                    <h4>Search Properties</h4>
                    <p>Find accommodations</p>
                </a>
            </div>
        </div>

        <!-- Bookings Section -->
        <div class="section">
            <div class="section-header">
                <h3 class="section-title"><i class="fas fa-calendar-check"></i> My Bookings</h3>
                <div>
                    <a href="/pilgrim/accommodation/user/bookings" class="btn btn-secondary">View All</a>
                    <a href="/pilgrim/accommodation/user/search" class="btn btn-primary" style="margin-left: 10px;">
                        <i class="fas fa-search"></i> Book Now
                    </a>
                </div>
            </div>
            <c:choose>
                <c:when test="${not empty recentBookings && recentBookings.size() > 0}">
                    <c:forEach var="booking" items="${recentBookings}">
                        <div class="list-item">
                            <div class="list-item-info">
                                <h4><c:choose><c:when test="${booking.property.details != null && booking.property.details.propertyName != null}">${booking.property.details.propertyName}</c:when><c:otherwise>Property #${booking.property.id}</c:otherwise></c:choose></h4>
                                <p>
                                    <i class="fas fa-calendar"></i> ${booking.checkInDate} - ${booking.checkOutDate} | 
                                    <i class="fas fa-users"></i> ${booking.numberOfGuests} guests | 
                                    <i class="fas fa-rupee-sign"></i> ₹${booking.totalAmount}
                                </p>
                            </div>
                            <div>
                                <span class="status-badge ${booking.status}">${booking.status}</span>
                                <a href="/pilgrim/accommodation/user/bookings" class="btn btn-secondary" style="margin-left: 10px;">
                                    <i class="fas fa-eye"></i> View
                                </a>
                                <c:if test="${booking.status == 'CONFIRMED' || booking.status == 'PENDING'}">
                                    <a href="/pilgrim/accommodation/user/booking/${booking.id}/edit" class="btn btn-primary" style="margin-left: 10px;">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-calendar-times"></i>
                        <p>No bookings yet. Start exploring properties!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Properties Section -->
        <div class="section">
            <div class="section-header">
                <h3 class="section-title"><i class="fas fa-home"></i> My Properties</h3>
                <div>
                    <a href="/pilgrim/accommodation/property/manage" class="btn btn-secondary">View All</a>
                    <a href="/pilgrim/accommodation/property/type-selection" class="btn btn-primary" style="margin-left: 10px;">
                        <i class="fas fa-plus"></i> List Property
                    </a>
                </div>
            </div>
            <c:choose>
                <c:when test="${not empty properties && properties.size() > 0}">
                    <c:forEach var="property" items="${properties}">
                        <div class="list-item">
                            <div class="list-item-info">
                                <h4><c:choose><c:when test="${property.details != null && property.details.propertyName != null}">${property.details.propertyName}</c:when><c:otherwise>Property #${property.id}</c:otherwise></c:choose></h4>
                                <p>
                                    <c:choose>
                                        <c:when test="${property.location != null && property.location.city != null}">
                                            <i class="fas fa-map-marker-alt"></i> ${property.location.city}
                                        </c:when>
                                        <c:otherwise>
                                            Location not set
                                        </c:otherwise>
                                    </c:choose>
                                    | Status: <strong>${property.status}</strong>
                                </p>
                            </div>
                            <div>
                                <a href="/pilgrim/accommodation/property/view/${property.id}" class="btn btn-primary">View</a>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-home"></i>
                        <p>No properties listed yet. Add your first property!</p>
                        <a href="/pilgrim/accommodation/property/type-selection" class="btn btn-primary" style="margin-top: 15px;">
                            <i class="fas fa-plus"></i> List Your Property
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>

