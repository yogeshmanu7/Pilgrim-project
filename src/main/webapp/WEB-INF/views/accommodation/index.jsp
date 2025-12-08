<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.time.LocalDate" %>
<%
    String today = LocalDate.now().toString();
    pageContext.setAttribute("today", today);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GlobalPiligrim Accommodation - Find Your Perfect Stay</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Poppins', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
        }
        .navbar {
            background: white;
            padding: 15px 30px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .navbar .logo {
            font-size: 1.5rem;
            font-weight: bold;
            color: #667eea;
        }
        .navbar .nav-links {
            display: flex;
            gap: 25px;
            align-items: center;
        }
        .navbar .nav-links a {
            color: #333;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s;
        }
        .navbar .nav-links a:hover {
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
        .btn-signin:hover {
            background: #5568d3;
        }
        .btn-search {
            background: #4caf50;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
        }
        .btn-search:hover {
            background: #45a049;
        }
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 80px 30px;
            text-align: center;
            color: white;
        }
        .hero-section h1 {
            font-size: 3rem;
            margin-bottom: 15px;
        }
        .hero-section p {
            font-size: 1.2rem;
            opacity: 0.9;
            margin-bottom: 30px;
        }
        .search-box {
            max-width: 1000px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.2);
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr auto;
            gap: 10px;
        }
        .search-box input {
            padding: 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
        }
        .search-box input:focus {
            outline: none;
            border-color: #667eea;
        }
        .search-box button {
            padding: 15px 30px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
        }
        .container {
            max-width: 1400px;
            margin: 50px auto;
            padding: 0 20px;
        }
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        .section-header h2 {
            color: #333;
            font-size: 2rem;
        }
        .properties-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 30px;
        }
        .property-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            cursor: pointer;
        }
        .property-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 20px rgba(0,0,0,0.15);
        }
        .property-image {
            width: 100%;
            height: 220px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 3rem;
            position: relative;
        }
        .property-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .property-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: rgba(255,255,255,0.9);
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            color: #667eea;
        }
        .property-content {
            padding: 20px;
        }
        .property-name {
            font-size: 1.3rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
        }
        .action-card {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 15px;
            text-align: center;
            border: 1px solid #e0e0e0;
        }
        .action-icon {
            width: 50px;
            height: 50px;
            background: #667eea;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            color: white;
            font-size: 1.5rem;
        }
        .action-card h3 {
            color: #333;
            font-size: 1.1rem;
            margin-bottom: 8px;
            font-weight: 600;
        }
        .action-card p {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 15px;
        }
        .btn-primary {
            background: #667eea;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: background 0.3s;
        }
        .btn-primary:hover {
            background: #5568d3;
        }
        .btn-primary i {
            font-size: 0.9rem;
        }
        .property-details {
            display: flex;
            gap: 20px;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #e0e0e0;
        }
        .property-detail-item {
            display: flex;
            align-items: center;
            gap: 5px;
            color: #666;
            font-size: 0.9rem;
        }
        .property-detail-item i {
            color: #667eea;
        }
        .property-rating {
            display: flex;
            align-items: center;
            gap: 5px;
            margin-bottom: 15px;
        }
        .property-rating .stars {
            color: #ffc107;
        }
        .property-rating .rating-text {
            color: #666;
            font-size: 0.9rem;
        }
        .property-price {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .price {
            font-size: 1.5rem;
            font-weight: bold;
            color: #667eea;
        }
        .price-period {
            color: #666;
            font-size: 0.9rem;
        }
        .btn-view {
            background: #667eea;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            transition: background 0.3s;
        }
        .btn-view:hover {
            background: #5568d3;
        }
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            background: white;
            border-radius: 12px;
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
        }
        .btn-list-property {
            background: #667eea;
            color: white;
            padding: 12px 30px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            display: inline-block;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="logo">
            <i class="fas fa-home"></i> GlobalPiligrim Accommodation
        </div>
        <div class="nav-links">
            <a href="/accommodation">Home</a>
            <c:choose>
                <c:when test="${sessionScope.accommodationUserId != null}">
                    <a href="/accommodation/user/search" class="btn-search"><i class="fas fa-search"></i> Search</a>
                    <a href="/accommodation/user/bookings">My Bookings</a>
                    <a href="/accommodation/property/manage">My Properties</a>
                    <a href="/accommodation/property/type-selection" class="btn-signin">
                        <i class="fas fa-plus"></i> List Property
                    </a>
                    <a href="/accommodation/logout">Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="/accommodation/signin">Sign In</a>
                    <a href="/accommodation/signup" class="btn-signin">List Your Property</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>
    
    <div class="hero-section">
        <h1>Find Your Perfect Stay</h1>
        <p>Discover amazing accommodations around the world</p>
        <c:choose>
            <c:when test="${sessionScope.accommodationUserId != null}">
                <form method="get" action="/accommodation/user/search" class="search-box">
                    <input type="text" name="location" placeholder="Where are you going?" value="${param.location}">
                    <input type="date" name="checkIn" placeholder="Check-in" value="${param.checkIn}" min="${today}">
                    <input type="date" name="checkOut" placeholder="Check-out" value="${param.checkOut}" min="${param.checkIn != null ? param.checkIn : today}">
                    <input type="number" name="guests" placeholder="Guests" value="${param.guests}" min="1">
                    <button type="submit"><i class="fas fa-search"></i> Search</button>
                </form>
            </c:when>
            <c:otherwise>
                <div class="search-box" style="display: flex; flex-direction: column; align-items: center; gap: 20px; padding: 40px;">
                    <div style="text-align: center; color: white;">
                        <i class="fas fa-lock" style="font-size: 3rem; margin-bottom: 15px; opacity: 0.9;"></i>
                        <h2 style="margin-bottom: 10px; font-size: 1.5rem;">Sign in to search properties</h2>
                        <p style="opacity: 0.9; margin-bottom: 20px;">Please sign in or create an account to search and book properties</p>
                    </div>
                    <div style="display: flex; gap: 15px;">
                        <a href="/accommodation/signin" style="padding: 15px 40px; background: white; color: #667eea; border-radius: 8px; text-decoration: none; font-weight: 600; font-size: 1.1rem; transition: transform 0.3s;">
                            <i class="fas fa-sign-in-alt"></i> Sign In
                        </a>
                        <a href="/accommodation/signup" style="padding: 15px 40px; background: rgba(255,255,255,0.2); color: white; border: 2px solid white; border-radius: 8px; text-decoration: none; font-weight: 600; font-size: 1.1rem; transition: transform 0.3s;">
                            <i class="fas fa-user-plus"></i> Sign Up
                        </a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <div class="container">
        <div class="section-header">
            <h2>Available Properties</h2>
            <span style="color: #666;">${properties.size()} properties available</span>
        </div>
        
        <c:choose>
            <c:when test="${not empty properties}">
                <div class="properties-grid">
                    <c:forEach var="property" items="${properties}">
                        <div class="property-card" onclick="window.location.href='/accommodation/property/view/${property.id}'">
                            <div class="property-image">
                                <c:choose>
                                    <c:when test="${not empty property.photos && property.photos.size() > 0}">
                                        <img src="/pilgrim/uploads/${property.photos[0].filePath}" alt="${property.details != null ? property.details.propertyName : 'Property'}">
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-building"></i>
                                    </c:otherwise>
                                </c:choose>
                                <div class="property-badge">
                                    <c:choose>
                                        <c:when test="${property.hotelType != null}">${property.hotelType}</c:when>
                                        <c:when test="${property.homeType != null}">${property.homeType}</c:when>
                                        <c:when test="${property.uniqueType != null}">${property.uniqueType}</c:when>
                                        <c:otherwise>${property.propertyType}</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="property-content">
                                <div class="property-name">
                                    <c:choose><c:when test="${property.details != null && property.details.propertyName != null}">${property.details.propertyName}</c:when><c:otherwise>Property #${property.id}</c:otherwise></c:choose>
                                </div>
                                
                                <!-- Map Directions -->
                                <div class="action-card">
                                    <div class="action-icon">
                                        <i class="fas fa-map-marked-alt"></i>
                                    </div>
                                    <h3>Get Directions</h3>
                                    <p>View property location on Google Maps</p>
                                    <c:choose>
                                        <c:when test="${property.location != null && property.location.latitude != null && property.location.longitude != null}">
                                            <c:set var="location" value="${property.location.latitude},${property.location.longitude}" />
                                            <%
                                                String location = (String) pageContext.getAttribute("location");
                                                if (location != null && !location.trim().isEmpty()) {
                                                    String encodedLocation = URLEncoder.encode(location, "UTF-8");
                                            %>
                                                <a href="https://www.google.com/maps/dir/?api=1&destination=<%= encodedLocation %>"
                                                   target="_blank" class="btn-primary">
                                                    <i class="fas fa-map-marker-alt"></i> View Map
                                                </a>
                                            <%
                                                } else {
                                            %>
                                                <p style="color: #999; font-size: 0.85rem; margin: 0;">Location not available</p>
                                            <%
                                                }
                                            %>
                                        </c:when>
                                        <c:when test="${property.location != null && (property.location.streetAddress != null || property.location.city != null)}">
                                            <c:set var="location">
                                                <c:if test="${property.location.streetAddress != null}">${property.location.streetAddress}, </c:if>
                                                <c:if test="${property.location.city != null}">${property.location.city}</c:if>
                                                <c:if test="${property.location.state != null}">, ${property.location.state}</c:if>
                                                <c:if test="${property.location.country != null}">, ${property.location.country}</c:if>
                                            </c:set>
                                            <%
                                                String location = (String) pageContext.getAttribute("location");
                                                if (location != null && !location.trim().isEmpty()) {
                                                    String encodedLocation = URLEncoder.encode(location, "UTF-8");
                                            %>
                                                <a href="https://www.google.com/maps/dir/?api=1&destination=<%= encodedLocation %>"
                                                   target="_blank" class="btn-primary">
                                                    <i class="fas fa-map-marker-alt"></i> View Map
                                                </a>
                                            <%
                                                } else {
                                            %>
                                                <p style="color: #999; font-size: 0.85rem; margin: 0;">Location not available</p>
                                            <%
                                                }
                                            %>
                                        </c:when>
                                        <c:otherwise>
                                            <p style="color: #999; font-size: 0.85rem; margin: 0;">Location not available</p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="property-details">
                                    <c:if test="${property.details != null && property.details.starRating != null}">
                                        <div class="property-detail-item">
                                            <i class="fas fa-star"></i>
                                            <span>${property.details.starRating} Star</span>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty property.rooms}">
                                        <div class="property-detail-item">
                                            <i class="fas fa-bed"></i>
                                            <span>${property.rooms.size()} Rooms</span>
                                        </div>
                                    </c:if>
                                </div>
                                <c:if test="${property.details != null && property.details.starRating != null}">
                                    <div class="property-rating">
                                        <div class="stars">
                                            <c:forEach begin="1" end="${property.details.starRating}">
                                                <i class="fas fa-star"></i>
                                            </c:forEach>
                                        </div>
                                        <span class="rating-text">${property.details.starRating}.0</span>
                                    </div>
                                </c:if>
                                <div class="property-price">
                                    <div>
                                        <span class="price">View Details</span>
                                    </div>
                                    <a href="/accommodation/property/view/${property.id}" class="btn-view" onclick="event.stopPropagation();">
                                        <i class="fas fa-arrow-right"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <i class="fas fa-building"></i>
                    <h3>No Properties Available</h3>
                    <p>There are no approved properties available at the moment.</p>
                    <a href="/accommodation/signup" class="btn-list-property">
                        <i class="fas fa-plus"></i> List Your Property
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>

