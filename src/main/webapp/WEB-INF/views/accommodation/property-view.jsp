<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${property.details != null ? property.details.propertyName : 'Property Details'} - GlobalPiligrim Accommodation</title>
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
        .back-btn {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .back-btn:hover {
            text-decoration: underline;
        }
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }
        .property-header {
            background: white;
            border-radius: 12px;
            padding: 30px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .property-title {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 20px;
        }
        .property-title h2 {
            color: #333;
            font-size: 2rem;
            margin-bottom: 10px;
        }
        .property-location {
            color: #666;
            font-size: 1.1rem;
            margin-bottom: 15px;
        }
        .property-rating {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .stars {
            color: #ffc107;
        }
        .property-images {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr;
            gap: 10px;
            margin-bottom: 30px;
            border-radius: 12px;
            overflow: hidden;
        }
        .main-image {
            width: 100%;
            height: 400px;
            object-fit: cover;
        }
        .side-images {
            display: grid;
            grid-template-rows: 1fr 1fr;
            gap: 10px;
        }
        .side-image {
            width: 100%;
            height: 195px;
            object-fit: cover;
        }
        .property-info {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 30px;
            margin-bottom: 30px;
        }
        .main-content {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .sidebar {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        .info-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .section-title {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e0e0e0;
        }
        .amenities-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 30px;
        }
        .amenity-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px;
            background: #f9f9f9;
            border-radius: 8px;
        }
        .amenity-item i {
            color: #667eea;
            width: 20px;
        }
        .rooms-section {
            margin-top: 30px;
        }
        .room-card {
            background: #f9f9f9;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 15px;
        }
        .room-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 15px;
        }
        .room-type {
            font-size: 1.2rem;
            font-weight: 600;
            color: #333;
        }
        .room-price {
            font-size: 1.3rem;
            font-weight: 700;
            color: #667eea;
        }
        .room-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
            margin-bottom: 15px;
        }
        .room-detail-item {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #666;
        }
        .room-detail-item i {
            color: #667eea;
            width: 20px;
        }
        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #e0e0e0;
        }
        .info-row:last-child {
            border-bottom: none;
        }
        .info-label {
            color: #666;
            font-weight: 500;
        }
        .info-value {
            color: #333;
            font-weight: 600;
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
        }
        .btn-primary {
            background: #667eea;
            color: white;
            width: 100%;
        }
        .btn-primary:hover {
            background: #5568d3;
        }
        .btn-secondary {
            background: #e0e0e0;
            color: #333;
            width: 100%;
            margin-top: 10px;
        }
        .btn-secondary:hover {
            background: #d0d0d0;
        }
        .map-container {
            margin-top: 30px;
            border-radius: 12px;
            overflow: hidden;
            height: 300px;
            background: #e0e0e0;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #666;
        }
        .no-image {
            width: 100%;
            height: 400px;
            background: #e0e0e0;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #999;
            font-size: 1.2rem;
        }
    </style>
    <script>
        function openImageModal(imageSrc) {
            var modal = document.createElement('div');
            modal.style.cssText = 'position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,0.9);z-index:10000;display:flex;align-items:center;justify-content:center;cursor:pointer;';
            modal.onclick = function() { document.body.removeChild(modal); };
            
            var img = document.createElement('img');
            img.src = imageSrc;
            img.style.cssText = 'max-width:90%;max-height:90%;object-fit:contain;border-radius:8px;';
            img.onclick = function(e) { e.stopPropagation(); };
            
            var closeBtn = document.createElement('div');
            closeBtn.innerHTML = '<i class="fas fa-times"></i>';
            closeBtn.style.cssText = 'position:absolute;top:20px;right:20px;color:white;font-size:2rem;cursor:pointer;background:rgba(0,0,0,0.5);width:50px;height:50px;border-radius:50%;display:flex;align-items:center;justify-content:center;';
            closeBtn.onclick = function(e) { e.stopPropagation(); document.body.removeChild(modal); };
            
            modal.appendChild(img);
            modal.appendChild(closeBtn);
            document.body.appendChild(modal);
        }
    </script>
