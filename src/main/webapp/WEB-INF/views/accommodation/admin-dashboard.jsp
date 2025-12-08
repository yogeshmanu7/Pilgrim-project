<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - GlobalPiligrim Accommodation</title>
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
        .header .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .container {
            max-width: 1400px;
            margin: 30px auto;
            padding: 0 20px;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
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
        .stat-icon.properties { background: #667eea; }
        .stat-icon.pending { background: #ff9800; }
        .stat-icon.users { background: #4caf50; }
        .stat-icon.complaints { background: #f44336; }
        .stat-icon.refunds { background: #9c27b0; }
        .stat-icon.payouts { background: #2196f3; }
        .stat-icon.bookings { background: #ff6b6b; }
        .stat-info h3 {
            color: #333;
            font-size: 2rem;
            margin-bottom: 5px;
        }
        .stat-info p {
            color: #666;
            font-size: 0.9rem;
        }
        .section {
            background: white;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 30px;
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
        .section-header a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
        }
        .table {
            width: 100%;
            border-collapse: collapse;
        }
        .table th {
            background: #f5f5f5;
            padding: 12px;
            text-align: left;
            color: #666;
            font-weight: 600;
            font-size: 0.9rem;
        }
        .table td {
            padding: 12px;
            border-top: 1px solid #e0e0e0;
            color: #333;
        }
        .table tr:hover {
            background: #f9f9f9;
        }
        .badge {
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: 500;
        }
        .badge.pending { background: #fff3cd; color: #856404; }
        .badge.approved { background: #d4edda; color: #155724; }
        .badge.rejected { background: #f8d7da; color: #721c24; }
        .badge.on-hold { background: #d1ecf1; color: #0c5460; }
        .action-buttons {
            display: flex;
            gap: 8px;
        }
        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.85rem;
            text-decoration: none;
            display: inline-block;
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
    </style>
</head>
<body>
    <div class="header">
        <h1><i class="fas fa-shield-alt"></i> Admin Dashboard</h1>
        <div class="user-info">
            <span>Welcome, Admin</span>
            <a href="/pilgrim/accommodation/logout" style="color: #667eea; text-decoration: none;">Logout</a>
        </div>
    </div>
    
    <div class="nav-menu">
        <ul>
            <li><a href="/pilgrim/accommodation/admin/dashboard" class="active">Dashboard</a></li>
            <li><a href="/pilgrim/accommodation/admin/properties">Properties</a></li>
            <li><a href="/pilgrim/accommodation/admin/users">Users</a></li>
            <li><a href="/pilgrim/accommodation/admin/complaints">Complaints</a></li>
            <li><a href="/pilgrim/accommodation/admin/refunds">Refunds</a></li>
            <li><a href="/pilgrim/accommodation/admin/payouts">Payouts</a></li>
            <li><a href="/pilgrim/accommodation/admin/bookings">Bookings</a></li>
        </ul>
    </div>
    
    <div class="container">
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon properties">
                    <i class="fas fa-building"></i>
                </div>
                <div class="stat-info">
                    <h3>${totalProperties}</h3>
                    <p>Total Properties</p>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon pending">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-info">
                    <h3>${pendingProperties}</h3>
                    <p>Pending Review</p>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon users">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-info">
                    <h3>${totalUsers}</h3>
                    <p>Total Users</p>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon complaints">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <div class="stat-info">
                    <h3>${pendingComplaints}</h3>
                    <p>Pending Complaints</p>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon refunds">
                    <i class="fas fa-undo"></i>
                </div>
                <div class="stat-info">
                    <h3>${pendingRefunds}</h3>
                    <p>Pending Refunds</p>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon payouts">
                    <i class="fas fa-money-bill-wave"></i>
                </div>
                <div class="stat-info">
                    <h3>${pendingPayouts}</h3>
                    <p>Pending Payouts</p>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon bookings">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <div class="stat-info">
                    <h3>${pendingBookings}</h3>
                    <p>Pending Bookings</p>
                </div>
            </div>
        </div>
        
        <div class="section">
            <div class="section-header">
                <h2>Recent Pending Properties</h2>
                <a href="/pilgrim/accommodation/admin/properties?status=PENDING_REVIEW">View All <i class="fas fa-arrow-right"></i></a>
            </div>
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Property Name</th>
                        <th>Owner</th>
                        <th>Type</th>
                        <th>Status</th>
                        <th>Created</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty recentPendingProperties}">
                            <c:forEach var="property" items="${recentPendingProperties}">
                                <tr>
                                    <td>${property.id}</td>
                                    <td>${property.details != null ? property.details.propertyName : 'N/A'}</td>
                                    <td>${property.owner.fullName}</td>
                                    <td>${property.propertyType}</td>
                                    <td><span class="badge pending">${property.status}</span></td>
                                    <td>${property.createdAt}</td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="/pilgrim/accommodation/admin/property/${property.id}" class="btn btn-view">
                                                <i class="fas fa-eye"></i> View
                                            </a>
                                            <form method="post" action="/pilgrim/accommodation/admin/property/${property.id}/approve" style="display: inline;">
                                                <button type="submit" class="btn btn-approve" onclick="return confirm('Are you sure you want to approve this property?');">
                                                    <i class="fas fa-check"></i> Approve
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="7" style="text-align: center; color: #999;">No pending properties</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>

