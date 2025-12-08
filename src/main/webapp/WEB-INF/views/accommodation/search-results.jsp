<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results - GlobalPiligrim Accommodation</title>
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
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.05) 0%, rgba(118, 75, 162, 0.05) 100%);
            z-index: -1;
        }
        .header {
            background: white;
            padding: 20px 30px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
            backdrop-filter: blur(10px);
        }
        .header h1 {
            color: #667eea;
            font-size: 1.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
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
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px 30px;
            display: grid;
            grid-template-columns: 280px 1fr;
            gap: 30px;
        }
        .filters-sidebar {
            background: white;
            border-radius: 16px;
            padding: 25px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            height: fit-content;
            position: sticky;
            top: 20px;
            transition: box-shadow 0.3s;
        }
        .filters-sidebar:hover {
            box-shadow: 0 6px 30px rgba(0,0,0,0.12);
        }
        .filters-sidebar h3 {
            color: #333;
            margin-bottom: 20px;
            font-size: 1.2rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .filters-sidebar h3 i {
            color: #667eea;
        }
        .filter-group {
            margin-bottom: 25px;
        }
        .filter-group label {
            display: block;
            color: #666;
            font-weight: 500;
            margin-bottom: 10px;
        }
        .filter-group select,
        .filter-group input {
            width: 100%;
            padding: 10px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 0.9rem;
        }
        .filter-group select:focus,
        .filter-group input:focus {
            outline: none;
            border-color: #667eea;
        }
        .checkbox-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
            max-height: 200px;
            overflow-y: auto;
        }
        .checkbox-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .checkbox-item input[type="checkbox"] {
            width: auto;
        }
        .results-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .results-count {
            color: #666;
            font-size: 1rem;
        }
        .properties-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
        }
        .property-card {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            border: 1px solid rgba(0,0,0,0.05);
        }
        .property-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 12px 40px rgba(0,0,0,0.15);
            border-color: rgba(102, 126, 234, 0.2);
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
        .wishlist-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            background: rgba(255,255,255,0.9);
            border: none;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 1.2rem;
            color: #666;
            transition: all 0.3s;
            z-index: 10;
        }
        .wishlist-btn:hover {
            background: white;
            color: #e74c3c;
            transform: scale(1.1);
        }
        .wishlist-btn.active {
            color: #e74c3c;
        }
        .booking-success-alert {
            max-width: 1400px;
            margin: 20px auto;
            padding: 0 20px;
            animation: slideDown 0.5s ease-out;
        }
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .success-alert-content {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 25px 30px;
            border-radius: 16px;
            box-shadow: 0 8px 30px rgba(102, 126, 234, 0.3);
            display: flex;
            align-items: center;
            gap: 20px;
            position: relative;
        }
        .success-icon-alert {
            font-size: 3rem;
            color: white;
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.1);
            }
        }
        .success-alert-text {
            flex: 1;
        }
        .success-alert-text h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            font-weight: 700;
        }
        .success-alert-text p {
            margin: 5px 0;
            font-size: 1rem;
            opacity: 0.95;
        }
        .view-booking-link {
            display: inline-block;
            margin-top: 10px;
            padding: 10px 20px;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s;
            backdrop-filter: blur(10px);
        }
        .view-booking-link:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
        }
        .close-alert {
            position: absolute;
            top: 15px;
            right: 15px;
            background: rgba(255, 255, 255, 0.2);
            border: none;
            color: white;
            width: 35px;
            height: 35px;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s;
            backdrop-filter: blur(10px);
        }
        .close-alert:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: rotate(90deg);
        }
        .property-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .property-badge {
            position: absolute;
            top: 10px;
            left: 10px;
            background: rgba(255,255,255,0.9);
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        .property-content {
            padding: 20px;
        }
        .property-title {
            font-size: 1.2rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 10px;
            line-height: 1.4;
        }
        .property-location {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .property-details {
            display: flex;
            gap: 15px;
            margin-bottom: 15px;
            font-size: 0.85rem;
            color: #666;
        }
        .property-detail-item {
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .property-rating {
            display: flex;
            align-items: center;
            gap: 5px;
            margin-bottom: 15px;
        }
        .stars {
            color: #ffc107;
        }
        .property-price {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .price {
            font-size: 1.4rem;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        .price-label {
            font-size: 0.85rem;
            color: #666;
        }
        .btn-view {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 10px 20px;
            border-radius: 10px;
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 600;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }
        .btn-view:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
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
        }
        .apply-filters-btn {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            margin-top: 10px;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }
        .apply-filters-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }
        /* Top Search Form (Booking.com Style) */
        .search-form-wrapper {
            background: white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            padding: 20px 0;
            margin-bottom: 20px;
        }
        .search-form-container-top {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
        }
        .search-form-top {
            display: grid;
            grid-template-columns: 2.5fr 1.2fr 1.2fr 1fr auto;
            gap: 15px;
            align-items: end;
        }
        .form-group-top {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        .form-group-top label {
            font-size: 0.75rem;
            font-weight: 600;
            color: #333;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 4px;
        }
        .form-group-top label i {
            color: #667eea;
            font-size: 0.8rem;
            margin-right: 4px;
        }
        .form-group-top input {
            padding: 12px 14px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 0.95rem;
            transition: all 0.3s;
            background: white;
            font-family: inherit;
            width: 100%;
        }
        .form-group-top input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        .form-group-top input:hover {
            border-color: #d0d0d0;
        }
        .search-btn-top {
            padding: 12px 40px;
            background: linear-gradient(135deg, #003580 0%, #0071c2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 2px 8px rgba(0, 53, 128, 0.3);
            display: flex;
            align-items: center;
            gap: 8px;
            justify-content: center;
            height: fit-content;
            white-space: nowrap;
        }
        .search-btn-top:hover {
            background: linear-gradient(135deg, #002d6b 0%, #0060a0 100%);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0, 53, 128, 0.4);
        }
        .search-btn-top:active {
            transform: translateY(0);
        }
        @media (max-width: 1200px) {
            .search-form-top {
                grid-template-columns: 1fr 1fr;
            }
            .search-btn-top {
                grid-column: 1 / -1;
            }
        }
        @media (max-width: 768px) {
            .search-form-top {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1><i class="fas fa-building"></i> GlobalPiligrim Accommodation</h1>
        <div class="nav-links">
            <a href="/pilgrim/accommodation/">Home</a>
            <c:choose>
                <c:when test="${sessionScope.accommodationUserId != null}">
                    <a href="/pilgrim/accommodation/user/search"><i class="fas fa-search"></i> Search</a>
                    <a href="/pilgrim/accommodation/user/bookings">My Bookings</a>
                    <a href="/pilgrim/accommodation/property/manage">My Properties</a>
                    <a href="/pilgrim/accommodation/property/type-selection" class="btn-signin">
                        <i class="fas fa-plus"></i> List Property
                    </a>
                    <a href="/pilgrim/accommodation/logout">Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="/pilgrim/accommodation/signin">Sign In</a>
                    <a href="/pilgrim/accommodation/signup" class="btn-signin">List Your Property</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Search Form at Top (Full Width) -->
    <div class="search-form-wrapper">
        <div class="search-form-container-top">
            <form method="get" action="/pilgrim/accommodation/user/search" class="search-form-top">
                <div class="form-group-top">
                    <label for="location"><i class="fas fa-map-marker-alt"></i> Where are you going?</label>
                    <input type="text" id="location" name="location" placeholder="City, State or Country" value="${location}" required>
                </div>
                <div class="form-group-top">
                    <label for="checkIn"><i class="fas fa-calendar-check"></i> Check-in date</label>
                    <input type="date" id="checkIn" name="checkIn" value="${checkIn}" required>
                </div>
                <div class="form-group-top">
                    <label for="checkOut"><i class="fas fa-calendar-times"></i> Check-out date</label>
                    <input type="date" id="checkOut" name="checkOut" value="${checkOut}" required>
                </div>
                <div class="form-group-top">
                    <label for="guests"><i class="fas fa-users"></i> Guests</label>
                    <input type="number" id="guests" name="guests" placeholder="Adults" min="1" value="${guests != null ? guests : 1}" required>
                </div>
                <button type="submit" class="search-btn-top">
                    <i class="fas fa-search"></i> Search
                </button>
            </form>
        </div>
    </div>

    <!-- Booking Success Alert -->
    <c:if test="${not empty success || param.bookingSuccess == 'true'}">
        <div class="booking-success-alert" id="bookingSuccessAlert">
            <div class="success-alert-content">
                <div class="success-icon-alert">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="success-alert-text">
                    <h3>Booking Confirmed! 🎉</h3>
                    <c:if test="${not empty bookingReference}">
                        <p><strong>Reference:</strong> ${bookingReference}</p>
                    </c:if>
                    <c:if test="${not empty bookingAmount}">
                        <p><strong>Total Amount:</strong> <span style="color: white; font-size: 1.3rem; font-weight: 700;">₹${bookingAmount}</span></p>
                    </c:if>
                    <c:if test="${not empty param.bookingId}">
                        <a href="/pilgrim/accommodation/user/bookings" class="view-booking-link">
                            <i class="fas fa-calendar-check"></i> View Booking Details
                        </a>
                    </c:if>
                </div>
                <button class="close-alert" onclick="document.getElementById('bookingSuccessAlert').style.display='none'">
                    <i class="fas fa-times"></i>
                </button>
            </div>
        </div>
    </c:if>

    <div class="container">
        <div class="filters-sidebar">
            <h3><i class="fas fa-filter"></i> Filters</h3>
            <form method="get" action="/pilgrim/accommodation/user/search" id="filterForm">
                <input type="hidden" name="location" value="${location}">
                <input type="hidden" name="checkIn" value="${checkIn}">
                <input type="hidden" name="checkOut" value="${checkOut}">
                <input type="hidden" name="guests" value="${guests}">
                
                <!-- Popular filters -->
                <div class="filter-group">
                    <h4 style="font-size: 1rem; font-weight: 600; margin-bottom: 15px; color: #333;">Popular filters</h4>
                    <div class="checkbox-group">
                        <div class="checkbox-item">
                            <input type="checkbox" name="veryGood" value="true" id="veryGood" ${veryGood != null && veryGood ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="veryGood" style="font-weight: normal; margin: 0;">Very good: 8+</label>
                            <span style="font-size: 0.75rem; color: #999; margin-left: 5px;">Based on guest reviews</span>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="hotels" value="true" id="hotels" ${hotels != null && hotels ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="hotels" style="font-weight: normal; margin: 0;">Hotels</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="parking" value="true" id="parking" ${parking != null && parking ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="parking" style="font-weight: normal; margin: 0;">Parking</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="fiveStars" value="true" id="fiveStars" ${fiveStars != null && fiveStars ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="fiveStars" style="font-weight: normal; margin: 0;">5 stars</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="lessThan1km" value="true" id="lessThan1km" ${lessThan1km != null && lessThan1km ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="lessThan1km" style="font-weight: normal; margin: 0;">Less than 1 km</label>
                            <span style="font-size: 0.75rem; color: #999; margin-left: 5px;">Distance from address</span>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="resorts" value="true" id="resorts" ${resorts != null && resorts ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="resorts" style="font-weight: normal; margin: 0;">Resorts</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="beachfront" value="true" id="beachfront" ${beachfront != null && beachfront ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="beachfront" style="font-weight: normal; margin: 0;">Beachfront</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="swimmingPool" value="true" id="swimmingPool" ${swimmingPool != null && swimmingPool ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="swimmingPool" style="font-weight: normal; margin: 0;">Swimming pool</label>
                        </div>
                    </div>
                </div>
                
                <hr style="margin: 20px 0; border: none; border-top: 1px solid #e0e0e0;">
                
                <!-- Property type -->
                <div class="filter-group">
                    <h4 style="font-size: 1rem; font-weight: 600; margin-bottom: 15px; color: #333;">Property type</h4>
                    <div class="checkbox-group">
                        <div class="checkbox-item">
                            <input type="checkbox" name="hotels" value="true" id="hotelsType" ${hotels != null && hotels ? 'checked' : ''}>
                            <label for="hotelsType" style="font-weight: normal; margin: 0;">Hotels</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="hotelType" value="GUEST_HOUSE" id="guestHouses" ${hotelType != null && hotelType.toString() == 'GUEST_HOUSE' ? 'checked' : ''}>
                            <label for="guestHouses" style="font-weight: normal; margin: 0;">Guest houses</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="homeType" value="VILLA" id="villas" ${homeType != null && homeType.toString() == 'VILLA' ? 'checked' : ''}>
                            <label for="villas" style="font-weight: normal; margin: 0;">Villas</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="resorts" value="true" id="resortsType" ${resorts != null && resorts ? 'checked' : ''}>
                            <label for="resortsType" style="font-weight: normal; margin: 0;">Resorts</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="homeType" value="HOMESTAY" id="homestays" ${homeType != null && homeType.toString() == 'HOMESTAY' ? 'checked' : ''}>
                            <label for="homestays" style="font-weight: normal; margin: 0;">Homestays</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="hotelType" value="BED_BREAKFAST" id="bedBreakfast" ${hotelType != null && hotelType.toString() == 'BED_BREAKFAST' ? 'checked' : ''}>
                            <label for="bedBreakfast" style="font-weight: normal; margin: 0;">Bed and breakfasts</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="homeType" value="APARTMENT_FLAT" id="apartments" ${homeType != null && homeType.toString() == 'APARTMENT_FLAT' ? 'checked' : ''}>
                            <label for="apartments" style="font-weight: normal; margin: 0;">Apartments</label>
                        </div>
                    </div>
                </div>
                
                <hr style="margin: 20px 0; border: none; border-top: 1px solid #e0e0e0;">
                
                <!-- Facilities -->
                <div class="filter-group">
                    <h4 style="font-size: 1rem; font-weight: 600; margin-bottom: 15px; color: #333;">Facilities</h4>
                    <div class="checkbox-group" style="max-height: 300px;">
                        <div class="checkbox-item">
                            <input type="checkbox" name="parking" value="true" id="parkingFacility" ${parking != null && parking ? 'checked' : ''}>
                            <label for="parkingFacility" style="font-weight: normal; margin: 0;">Parking</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="amenities" value="RESTAURANTS" id="restaurant" ${amenities != null && amenities.contains('RESTAURANTS') ? 'checked' : ''}>
                            <label for="restaurant" style="font-weight: normal; margin: 0;">Restaurant</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="amenities" value="TWENTY_FOUR_HOUR_FRONT_DESK" id="roomService" ${amenities != null && amenities.contains('TWENTY_FOUR_HOUR_FRONT_DESK') ? 'checked' : ''}>
                            <label for="roomService" style="font-weight: normal; margin: 0;">24-hour front desk</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="amenities" value="FITNESS_CENTER" id="fitnessCentre" ${amenities != null && amenities.contains('FITNESS_CENTER') ? 'checked' : ''}>
                            <label for="fitnessCentre" style="font-weight: normal; margin: 0;">Fitness centre</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="amenities" value="NON_SMOKING" id="nonSmoking" ${amenities != null && amenities.contains('NON_SMOKING') ? 'checked' : ''}>
                            <label for="nonSmoking" style="font-weight: normal; margin: 0;">Non-smoking rooms</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="amenities" value="AIRPORT_TRANSFER" id="airportShuttle" ${amenities != null && amenities.contains('AIRPORT_TRANSFER') ? 'checked' : ''}>
                            <label for="airportShuttle" style="font-weight: normal; margin: 0;">Airport shuttle</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="amenities" value="SPA" id="spaWellness" ${amenities != null && amenities.contains('SPA') ? 'checked' : ''}>
                            <label for="spaWellness" style="font-weight: normal; margin: 0;">Spa and wellness centre</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="amenities" value="FREE_WIFI" id="freeWifi" ${amenities != null && amenities.contains('FREE_WIFI') ? 'checked' : ''}>
                            <label for="freeWifi" style="font-weight: normal; margin: 0;">Free WiFi</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="amenities" value="FACILITIES_FOR_DISABLED_GUESTS" id="wheelchairAccessible" ${amenities != null && amenities.contains('FACILITIES_FOR_DISABLED_GUESTS') ? 'checked' : ''}>
                            <label for="wheelchairAccessible" style="font-weight: normal; margin: 0;">Wheelchair accessible</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="swimmingPool" value="true" id="swimmingPoolFacility" ${swimmingPool != null && swimmingPool ? 'checked' : ''}>
                            <label for="swimmingPoolFacility" style="font-weight: normal; margin: 0;">Swimming pool</label>
                        </div>
                    </div>
                </div>
                
                <hr style="margin: 20px 0; border: none; border-top: 1px solid #e0e0e0;">
                
                <!-- Travel group -->
                <div class="filter-group">
                    <h4 style="font-size: 1rem; font-weight: 600; margin-bottom: 15px; color: #333;">Travel group</h4>
                    <div class="checkbox-group">
                        <div class="checkbox-item">
                            <input type="checkbox" name="petsAllowed" value="true" id="petsAllowed" ${petsAllowed != null && petsAllowed ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="petsAllowed" style="font-weight: normal; margin: 0;">Pets allowed</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="adultsOnly" value="true" id="adultsOnly" ${adultsOnly != null && adultsOnly ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="adultsOnly" style="font-weight: normal; margin: 0;">Adults only</label>
                        </div>
                    </div>
                </div>
                
                <hr style="margin: 20px 0; border: none; border-top: 1px solid #e0e0e0;">
                
                <!-- Star Rating -->
                <div class="filter-group">
                    <h4 style="font-size: 1rem; font-weight: 600; margin-bottom: 15px; color: #333;">Star rating</h4>
                    <div class="checkbox-group">
                        <div class="checkbox-item">
                            <input type="checkbox" name="starRating" value="1" id="star1" ${starRating != null && starRating >= 1 ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="star1" style="font-weight: normal; margin: 0;">1 star</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="starRating" value="2" id="star2" ${starRating != null && starRating >= 2 ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="star2" style="font-weight: normal; margin: 0;">2 stars</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="starRating" value="3" id="star3" ${starRating != null && starRating >= 3 ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="star3" style="font-weight: normal; margin: 0;">3 stars</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="starRating" value="4" id="star4" ${starRating != null && starRating >= 4 ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="star4" style="font-weight: normal; margin: 0;">4 stars</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="starRating" value="5" id="star5" ${starRating != null && starRating == 5 ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="star5" style="font-weight: normal; margin: 0;">5 stars</label>
                        </div>
                    </div>
                </div>
                
                <hr style="margin: 20px 0; border: none; border-top: 1px solid #e0e0e0;">
                
                <!-- Room facilities -->
                <div class="filter-group">
                    <h4 style="font-size: 1rem; font-weight: 600; margin-bottom: 15px; color: #333;">Room facilities</h4>
                    <div class="checkbox-group" style="max-height: 300px;">
                        <div class="checkbox-item">
                            <input type="checkbox" name="roomFacilities" value="SEA_VIEW" id="seaView" ${roomFacilities != null && roomFacilities.contains('SEA_VIEW') ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="seaView" style="font-weight: normal; margin: 0;">Sea view</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="roomFacilities" value="BALCONY" id="balcony" ${roomFacilities != null && roomFacilities.contains('BALCONY') ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="balcony" style="font-weight: normal; margin: 0;">Balcony</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="roomFacilities" value="PRIVATE_BATHROOM" id="privateBathroom" ${roomFacilities != null && roomFacilities.contains('PRIVATE_BATHROOM') ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="privateBathroom" style="font-weight: normal; margin: 0;">Private bathroom</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="roomFacilities" value="AIR_CONDITIONING" id="airConditioning" ${roomFacilities != null && roomFacilities.contains('AIR_CONDITIONING') ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="airConditioning" style="font-weight: normal; margin: 0;">Air conditioning</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="roomFacilities" value="PRIVATE_POOL" id="privatePool" ${roomFacilities != null && roomFacilities.contains('PRIVATE_POOL') ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="privatePool" style="font-weight: normal; margin: 0;">Private pool</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="roomFacilities" value="KITCHEN" id="kitchen" ${roomFacilities != null && roomFacilities.contains('KITCHEN') ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="kitchen" style="font-weight: normal; margin: 0;">Kitchen/kitchenette</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="roomFacilities" value="VIEW" id="view" ${roomFacilities != null && roomFacilities.contains('VIEW') ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="view" style="font-weight: normal; margin: 0;">View</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="roomFacilities" value="HOT_TUB" id="hotTub" ${roomFacilities != null && roomFacilities.contains('HOT_TUB') ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="hotTub" style="font-weight: normal; margin: 0;">Hot tub</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="roomFacilities" value="BATH" id="bath" ${roomFacilities != null && roomFacilities.contains('BATH') ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="bath" style="font-weight: normal; margin: 0;">Bath</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="roomFacilities" value="HEATING" id="heating" ${roomFacilities != null && roomFacilities.contains('HEATING') ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="heating" style="font-weight: normal; margin: 0;">Heating</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="roomFacilities" value="TV" id="tv" ${roomFacilities != null && roomFacilities.contains('TV') ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="tv" style="font-weight: normal; margin: 0;">TV</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="roomFacilities" value="SHOWER" id="shower" ${roomFacilities != null && roomFacilities.contains('SHOWER') ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="shower" style="font-weight: normal; margin: 0;">Shower</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="roomFacilities" value="REFRIGERATOR" id="refrigerator" ${roomFacilities != null && roomFacilities.contains('REFRIGERATOR') ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="refrigerator" style="font-weight: normal; margin: 0;">Refrigerator</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="roomFacilities" value="MICROWAVE" id="microwave" ${roomFacilities != null && roomFacilities.contains('MICROWAVE') ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="microwave" style="font-weight: normal; margin: 0;">Microwave</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="roomFacilities" value="COFFEE_TEA_MAKER" id="coffeeTeaMaker" ${roomFacilities != null && roomFacilities.contains('COFFEE_TEA_MAKER') ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="coffeeTeaMaker" style="font-weight: normal; margin: 0;">Coffee/tea maker</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="roomFacilities" value="MOUNTAIN_VIEW" id="mountainView" ${roomFacilities != null && roomFacilities.contains('MOUNTAIN_VIEW') ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="mountainView" style="font-weight: normal; margin: 0;">Mountain view</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="roomFacilities" value="DISHWASHER" id="dishwasher" ${roomFacilities != null && roomFacilities.contains('DISHWASHER') ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="dishwasher" style="font-weight: normal; margin: 0;">Dishwasher</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="roomFacilities" value="FIREPLACE" id="fireplace" ${roomFacilities != null && roomFacilities.contains('FIREPLACE') ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="fireplace" style="font-weight: normal; margin: 0;">Fireplace</label>
                        </div>
                    </div>
                </div>
                
                <hr style="margin: 20px 0; border: none; border-top: 1px solid #e0e0e0;">
                
                <!-- Beach access -->
                <div class="filter-group">
                    <h4 style="font-size: 1rem; font-weight: 600; margin-bottom: 15px; color: #333;">Beach access</h4>
                    <div class="checkbox-group">
                        <div class="checkbox-item">
                            <input type="checkbox" name="beachfront" value="true" id="beachfrontAccess" ${beachfront != null && beachfront ? 'checked' : ''} onchange="this.form.submit();">
                            <label for="beachfrontAccess" style="font-weight: normal; margin: 0;">Beachfront</label>
                        </div>
                    </div>
                </div>
                
                <button type="submit" class="apply-filters-btn">
                    <i class="fas fa-search"></i> Apply Filters
                </button>
                <a href="/pilgrim/accommodation/user/search" style="display: block; text-align: center; margin-top: 10px; color: #667eea; text-decoration: none; font-size: 0.9rem;">
                    <i class="fas fa-redo"></i> Reset Filters
                </a>
            </form>
        </div>
        
        <div class="results-content">
            <div class="results-header">
                <h2>Search Results</h2>
                <span class="results-count">${properties.size()} properties found</span>
            </div>
            
            <c:choose>
                <c:when test="${not empty properties && properties.size() > 0}">
                    <div class="properties-grid">
                        <c:forEach var="property" items="${properties}">
                            <div class="property-card" onclick="window.location.href='/pilgrim/accommodation/property/view/${property.id}'">
                                <div class="property-image">
                                    <c:choose>
                                        <c:when test="${not empty property.photos && property.photos.size() > 0}">
                                            <img src="/uploads/${property.photos[0].filePath}" 
                                                 alt="Property Image" 
                                                 onerror="this.onerror=null; this.parentElement.innerHTML='<i class=\'fas fa-building\' style=\'font-size: 3rem; color: #999;\'></i>';">
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-building" style="font-size: 3rem; color: #999;"></i>
                                        </c:otherwise>
                                    </c:choose>
                                    <button class="wishlist-btn ${wishlistPropertyIds != null && wishlistPropertyIds.contains(property.id) ? 'active' : ''}" 
                                            onclick="event.stopPropagation(); toggleWishlist(${property.id}, this);"
                                            title="${wishlistPropertyIds != null && wishlistPropertyIds.contains(property.id) ? 'Remove from wishlist' : 'Add to wishlist'}">
                                        <i class="fas fa-heart"></i>
                                    </button>
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
                                    <div class="property-title">
                                        <c:choose><c:when test="${property.details != null && property.details.propertyName != null}">${property.details.propertyName}</c:when><c:otherwise>Property #${property.id}</c:otherwise></c:choose>
                                    </div>
                                    <div class="property-location">
                                        <i class="fas fa-map-marker-alt"></i>
                                        <c:choose>
                                            <c:when test="${property.details != null && property.details.propertyName != null && property.location != null}">
                                                ${property.details.propertyName}
                                                <c:if test="${property.location.city != null}">, ${property.location.city}</c:if>
                                                <c:if test="${property.location.state != null}">, ${property.location.state}</c:if>
                                            </c:when>
                                            <c:when test="${property.location != null}">
                                                <c:if test="${property.location.city != null}">${property.location.city}</c:if>
                                                <c:if test="${property.location.state != null}">, ${property.location.state}</c:if>
                                            </c:when>
                                            <c:otherwise>
                                                Location not available
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
                                        </div>
                                    </c:if>
                                    <div class="property-price">
                                        <div>
                                            <c:if test="${not empty property.rooms}">
                                                <div class="price">₹${property.rooms[0].minimumRoomRate}</div>
                                                <div class="price-label">per night</div>
                                            </c:if>
                                        </div>
                                        <a href="/pilgrim/accommodation/property/view/${property.id}" class="btn-view" onclick="event.stopPropagation();">
                                            <i class="fas fa-arrow-right"></i> View
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-search"></i>
                        <h3>No Properties Found</h3>
                        <p>Try adjusting your search criteria or filters to find more properties.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <script>
        function toggleWishlist(propertyId, button) {
            const isActive = button.classList.contains('active');
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = isActive ? '/pilgrim/accommodation/user/wishlist/remove/' + propertyId : '/pilgrim/accommodation/user/wishlist/add/' + propertyId;
            
            // Add search parameters
            const location = '${location != null ? location : ""}';
            const checkIn = '${checkIn != null ? checkIn : ""}';
            const checkOut = '${checkOut != null ? checkOut : ""}';
            const guests = '${guests != null ? guests : ""}';
            
            if (location) {
                const input1 = document.createElement('input');
                input1.type = 'hidden';
                input1.name = 'location';
                input1.value = location;
                form.appendChild(input1);
            }
            if (checkIn) {
                const input2 = document.createElement('input');
                input2.type = 'hidden';
                input2.name = 'checkIn';
                input2.value = checkIn;
                form.appendChild(input2);
            }
            if (checkOut) {
                const input3 = document.createElement('input');
                input3.type = 'hidden';
                input3.name = 'checkOut';
                input3.value = checkOut;
                form.appendChild(input3);
            }
            if (guests) {
                const input4 = document.createElement('input');
                input4.type = 'hidden';
                input4.name = 'guests';
                input4.value = guests;
                form.appendChild(input4);
            }
            
            document.body.appendChild(form);
            form.submit();
        }
    </script>
</body>
</html>

