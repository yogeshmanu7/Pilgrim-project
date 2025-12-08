<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complaint Management - Admin - GlobalPiligrim Accommodation</title>
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
        .complaints-section {
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
        .complaints-table {
            width: 100%;
            border-collapse: collapse;
        }
        .complaints-table thead {
            background: #f8f9fa;
        }
        .complaints-table th {
            padding: 15px;
            text-align: left;
            color: #666;
            font-weight: 600;
            border-bottom: 2px solid #e0e0e0;
        }
        .complaints-table td {
            padding: 15px;
            border-bottom: 1px solid #e0e0e0;
        }
        .complaints-table tbody tr:hover {
            background: #f8f9fa;
        }
        .complaint-info {
            max-width: 300px;
        }
        .complaint-info h4 {
            color: #333;
            margin-bottom: 5px;
        }
        .complaint-info p {
            color: #666;
            font-size: 0.85rem;
            margin: 2px 0;
        }
        .description {
            max-width: 400px;
            color: #333;
            line-height: 1.5;
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
        .status-badge.REVIEWED {
            background: #d1ecf1;
            color: #0c5460;
        }
        .status-badge.RESOLVED {
            background: #d4edda;
            color: #155724;
        }
        .status-badge.DISMISSED {
            background: #f8d7da;
            color: #721c24;
        }
        .action-buttons {
            display: flex;
            gap: 10px;
        }
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.9rem;
            font-weight: 500;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s;
        }
        .btn-view {
            background: #667eea;
            color: white;
        }
        .btn-view:hover {
            background: #5568d3;
        }
        .btn-resolve {
            background: #4caf50;
            color: white;
        }
        .btn-resolve:hover {
            background: #388e3c;
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
            <li><a href="/pilgrim/accommodation/admin/complaints" class="active">Complaints</a></li>
            <li><a href="/pilgrim/accommodation/admin/refunds">Refunds</a></li>
            <li><a href="/pilgrim/accommodation/admin/payouts">Payouts</a></li>
            <li><a href="/pilgrim/accommodation/admin/bookings">Bookings</a></li>
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
                <select id="statusFilter" onchange="window.location.href='/pilgrim/accommodation/admin/complaints?status=' + this.value">
                    <option value="">All Complaints</option>
                    <option value="PENDING" ${currentStatus == 'PENDING' ? 'selected' : ''}>Pending</option>
                    <option value="REVIEWED" ${currentStatus == 'REVIEWED' ? 'selected' : ''}>Reviewed</option>
                    <option value="RESOLVED" ${currentStatus == 'RESOLVED' ? 'selected' : ''}>Resolved</option>
                    <option value="DISMISSED" ${currentStatus == 'DISMISSED' ? 'selected' : ''}>Dismissed</option>
                </select>
            </div>
        </div>
        
        <div class="complaints-section">
            <div class="section-header">
                <h2><i class="fas fa-exclamation-triangle"></i> Complaint Management</h2>
                <span style="color: #666;">Total: ${fn:length(complaints)} complaints</span>
            </div>
            
            <c:choose>
                <c:when test="${not empty complaints}">
                    <table class="complaints-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Reporter</th>
                                <th>Reported User</th>
                                <th>Property</th>
                                <th>Description</th>
                                <th>Status</th>
                                <th>Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="complaint" items="${complaints}">
                                <tr>
                                    <td>#${complaint.id}</td>
                                    <td>
                                        <div class="complaint-info">
                                            <h4>${complaint.reporter != null ? complaint.reporter.fullName : 'N/A'}</h4>
                                            <p>${complaint.reporter != null ? complaint.reporter.email : ''}</p>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="complaint-info">
                                            <h4>${complaint.reportedUser != null ? complaint.reportedUser.fullName : 'N/A'}</h4>
                                            <p>${complaint.reportedUser != null ? complaint.reportedUser.email : ''}</p>
                                        </div>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${complaint.property != null}">
                                                <div class="complaint-info">
                                                    <h4>
                                                        <c:choose>
                                                            <c:when test="${complaint.property.details != null && complaint.property.details.propertyName != null}">
                                                                ${complaint.property.details.propertyName}
                                                            </c:when>
                                                            <c:otherwise>
                                                                Property #${complaint.property.id}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </h4>
                                                    <p>ID: ${complaint.property.id}</p>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color: #999;">N/A</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="description">
                                            ${fn:length(complaint.description) > 100 ? fn:substring(complaint.description, 0, 100) : complaint.description}${fn:length(complaint.description) > 100 ? '...' : ''}
                                        </div>
                                    </td>
                                    <td>
                                        <span class="status-badge ${complaint.status}">${complaint.status}</span>
                                    </td>
                                    <td>
                                        <div class="date-info">
                                            ${complaint.createdAt}
                                        </div>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="/pilgrim/accommodation/admin/complaint/${complaint.id}" class="btn btn-view">
                                                <i class="fas fa-eye"></i> View
                                            </a>
                                            <c:if test="${complaint.status == 'PENDING' || complaint.status == 'REVIEWED'}">
                                                <form method="post" action="/pilgrim/accommodation/admin/complaint/${complaint.id}/resolve" style="display: inline;">
                                                    <button type="submit" class="btn btn-resolve">
                                                        <i class="fas fa-check"></i> Resolve
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
                        <i class="fas fa-inbox"></i>
                        <h3>No Complaints Found</h3>
                        <p>There are no complaints matching the selected criteria.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>