</head>
<body>
    <div class="header">
        <h1><i class="fas fa-building"></i> GlobalPiligrim Accommodation</h1>
        <a href="/pilgrim/accommodation/" class="back-btn">
            <i class="fas fa-arrow-left"></i> Back to Home
        </a>
    </div>

    <div class="container">
        <c:if test="${not empty property}">
            <div class="property-header">
                <div class="property-title">
                    <div>
                        <h2><c:choose><c:when test="${property.details != null && property.details.propertyName != null}">${property.details.propertyName}</c:when><c:otherwise>Property #${property.id}</c:otherwise></c:choose></h2>
                        <div class="property-location">
                            <i class="fas fa-map-marker-alt"></i>
                            <c:choose>
                                <c:when test="${property.location != null}">
                                    ${property.location.streetAddress != null ? property.location.streetAddress : ''}
                                    ${property.location.city != null ? property.location.city : ''}
                                    ${property.location.state != null ? property.location.state : ''}
                                    ${property.location.country != null ? property.location.country : ''}
                                </c:when>
                                <c:otherwise>
                                    Location not available
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <c:if test="${property.details != null && property.details.starRating != null}">
                            <div class="property-rating">
                                <div class="stars">
                                    <c:forEach begin="1" end="${property.details.starRating}">
                                        <i class="fas fa-star"></i>
                                    </c:forEach>
                                </div>
                                <span>${property.details.starRating}.0 Rating</span>
                            </div>
                        </c:if>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${not empty property.photos && property.photos.size() > 0}">
                        <!-- Main Gallery - Show first few images -->
                        <div class="property-images">
                            <c:set var="coverPhoto" value="${null}" />
                            <c:forEach var="photo" items="${property.photos}">
                                <c:if test="${photo.isCoverPhoto == true}">
                                    <c:set var="coverPhoto" value="${photo}" />
                                </c:if>
                            </c:forEach>
                            
                            <c:choose>
                                <c:when test="${coverPhoto != null}">
                                    <img src="/uploads/${coverPhoto.filePath}" 
                                         alt="Property Image" 
                                         class="main-image"
                                         onerror="this.onerror=null; this.src='data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'800\' height=\'400\'%3E%3Crect fill=\'%23e0e0e0\' width=\'800\' height=\'400\'/%3E%3Ctext x=\'50%25\' y=\'50%25\' text-anchor=\'middle\' dy=\'.3em\' fill=\'%23999\' font-family=\'Arial\' font-size=\'18\'%3EImage not available%3C/text%3E%3C/svg%3E';">
                                </c:when>
                                <c:otherwise>
                                    <img src="/uploads/${property.photos[0].filePath}" 
                                         alt="Property Image" 
                                         class="main-image"
                                         onerror="this.onerror=null; this.src='data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'800\' height=\'400\'%3E%3Crect fill=\'%23e0e0e0\' width=\'800\' height=\'400\'/%3E%3Ctext x=\'50%25\' y=\'50%25\' text-anchor=\'middle\' dy=\'.3em\' fill=\'%23999\' font-family=\'Arial\' font-size=\'18\'%3EImage not available%3C/text%3E%3C/svg%3E';">
                                </c:otherwise>
                            </c:choose>
                            
                            <c:if test="${property.photos.size() > 1}">
                                <div class="side-images">
                                    <c:set var="displayedCount" value="0" />
                                    <c:forEach var="photo" items="${property.photos}">
                                        <c:if test="${displayedCount < 2 && (coverPhoto == null || photo.id != coverPhoto.id)}">
                                            <img src="/uploads/${photo.filePath}" 
                                                 alt="Property Image" 
                                                 class="side-image"
                                                 onerror="this.onerror=null; this.src='data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'400\' height=\'200\'%3E%3Crect fill=\'%23e0e0e0\' width=\'400\' height=\'200\'/%3E%3Ctext x=\'50%25\' y=\'50%25\' text-anchor=\'middle\' dy=\'.3em\' fill=\'%23999\' font-family=\'Arial\' font-size=\'14\'%3EImage not available%3C/text%3E%3C/svg%3E';">
                                            <c:set var="displayedCount" value="${displayedCount + 1}" />
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </c:if>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="no-image">
                            <i class="fas fa-image"></i> No images available
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Photo Gallery by Category -->
            <c:if test="${not empty property.photos && property.photos.size() > 0}">
                <div class="photo-gallery-section">
                    <h2 class="section-title" style="margin-top: 0;"><i class="fas fa-images"></i> Photo Gallery</h2>
                    
                    <!-- BEDROOM Photos -->
                    <c:set var="hasBedroom" value="false" />
                    <c:forEach var="photo" items="${property.photos}">
                        <c:if test="${photo.category.toString() == 'BEDROOM'}">
                            <c:set var="hasBedroom" value="true" />
                        </c:if>
                    </c:forEach>
                    <c:if test="${hasBedroom}">
                        <div class="photo-category">
                            <h3 class="category-title"><i class="fas fa-bed"></i> Bedroom</h3>
                            <div class="photos-grid">
                                <c:forEach var="photo" items="${property.photos}">
                                    <c:if test="${photo.category.toString() == 'BEDROOM'}">
                                        <div class="photo-item" onclick="openImageModal('/uploads/${photo.filePath}')">
                                            <img src="/uploads/${photo.filePath}" 
                                                 alt="Bedroom Image"
                                                 onerror="this.onerror=null; this.parentElement.innerHTML='<div style=\'display:flex;align-items:center;justify-content:center;height:100%;color:#999;\'><i class=\'fas fa-image\' style=\'font-size:2rem;\'></i></div>';">
                                            <div class="photo-overlay">${photo.fileName != null ? photo.fileName : 'Bedroom'}</div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
                    
                    <!-- BATHROOM Photos -->
                    <c:set var="hasBathroom" value="false" />
                    <c:forEach var="photo" items="${property.photos}">
                        <c:if test="${photo.category.toString() == 'BATHROOM'}">
                            <c:set var="hasBathroom" value="true" />
                        </c:if>
                    </c:forEach>
                    <c:if test="${hasBathroom}">
                        <div class="photo-category">
                            <h3 class="category-title"><i class="fas fa-bath"></i> Bathroom</h3>
                            <div class="photos-grid">
                                <c:forEach var="photo" items="${property.photos}">
                                    <c:if test="${photo.category.toString() == 'BATHROOM'}">
                                        <div class="photo-item" onclick="openImageModal('/uploads/${photo.filePath}')">
                                            <img src="/uploads/${photo.filePath}" 
                                                 alt="Bathroom Image"
                                                 onerror="this.onerror=null; this.parentElement.innerHTML='<div style=\'display:flex;align-items:center;justify-content:center;height:100%;color:#999;\'><i class=\'fas fa-image\' style=\'font-size:2rem;\'></i></div>';">
                                            <div class="photo-overlay">${photo.fileName != null ? photo.fileName : 'Bathroom'}</div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
                    
                    <!-- LOBBY_ENTRANCE Photos -->
                    <c:set var="hasLobby" value="false" />
                    <c:forEach var="photo" items="${property.photos}">
                        <c:if test="${photo.category.toString() == 'LOBBY_ENTRANCE'}">
                            <c:set var="hasLobby" value="true" />
                        </c:if>
                    </c:forEach>
                    <c:if test="${hasLobby}">
                        <div class="photo-category">
                            <h3 class="category-title"><i class="fas fa-door-open"></i> Lobby & Entrance</h3>
                            <div class="photos-grid">
                                <c:forEach var="photo" items="${property.photos}">
                                    <c:if test="${photo.category.toString() == 'LOBBY_ENTRANCE'}">
                                        <div class="photo-item" onclick="openImageModal('/uploads/${photo.filePath}')">
                                            <img src="/uploads/${photo.filePath}" 
                                                 alt="Lobby Image"
                                                 onerror="this.onerror=null; this.parentElement.innerHTML='<div style=\'display:flex;align-items:center;justify-content:center;height:100%;color:#999;\'><i class=\'fas fa-image\' style=\'font-size:2rem;\'></i></div>';">
                                            <div class="photo-overlay">${photo.fileName != null ? photo.fileName : 'Lobby'}</div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
                    
                    <!-- OUTDOOR_VIEW Photos -->
                    <c:set var="hasOutdoor" value="false" />
                    <c:forEach var="photo" items="${property.photos}">
                        <c:if test="${photo.category.toString() == 'OUTDOOR_VIEW'}">
                            <c:set var="hasOutdoor" value="true" />
                        </c:if>
                    </c:forEach>
                    <c:if test="${hasOutdoor}">
                        <div class="photo-category">
                            <h3 class="category-title"><i class="fas fa-mountain"></i> Outdoor View</h3>
                            <div class="photos-grid">
                                <c:forEach var="photo" items="${property.photos}">
                                    <c:if test="${photo.category.toString() == 'OUTDOOR_VIEW'}">
                                        <div class="photo-item" onclick="openImageModal('/uploads/${photo.filePath}')">
                                            <img src="/uploads/${photo.filePath}" 
                                                 alt="Outdoor View Image"
                                                 onerror="this.onerror=null; this.parentElement.innerHTML='<div style=\'display:flex;align-items:center;justify-content:center;height:100%;color:#999;\'><i class=\'fas fa-image\' style=\'font-size:2rem;\'></i></div>';">
                                            <div class="photo-overlay">${photo.fileName != null ? photo.fileName : 'Outdoor View'}</div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
                    
                    <!-- FACILITIES Photos -->
                    <c:set var="hasFacilities" value="false" />
                    <c:forEach var="photo" items="${property.photos}">
                        <c:if test="${photo.category.toString() == 'FACILITIES'}">
                            <c:set var="hasFacilities" value="true" />
                        </c:if>
                    </c:forEach>
                    <c:if test="${hasFacilities}">
                        <div class="photo-category">
                            <h3 class="category-title"><i class="fas fa-swimming-pool"></i> Facilities</h3>
                            <div class="photos-grid">
                                <c:forEach var="photo" items="${property.photos}">
                                    <c:if test="${photo.category.toString() == 'FACILITIES'}">
                                        <div class="photo-item" onclick="openImageModal('/uploads/${photo.filePath}')">
                                            <img src="/uploads/${photo.filePath}" 
                                                 alt="Facilities Image"
                                                 onerror="this.onerror=null; this.parentElement.innerHTML='<div style=\'display:flex;align-items:center;justify-content:center;height:100%;color:#999;\'><i class=\'fas fa-image\' style=\'font-size:2rem;\'></i></div>';">
                                            <div class="photo-overlay">${photo.fileName != null ? photo.fileName : 'Facilities'}</div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
                    
                    <!-- PROPERTY_OVERVIEW Photos -->
                    <c:set var="hasOverview" value="false" />
                    <c:forEach var="photo" items="${property.photos}">
                        <c:if test="${photo.category.toString() == 'PROPERTY_OVERVIEW'}">
                            <c:set var="hasOverview" value="true" />
                        </c:if>
                    </c:forEach>
                    <c:if test="${hasOverview}">
                        <div class="photo-category">
                            <h3 class="category-title"><i class="fas fa-building"></i> Property Overview</h3>
                            <div class="photos-grid">
                                <c:forEach var="photo" items="${property.photos}">
                                    <c:if test="${photo.category.toString() == 'PROPERTY_OVERVIEW'}">
                                        <div class="photo-item" onclick="openImageModal('/uploads/${photo.filePath}')">
                                            <img src="/uploads/${photo.filePath}" 
                                                 alt="Property Overview Image"
                                                 onerror="this.onerror=null; this.parentElement.innerHTML='<div style=\'display:flex;align-items:center;justify-content:center;height:100%;color:#999;\'><i class=\'fas fa-image\' style=\'font-size:2rem;\'></i></div>';">
                                            <div class="photo-overlay">${photo.fileName != null ? photo.fileName : 'Property Overview'}</div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
                </div>
            </c:if>

            <div class="property-info">
                <div class="main-content">
                    <h3 class="section-title">About this property</h3>
                    <c:if test="${property.details != null}">
                        <div style="line-height: 1.8; color: #666; margin-bottom: 30px;">
                            <c:if test="${property.details.propertyName != null}">
                                <p><strong>Property Name:</strong> ${property.details.propertyName}</p>
                            </c:if>
                            <c:if test="${property.details.starRating != null}">
                                <p><strong>Star Rating:</strong> ${property.details.starRating} Stars</p>
                            </c:if>
                            <c:if test="${property.details.checkInTimeFrom != null && property.details.checkInTimeTo != null}">
                                <p><strong>Check-in:</strong> ${property.details.checkInTimeFrom} - ${property.details.checkInTimeTo}</p>
                            </c:if>
                            <c:if test="${property.details.checkOutTime != null}">
                                <p><strong>Check-out:</strong> ${property.details.checkOutTime}</p>
                            </c:if>
                            <c:if test="${property.details.cancellationPolicy != null}">
                                <p><strong>Cancellation Policy:</strong> ${fn:replace(fn:toLowerCase(property.details.cancellationPolicy), '_', ' ')}</p>
                            </c:if>
                        </div>
                    </c:if>

                    <c:if test="${not empty property.amenities}">
                        <h3 class="section-title">Amenities</h3>
                        <div class="amenities-grid">
                            <c:forEach var="amenity" items="${property.amenities}">
                                <div class="amenity-item">
                                    <i class="fas fa-check-circle"></i>
                                    <span>${fn:replace(fn:toLowerCase(amenity), '_', ' ')}</span>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>

                    <c:if test="${not empty rooms}">
                        <div class="rooms-section">
                            <h3 class="section-title">Rooms & Rates</h3>
                            <c:forEach var="room" items="${rooms}">
                                <div class="room-card">
                                    <div class="room-header">
                                        <div class="room-type">
                                            <c:choose>
                                                <c:when test="${room.customRoomType != null && !empty room.customRoomType}">
                                                    ${room.customRoomType}
                                                </c:when>
                                                <c:otherwise>
                                                    ${fn:replace(fn:toLowerCase(room.roomType), '_', ' ')}
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="room-price">
                                            ₹${room.minimumRoomRate}/night
                                        </div>
                                    </div>
                                    <div class="room-details">
                                        <div class="room-detail-item">
                                            <i class="fas fa-ruler-combined"></i>
                                            <span>${room.roomSize} sqm</span>
                                        </div>
                                        <div class="room-detail-item">
                                            <i class="fas fa-users"></i>
                                            <span>${room.totalOccupancy} guests</span>
                                        </div>
                                        <div class="room-detail-item">
                                            <i class="fas fa-bed"></i>
                                            <span>${room.totalRooms} rooms</span>
                                        </div>
                                        <div class="room-detail-item">
                                            <i class="fas fa-bath"></i>
                                            <span>${room.bathrooms} bathrooms</span>
                                        </div>
                                    </div>
                                    <c:if test="${room.breakfastIncluded}">
                                        <div style="color: #4caf50; margin-top: 10px;">
                                            <i class="fas fa-check-circle"></i> Breakfast included
                                            <c:if test="${room.breakfastPricePerGuest != null}">
                                                (₹${room.breakfastPricePerGuest}/guest)
                                            </c:if>
                                        </div>
                                    </c:if>
                                    <c:if test="${room.extraGuestPrice != null && room.extraGuestPrice > 0}">
                                        <div style="color: #666; margin-top: 5px;">
                                            <i class="fas fa-user-plus"></i> Extra guest: ₹${room.extraGuestPrice}
                                        </div>
                                    </c:if>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>

                    <c:if test="${property.location != null && property.location.latitude != null && property.location.longitude != null}">
                        <div class="map-container" style="margin-top: 30px;">
                            <h3 class="section-title">Location</h3>
                            
                            <!-- Clickable Map Container -->
                            <div style="width: 100%; height: 400px; border-radius: 12px; overflow: hidden; margin-bottom: 15px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); position: relative; cursor: pointer; background: #e0e0e0;" 
                                 onclick="window.open('https://www.google.com/maps?q=${property.location.latitude},${property.location.longitude}', '_blank')"
                                 onmouseover="this.style.opacity='0.9'" 
                                 onmouseout="this.style.opacity='1'">
                                
                                <!-- Map Preview using OpenStreetMap (free, no API key needed) -->
                                <iframe 
                                    width="100%" 
                                    height="100%" 
                                    style="border:0; border-radius: 12px;" 
                                    loading="lazy" 
                                    allowfullscreen
                                    src="https://www.openstreetmap.org/export/embed.html?bbox=${property.location.longitude - 0.01},${property.location.latitude - 0.01},${property.location.longitude + 0.01},${property.location.latitude + 0.01}&layer=mapnik&marker=${property.location.latitude},${property.location.longitude}">
                                </iframe>
                                
                                <div style="position: absolute; top: 10px; right: 10px; background: rgba(102, 126, 234, 0.95); color: white; padding: 10px 15px; border-radius: 6px; font-size: 0.9rem; font-weight: 600; box-shadow: 0 2px 8px rgba(0,0,0,0.2);">
                                    <i class="fas fa-external-link-alt"></i> Click to open in Google Maps
                                </div>
                            </div>
                            
                            <div style="text-align: center; margin-bottom: 15px;">
                                <a href="https://www.google.com/maps?q=${property.location.latitude},${property.location.longitude}" 
                                   target="_blank" 
                                   style="display: inline-flex; align-items: center; gap: 8px; padding: 12px 24px; background: #667eea; color: white; text-decoration: none; border-radius: 8px; font-weight: 500; transition: background 0.3s; box-shadow: 0 2px 8px rgba(102, 126, 234, 0.3);">
                                    <i class="fas fa-map-marked-alt"></i> View on Google Maps
                                </a>
                            </div>
                            
                            <p style="margin-top: 15px; color: #666; font-size: 0.9rem; text-align: center; padding: 15px; background: #f9f9f9; border-radius: 8px; border-left: 4px solid #667eea;">
                                <i class="fas fa-map-marker-alt" style="color: #667eea;"></i> 
                                <strong>Address:</strong><br>
                                <c:if test="${property.location.streetAddress != null}">${property.location.streetAddress}<br></c:if>
                                <c:if test="${property.location.city != null}">${property.location.city}</c:if>
                                <c:if test="${property.location.state != null}">, ${property.location.state}</c:if>
                                <c:if test="${property.location.country != null}">, ${property.location.country}</c:if>
                            </p>
                        </div>
                    </c:if>
                </div>

                <div class="sidebar">
                    <div class="info-card">
                        <h3 style="margin-bottom: 20px; color: #333;">Property Information</h3>
                        <div class="info-row">
                            <span class="info-label">Property Type</span>
                            <span class="info-value">
                                <c:choose>
                                    <c:when test="${property.hotelType != null}">${property.hotelType}</c:when>
                                    <c:when test="${property.homeType != null}">${property.homeType}</c:when>
                                    <c:when test="${property.uniqueType != null}">${property.uniqueType}</c:when>
                                    <c:otherwise>${property.propertyType}</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        <c:if test="${property.location != null}">
                            <div class="info-row">
                                <span class="info-label">Location</span>
                                <span class="info-value">${property.location.city != null ? property.location.city : 'N/A'}</span>
                            </div>
                        </c:if>
                        <c:if test="${not empty rooms}">
                            <div class="info-row">
                                <span class="info-label">Total Rooms</span>
                                <span class="info-value">${rooms.size()}</span>
                            </div>
                        </c:if>
                    </div>

                    <div class="info-card">
                        <h3 style="margin-bottom: 20px; color: #333;">Book Now</h3>
                        <c:choose>
                            <c:when test="${not empty rooms && rooms[0].minimumRoomRate != null}">
                                <div style="font-size: 2rem; font-weight: 700; color: #667eea; margin-bottom: 20px; text-align: center;">
                                    ₹${rooms[0].minimumRoomRate}
                                    <span style="font-size: 1rem; color: #666; font-weight: 400;">/night</span>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div style="color: #666; margin-bottom: 20px; text-align: center;">
                                    Contact for pricing
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <c:if test="${not empty rooms}">
                            <form method="post" action="/pilgrim/accommodation/user/book" style="margin-bottom: 10px;">
                                <input type="hidden" name="propertyId" value="${property.id}">
                                <input type="hidden" name="roomId" value="${rooms[0].id}">
                                <input type="date" name="checkInDate" required style="width: 100%; padding: 10px; margin-bottom: 10px; border: 2px solid #e0e0e0; border-radius: 8px;">
                                <input type="date" name="checkOutDate" required style="width: 100%; padding: 10px; margin-bottom: 10px; border: 2px solid #e0e0e0; border-radius: 8px;">
                                <input type="number" name="numberOfGuests" min="1" max="${rooms[0].totalOccupancy}" value="1" required style="width: 100%; padding: 10px; margin-bottom: 10px; border: 2px solid #e0e0e0; border-radius: 8px;">
                                <c:if test="${sessionScope.accommodationUserId == null}">
                                    <input type="text" name="guestName" placeholder="Your Full Name" required style="width: 100%; padding: 10px; margin-bottom: 10px; border: 2px solid #e0e0e0; border-radius: 8px;">
                                    <input type="email" name="guestEmail" placeholder="Your Email" required style="width: 100%; padding: 10px; margin-bottom: 10px; border: 2px solid #e0e0e0; border-radius: 8px;">
                                    <input type="tel" name="guestPhone" placeholder="Your Phone Number" required style="width: 100%; padding: 10px; margin-bottom: 10px; border: 2px solid #e0e0e0; border-radius: 8px;">
                                </c:if>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-calendar-check"></i> Book Now
                                </button>
                            </form>
                        </c:if>
                        <a href="mailto:${property.owner.email}" class="btn btn-secondary">
                            <i class="fas fa-envelope"></i> Contact Owner
                        </a>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
</body>
</html>

