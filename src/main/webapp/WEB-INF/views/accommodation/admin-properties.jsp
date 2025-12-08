<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Properties - Admin - GlobalPiligrim Accommodation</title>
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
        .properties-section {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .section-header h2 {
            color: #333;
            font-size: 1.3rem;
        }
        .table {
            width: 100%;
            border-collapse: collapse;
        }
        .table th {
            background: #f5f5f5;
            padding: 15px;
            text-align: left;
            color: #666;
            font-weight: 600;
            font-size: 0.9rem;
            border-bottom: 2px solid #e0e0e0;
        }
        .table td {
            padding: 15px;
            border-bottom: 1px solid #e0e0e0;
            color: #333;
        }
        .table tr:hover {
            background: #f9f9f9;
        }
        .badge {
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
            display: inline-block;
        }
        .badge.draft { background: #e0e0e0; color: #424242; }
        .badge.pending-review { background: #fff3cd; color: #856404; }
        .badge.approved { background: #d4edda; color: #155724; }
        .badge.rejected { background: #f8d7da; color: #721c24; }
        .badge.on-hold { background: #d1ecf1; color: #0c5460; }
        .badge.active { background: #c8e6c9; color: #2e7d32; }
        .badge.inactive { background: #ffcdd2; color: #c62828; }
        .badge.banned { background: #424242; color: white; }
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
        .btn-view {
            background: #667eea;
            color: white;
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
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }
        .empty-state i {
            font-size: 3rem;
            margin-bottom: 15px;
            color: #ccc;
        }
        .property-name {
            font-weight: 600;
            color: #333;
        }
        .property-type {
            color: #666;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1><i class="fas fa-building"></i> All Properties</h1>
        <div>
            <a href="/pilgrim/admin/dashboard" style="color: #667eea; text-decoration: none;">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </div>
    
    <div class="nav-menu">
        <ul>
            <li><a href="/pilgrim/admin/dashboard">Dashboard</a></li>
            <li><a href="/pilgrim/admin/accommodation/properties" class="active">Properties</a></li>
            <li><a href="/pilgrim/admin/accommodation/users">Users</a></li>
            <li><a href="/pilgrim/admin/accommodation/complaints">Complaints</a></li>
            <li><a href="/pilgrim/admin/accommodation/refunds">Refunds</a></li>
            <li><a href="/pilgrim/admin/accommodation/payouts">Payouts</a></li>
            <li><a href="/pilgrim/admin/accommodation/bookings">Bookings</a></li>
        </ul>
    </div>
    
    <div class="container">
        <c:if test="${not empty success}">
            <div class="success-message">
                <i class="fas fa-check-circle"></i> ${success}
            </div>
        </c:if>
        
        <div class="filters">
            <div class="filter-group">
                <label><i class="fas fa-filter"></i> Filter by Status:</label>
                <select id="statusFilter" onchange="filterByStatus()">
                    <option value="">All Properties</option>
                    <option value="PENDING_REVIEW" ${currentStatus == 'PENDING_REVIEW' ? 'selected' : ''}>Pending Review</option>
                    <option value="APPROVED" ${currentStatus == 'APPROVED' ? 'selected' : ''}>Approved</option>
                    <option value="REJECTED" ${currentStatus == 'REJECTED' ? 'selected' : ''}>Rejected</option>
                    <option value="ON_HOLD" ${currentStatus == 'ON_HOLD' ? 'selected' : ''}>On Hold</option>
                    <option value="ACTIVE" ${currentStatus == 'ACTIVE' ? 'selected' : ''}>Active</option>
                    <option value="INACTIVE" ${currentStatus == 'INACTIVE' ? 'selected' : ''}>Inactive</option>
                    <option value="DRAFT" ${currentStatus == 'DRAFT' ? 'selected' : ''}>Draft</option>
                </select>
            </div>
            <div style="margin-left: auto; color: #666; font-weight: 500;">
                Total: <strong>${properties.size()}</strong> properties
            </div>
        </div>
        
        <div class="properties-section">
            <div class="section-header">
                <h2>Registered Properties</h2>
            </div>
            
            <c:choose>
                <c:when test="${not empty properties}">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Property Name</th>
                                <th>Owner</th>
                                <th>Type</th>
                                <th>Location</th>
                                <th>Status</th>
                                <th>Created</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="property" items="${properties}">
                                <tr>
                                    <td>${property.id}</td>
                                    <td>
                                        <div class="property-name">
                                            ${property.details != null && property.details.propertyName != null ? property.details.propertyName : 'N/A'}
                                        </div>
                                        <div class="property-type">${property.propertyType}</div>
                                    </td>
                                    <td>
                                        <strong>${property.owner.fullName}</strong><br>
                                        <small style="color: #999;">${property.owner.email}</small>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${property.homeType != null}">${property.homeType}</c:when>
                                            <c:when test="${property.hotelType != null}">${property.hotelType}</c:when>
                                            <c:when test="${property.uniqueType != null}">${property.uniqueType}</c:when>
                                            <c:otherwise>N/A</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${property.location != null}">
                                                ${property.location.city != null ? property.location.city : 'N/A'}, 
                                                ${property.location.state != null ? property.location.state : 'N/A'}
                                            </c:when>
                                            <c:otherwise>Not set</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <span class="badge ${property.status.toString().toLowerCase().replace('_', '-')}">
                                            ${property.status}
                                        </span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${property.createdAt != null}">
                                                ${property.createdAt}
                                            </c:when>
                                            <c:otherwise>N/A</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="/pilgrim/accommodation/admin/property/${property.id}" class="btn btn-view">
                                                <i class="fas fa-eye"></i> View
                                            </a>
                                            
                                            <c:if test="${property.status == 'PENDING_REVIEW' || property.status == 'ON_HOLD'}">
                                                <form method="post" action="/pilgrim/accommodation/admin/property/${property.id}/approve" style="display: inline;">
                                                    <button type="submit" class="btn btn-approve" onclick="return confirm('Are you sure you want to approve this property?');">
                                                        <i class="fas fa-check"></i> Approve
                                                    </button>
                                                </form>
                                            </c:if>
                                            
                                            <c:if test="${property.status == 'PENDING_REVIEW' || property.status == 'APPROVED'}">
                                                <form method="post" action="/pilgrim/accommodation/admin/property/${property.id}/reject" style="display: inline;">
                                                    <button type="submit" class="btn btn-reject" onclick="return confirm('Are you sure you want to reject this property?');">
                                                        <i class="fas fa-times"></i> Reject
                                                    </button>
                                                </form>
                                            </c:if>
                                            
                                            <c:if test="${property.status == 'PENDING_REVIEW' || property.status == 'APPROVED'}">
                                                <form method="post" action="/pilgrim/accommodation/admin/property/${property.id}/hold" style="display: inline;">
                                                    <button type="submit" class="btn btn-hold" onclick="return confirm('Are you sure you want to put this property on hold?');">
                                                        <i class="fas fa-pause"></i> Hold
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
                        <i class="fas fa-building"></i>
                        <h3>No properties found</h3>
                        <p>There are no properties matching your filter criteria.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <script>
        function filterByStatus() {
            const status = document.getElementById('statusFilter').value;
            if (status) {
                window.location.href = '/pilgrim/admin/accommodation/properties?status=' + status;
            } else {
                window.location.href = '/pilgrim/admin/accommodation/properties';
            }
        }
    </script>
</body>
</html>

