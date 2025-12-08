<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Property Details - Admin - GlobalPiligrim Accommodation</title>
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
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }
        .property-card {
            background: white;
            border-radius: 12px;
            padding: 30px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .property-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #e0e0e0;
        }
        .property-header h2 {
            color: #333;
            font-size: 1.8rem;
        }
        .badge {
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
        }
        .badge.pending { background: #fff3cd; color: #856404; }
        .badge.approved { background: #d4edda; color: #155724; }
        .badge.rejected { background: #f8d7da; color: #721c24; }
        .badge.on-hold { background: #d1ecf1; color: #0c5460; }
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .info-item {
            padding: 15px;
            background: #f9f9f9;
            border-radius: 8px;
        }
        .info-item label {
            display: block;
            color: #666;
            font-size: 0.85rem;
            margin-bottom: 5px;
        }
        .info-item .value {
            color: #333;
            font-weight: 500;
            font-size: 1rem;
        }
        .action-buttons {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 2px solid #e0e0e0;
        }
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 500;
            text-decoration: none;
            display: inline-block;
        }
        .btn-approve {
            background: #4caf50;
            color: white;
        }
        .btn-reject {
            background: #f44336;
            color: white;
        }
        .btn-hold {
            background: #ff9800;
            color: white;
        }
        .btn-activate {
            background: #2196f3;
            color: white;
        }
        .btn-deactivate {
            background: #9e9e9e;
            color: white;
        }
        .btn-back {
            background: #e0e0e0;
            color: #333;
        }
        .btn:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }
        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1><i class="fas fa-shield-alt"></i> Property Details</h1>
        <div>
            <a href="/pilgrim/accommodation/admin/dashboard" class="btn btn-back">Back to Dashboard</a>
        </div>
    </div>
    
    <div class="nav-menu">
        <ul>
            <li><a href="/pilgrim/accommodation/admin/dashboard">Dashboard</a></li>
            <li><a href="/pilgrim/accommodation/admin/properties" class="active">Properties</a></li>
            <li><a href="/pilgrim/accommodation/admin/users">Users</a></li>
            <li><a href="/pilgrim/accommodation/admin/complaints">Complaints</a></li>
            <li><a href="/pilgrim/accommodation/admin/refunds">Refunds</a></li>
            <li><a href="/pilgrim/accommodation/admin/payouts">Payouts</a></li>
        </ul>
    </div>
    
    <div class="container">
        <c:if test="${not empty success}">
            <div class="success-message">
                <i class="fas fa-check-circle"></i> ${success}
            </div>
        </c:if>
        
        <c:if test="${not empty property}">
            <div class="property-card">
                <div class="property-header">
                    <div>
                        <h2><c:choose><c:when test="${property.details != null && property.details.propertyName != null}">${property.details.propertyName}</c:when><c:otherwise>Property #${property.id}</c:otherwise></c:choose></h2>
                        <p style="color: #666; margin-top: 5px;">Reference ID: ${property.referenceId != null ? property.referenceId : 'N/A'}</p>
                    </div>
                    <span class="badge ${property.status.toString().toLowerCase().replace('_', '-')}">${property.status}</span>
                </div>
                
                <div class="info-grid">
                    <div class="info-item">
                        <label><i class="fas fa-user"></i> Owner</label>
                        <div class="value">${property.owner.fullName}</div>
                    </div>
                    <div class="info-item">
                        <label><i class="fas fa-envelope"></i> Owner Email</label>
                        <div class="value">${property.owner.email}</div>
                    </div>
                    <div class="info-item">
                        <label><i class="fas fa-building"></i> Property Type</label>
                        <div class="value">${property.propertyType}</div>
                    </div>
                    <div class="info-item">
                        <label><i class="fas fa-home"></i> Home Type</label>
                        <div class="value">${property.homeType != null ? property.homeType : 'N/A'}</div>
                    </div>
                    <div class="info-item">
                        <label><i class="fas fa-hotel"></i> Hotel Type</label>
                        <div class="value">${property.hotelType != null ? property.hotelType : 'N/A'}</div>
                    </div>
                    <div class="info-item">
                        <label><i class="fas fa-star"></i> Star Rating</label>
                        <div class="value">${property.details != null && property.details.starRating != null ? property.details.starRating : 'N/A'}</div>
                    </div>
                    <div class="info-item">
                        <label><i class="fas fa-map-marker-alt"></i> Location</label>
                        <div class="value">
                            <c:choose>
                                <c:when test="${property.location != null}">
                                    ${property.location.streetAddress}, ${property.location.city}, ${property.location.state}, ${property.location.country}
                                </c:when>
                                <c:otherwise>Not set</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="info-item">
                        <label><i class="fas fa-calendar"></i> Created At</label>
                        <div class="value">${property.createdAt}</div>
                    </div>
                </div>
                
                <div class="action-buttons">
                    <c:if test="${property.status == 'PENDING_REVIEW'}">
                        <form method="post" action="/pilgrim/accommodation/admin/property/${property.id}/approve" style="display: inline;">
                            <button type="submit" class="btn btn-approve">
                                <i class="fas fa-check"></i> Approve
                            </button>
                        </form>
                        <form method="post" action="/pilgrim/accommodation/admin/property/${property.id}/reject" style="display: inline;">
                            <button type="submit" class="btn btn-reject">
                                <i class="fas fa-times"></i> Reject
                            </button>
                        </form>
                        <form method="post" action="/pilgrim/accommodation/admin/property/${property.id}/hold" style="display: inline;">
                            <button type="submit" class="btn btn-hold">
                                <i class="fas fa-pause"></i> Put on Hold
                            </button>
                        </form>
                    </c:if>
                    <c:if test="${property.status == 'APPROVED' || property.status == 'ACTIVE'}">
                        <form method="post" action="/pilgrim/accommodation/admin/property/${property.id}/deactivate" style="display: inline;">
                            <button type="submit" class="btn btn-deactivate">
                                <i class="fas fa-eye-slash"></i> Deactivate
                            </button>
                        </form>
                    </c:if>
                    <c:if test="${property.status == 'INACTIVE'}">
                        <form method="post" action="/pilgrim/accommodation/admin/property/${property.id}/activate" style="display: inline;">
                            <button type="submit" class="btn btn-activate">
                                <i class="fas fa-eye"></i> Activate
                            </button>
                        </form>
                    </c:if>
                    <a href="/pilgrim/accommodation/admin/properties" class="btn btn-back">
                        <i class="fas fa-arrow-left"></i> Back to Properties
                    </a>
                </div>
            </div>
        </c:if>
        
        <c:if test="${empty property}">
            <div class="property-card">
                <p style="text-align: center; color: #999; padding: 40px;">Property not found</p>
                <div style="text-align: center;">
                    <a href="/pilgrim/accommodation/admin/properties" class="btn btn-back">Back to Properties</a>
                </div>
            </div>
        </c:if>
    </div>
</body>
</html>

