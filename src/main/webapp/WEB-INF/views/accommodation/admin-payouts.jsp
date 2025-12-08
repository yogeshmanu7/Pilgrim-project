<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payout Management - Admin - GlobalPiligrim Accommodation</title>
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
        .payouts-section {
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
        .payouts-table {
            width: 100%;
            border-collapse: collapse;
        }
        .payouts-table thead {
            background: #f8f9fa;
        }
        .payouts-table th {
            padding: 15px;
            text-align: left;
            color: #666;
            font-weight: 600;
            border-bottom: 2px solid #e0e0e0;
        }
        .payouts-table td {
            padding: 15px;
            border-bottom: 1px solid #e0e0e0;
        }
        .payouts-table tbody tr:hover {
            background: #f8f9fa;
        }
        .payout-info {
            max-width: 200px;
        }
        .payout-info h4 {
            color: #333;
            margin-bottom: 5px;
        }
        .payout-info p {
            color: #666;
            font-size: 0.85rem;
            margin: 2px 0;
        }
        .amount {
            font-size: 1.1rem;
            font-weight: 700;
            color: #4caf50;
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
        .status-badge.APPROVED {
            background: #d4edda;
            color: #155724;
        }
        .status-badge.REJECTED {
            background: #f8d7da;
            color: #721c24;
        }
        .status-badge.PROCESSED {
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
        .btn-process {
            background: #2196f3;
            color: white;
        }
        .btn-process:hover {
            background: #1976d2;
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
            <li><a href="/pilgrim/accommodation/admin/complaints">Complaints</a></li>
            <li><a href="/pilgrim/accommodation/admin/refunds">Refunds</a></li>
            <li><a href="/pilgrim/accommodation/admin/payouts" class="active">Payouts</a></li>
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
                <select id="statusFilter" onchange="window.location.href='/pilgrim/accommodation/admin/payouts?status=' + this.value">
                    <option value="">All Payouts</option>
                    <option value="PENDING" ${currentStatus == 'PENDING' ? 'selected' : ''}>Pending</option>
                    <option value="APPROVED" ${currentStatus == 'APPROVED' ? 'selected' : ''}>Approved</option>
                    <option value="REJECTED" ${currentStatus == 'REJECTED' ? 'selected' : ''}>Rejected</option>
                    <option value="PROCESSED" ${currentStatus == 'PROCESSED' ? 'selected' : ''}>Processed</option>
                </select>
            </div>
        </div>
        
        <div class="payouts-section">
            <div class="section-header">
                <h2><i class="fas fa-hand-holding-usd"></i> Payout Management</h2>
                <span style="color: #666;">Total: ${fn:length(payouts)} payouts</span>
            </div>
            
            <c:choose>
                <c:when test="${not empty payouts}">
                    <table class="payouts-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Property Owner</th>
                                <th>Property</th>
                                <th>Amount</th>
                                <th>Status</th>
                                <th>Created Date</th>
                                <c:if test="${not empty payouts[0].processedAt}">
                                    <th>Processed Date</th>
                                </c:if>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="payout" items="${payouts}">
                                <tr>
                                    <td>#${payout.id}</td>
                                    <td>
                                        <div class="payout-info">
                                            <h4>${payout.owner != null ? payout.owner.fullName : 'N/A'}</h4>
                                            <p>${payout.owner != null ? payout.owner.email : ''}</p>
                                        </div>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${payout.property != null}">
                                                <div class="payout-info">
                                                    <h4>
                                                        <c:choose>
                                                            <c:when test="${payout.property.details != null && payout.property.details.propertyName != null}">
                                                                ${payout.property.details.propertyName}
                                                            </c:when>
                                                            <c:otherwise>
                                                                Property #${payout.property.id}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </h4>
                                                    <p>ID: ${payout.property.id}</p>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color: #999;">N/A</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <span class="amount">₹${payout.amount}</span>
                                    </td>
                                    <td>
                                        <span class="status-badge ${payout.status}">${payout.status}</span>
                                    </td>
                                    <td>
                                        <div class="date-info">
                                            ${payout.createdAt}
                                        </div>
                                    </td>
                                    <c:if test="${payout.processedAt != null}">
                                        <td>
                                            <div class="date-info">
                                                ${payout.processedAt}
                                            </div>
                                        </td>
                                    </c:if>
                                    <td>
                                        <div class="action-buttons">
                                            <c:if test="${payout.status == 'PENDING'}">
                                                <form method="post" action="/pilgrim/accommodation/admin/payout/${payout.id}/approve" style="display: inline;">
                                                    <button type="submit" class="btn btn-approve">
                                                        <i class="fas fa-check"></i> Approve
                                                    </button>
                                                </form>
                                                <form method="post" action="/pilgrim/accommodation/admin/payout/${payout.id}/reject" style="display: inline;" 
                                                      onsubmit="return confirm('Are you sure you want to reject this payout?');">
                                                    <button type="submit" class="btn btn-reject">
                                                        <i class="fas fa-times"></i> Reject
                                                    </button>
                                                </form>
                                            </c:if>
                                            <c:if test="${payout.status == 'APPROVED'}">
                                                <form method="post" action="/pilgrim/accommodation/admin/payout/${payout.id}/process" style="display: inline;">
                                                    <button type="submit" class="btn btn-process">
                                                        <i class="fas fa-check-circle"></i> Process
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
                        <i class="fas fa-hand-holding-usd"></i>
                        <h3>No Payouts Found</h3>
                        <p>There are no payouts matching the selected criteria.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>

