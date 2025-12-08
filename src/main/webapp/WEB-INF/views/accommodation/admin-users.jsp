<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management - Admin - GlobalPiligrim Accommodation</title>
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
        .users-section {
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
        .users-table {
            width: 100%;
            border-collapse: collapse;
        }
        .users-table thead {
            background: #f8f9fa;
        }
        .users-table th {
            padding: 15px;
            text-align: left;
            color: #666;
            font-weight: 600;
            border-bottom: 2px solid #e0e0e0;
        }
        .users-table td {
            padding: 15px;
            border-bottom: 1px solid #e0e0e0;
        }
        .users-table tbody tr:hover {
            background: #f8f9fa;
        }
        .user-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
        }
        .user-details h4 {
            color: #333;
            margin-bottom: 4px;
        }
        .user-details p {
            color: #666;
            font-size: 0.85rem;
        }
        .role-badge {
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: 600;
            display: inline-block;
        }
        .role-badge.ADMIN {
            background: #ff9800;
            color: white;
        }
        .role-badge.PROPERTY_OWNER {
            background: #2196f3;
            color: white;
        }
        .role-badge.PILGRIM {
            background: #4caf50;
            color: white;
        }
        .status-badge {
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        .status-badge.active {
            background: #e8f5e9;
            color: #2e7d32;
        }
        .status-badge.banned {
            background: #ffebee;
            color: #c62828;
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
        .btn-ban {
            background: #f44336;
            color: white;
        }
        .btn-ban:hover {
            background: #d32f2f;
        }
        .btn-unban {
            background: #4caf50;
            color: white;
        }
        .btn-unban:hover {
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
            <li><a href="/pilgrim/accommodation/admin/users" class="active">Users</a></li>
            <li><a href="/pilgrim/accommodation/admin/complaints">Complaints</a></li>
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
                <label for="roleFilter"><i class="fas fa-filter"></i> Filter by Role:</label>
                <select id="roleFilter" onchange="window.location.href='/pilgrim/accommodation/admin/users?role=' + this.value">
                    <option value="">All Users</option>
                    <option value="ADMIN" ${currentRole == 'ADMIN' ? 'selected' : ''}>Admin</option>
                    <option value="PROPERTY_OWNER" ${currentRole == 'PROPERTY_OWNER' ? 'selected' : ''}>Property Owner</option>
                    <option value="PILGRIM" ${currentRole == 'PILGRIM' ? 'selected' : ''}>Pilgrim</option>
                </select>
            </div>
        </div>
        
        <div class="users-section">
            <div class="section-header">
                <h2><i class="fas fa-users"></i> User Management</h2>
                <span style="color: #666;">Total: ${fn:length(users)} users</span>
            </div>
            
            <c:choose>
                <c:when test="${not empty users}">
                    <table class="users-table">
                        <thead>
                            <tr>
                                <th>User</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Role</th>
                                <th>Status</th>
                                <th>Email Verified</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr>
                                    <td>
                                        <div class="user-info">
                                            <div class="user-avatar">
                                                ${fn:substring(user.fullName, 0, 1)}
                                            </div>
                                            <div class="user-details">
                                                <h4>${user.fullName}</h4>
                                                <p>@${user.username}</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td>${user.email}</td>
                                    <td>${user.phoneNumber != null ? user.phoneNumber : 'N/A'}</td>
                                    <td>
                                        <span class="role-badge ${user.role}">${user.role}</span>
                                    </td>
                                    <td>
                                        <span class="status-badge active">Active</span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${user.emailVerified}">
                                                <i class="fas fa-check-circle" style="color: #4caf50;"></i> Verified
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-times-circle" style="color: #f44336;"></i> Not Verified
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <form method="post" action="/pilgrim/accommodation/admin/user/${user.id}/ban" style="display: inline;" 
                                                  onsubmit="return confirm('Are you sure you want to ban this user?');">
                                                <button type="submit" class="btn btn-ban">
                                                    <i class="fas fa-ban"></i> Ban
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-users"></i>
                        <h3>No Users Found</h3>
                        <p>There are no users matching the selected criteria.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>

