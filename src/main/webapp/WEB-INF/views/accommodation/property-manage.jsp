<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage My Properties - GlobalPiligrim Accommodation</title>
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
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        .page-title {
            font-size: 2rem;
            color: #333;
        }
        .btn-primary {
            background: #667eea;
            color: white;
            padding: 12px 24px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .btn-primary:hover {
            background: #5568d3;
        }
        .properties-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
        }
        .property-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .property-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        .property-image {
            width: 100%;
            height: 200px;
            background: #e0e0e0;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #999;
            position: relative;
        }
        .property-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .status-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
        }
        .status-badge.DRAFT {
            background: #e0e0e0;
            color: #666;
        }
        .status-badge.PENDING_REVIEW {
            background: #fff3cd;
            color: #856404;
        }
        .status-badge.APPROVED {
            background: #d4edda;
            color: #155724;
        }
        .status-badge.ACTIVE {
            background: #d1ecf1;
            color: #0c5460;
        }
        .status-badge.REJECTED {
            background: #f8d7da;
            color: #721c24;
        }
        .status-badge.ON_HOLD {
            background: #ffeaa7;
            color: #d63031;
        }
        .property-content {
            padding: 20px;
        }
        .property-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
        }
        .property-location {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .property-info {
            display: flex;
            gap: 15px;
            margin-bottom: 15px;
            font-size: 0.85rem;
            color: #666;
        }
        .property-info-item {
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .property-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        .btn {
            padding: 8px 15px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            transition: all 0.3s;
        }
        .btn-view {
            background: #667eea;
            color: white;
        }
        .btn-view:hover {
            background: #5568d3;
        }
        .btn-edit {
            background: #e0e0e0;
            color: #333;
        }
        .btn-edit:hover {
            background: #d0d0d0;
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
        .reference-id {
            font-size: 0.85rem;
            color: #999;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1><i class="fas fa-building"></i> GlobalPiligrim Accommodation</h1>
        <div class="nav-links">
            <a href="/pilgrim/accommodation/">Home</a>
            <a href="/pilgrim/accommodation/user/bookings">My Bookings</a>
            <a href="/pilgrim/accommodation/property/type-selection" class="btn-signin">
                <i class="fas fa-plus"></i> Add New Listing
            </a>
            <a href="/pilgrim/accommodation/logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <div class="page-header">
            <h1 class="page-title"><i class="fas fa-home"></i> Manage My Properties</h1>
            <a href="/pilgrim/accommodation/property/type-selection" class="btn-primary">
                <i class="fas fa-plus"></i> Add New Listing
            </a>
        </div>

        <c:choose>
            <c:when test="${not empty properties && properties.size() > 0}">
                <div class="properties-grid">
                    <c:forEach var="property" items="${properties}">
                        <div class="property-card">
                            <div class="property-image">
                                <c:choose>
                                    <c:when test="${not empty property.photos && property.photos.size() > 0}">
                                        <img src="/uploads/${property.photos[0].filePath}" alt="Property Image">
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-building"></i>
                                    </c:otherwise>
                                </c:choose>
                                <span class="status-badge ${property.status}">${property.status}</span>
                            </div>
                            <div class="property-content">
                                <div class="property-title">
                                    <c:choose><c:when test="${property.details != null && property.details.propertyName != null}">${property.details.propertyName}</c:when><c:otherwise>Property #${property.id}</c:otherwise></c:choose>
                                </div>
                                <c:if test="${property.referenceId != null}">
                                    <div class="reference-id">
                                        <i class="fas fa-hashtag"></i> ${property.referenceId}
                                    </div>
                                </c:if>
                                <div class="property-location">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <c:choose>
                                        <c:when test="${property.location != null}">
                                            <c:if test="${property.location.city != null}">${property.location.city}</c:if>
                                            <c:if test="${property.location.state != null}">, ${property.location.state}</c:if>
                                            <c:if test="${property.location.country != null}">, ${property.location.country}</c:if>
                                        </c:when>
                                        <c:otherwise>
                                            Location not set
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="property-info">
                                    <div class="property-info-item">
                                        <i class="fas fa-building"></i>
                                        <span>
                                            <c:choose>
                                                <c:when test="${property.hotelType != null}">${property.hotelType}</c:when>
                                                <c:when test="${property.homeType != null}">${property.homeType}</c:when>
                                                <c:when test="${property.uniqueType != null}">${property.uniqueType}</c:when>
                                                <c:otherwise>${property.propertyType}</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                    <c:if test="${not empty property.rooms}">
                                        <div class="property-info-item">
                                            <i class="fas fa-bed"></i>
                                            <span>${property.rooms.size()} Rooms</span>
                                        </div>
                                    </c:if>
                                    <c:if test="${property.details != null && property.details.starRating != null}">
                                        <div class="property-info-item">
                                            <i class="fas fa-star"></i>
                                            <span>${property.details.starRating} Star</span>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="property-actions">
                                    <a href="/pilgrim/accommodation/property/view/${property.id}" class="btn btn-view">
                                        <i class="fas fa-eye"></i> View
                                    </a>
                                    <c:if test="${property.status == 'DRAFT'}">
                                        <a href="/pilgrim/accommodation/property/listing/step1" class="btn btn-edit">
                                            <i class="fas fa-edit"></i> Continue Setup
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <i class="fas fa-home"></i>
                    <h3>No Properties Listed</h3>
                    <p>You haven't listed any properties yet. Start by adding your first property!</p>
                    <a href="/pilgrim/accommodation/property/type-selection" class="btn-primary">
                        <i class="fas fa-plus"></i> Add Your First Property
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>

