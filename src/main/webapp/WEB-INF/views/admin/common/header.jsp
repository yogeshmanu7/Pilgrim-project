<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - Global Pilgrim Admin</title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <!-- Custom Admin CSS -->
    <style>
        :root {
            --primary-teal: #0D9488;
            --primary-teal-dark: #0F766E;
            --celestial-blue: #1E3A5F;
            --sacred-gold: #C9A227;
            --warm-amber: #F59E0B;
            --bg-dark: #0F172A;
            --bg-darker: #020617;
            --sidebar-bg: #0B1120;
            --card-bg: #1E293B;
            --text-primary: #F1F5F9;
            --text-secondary: #94A3B8;
            --border-color: #334155;
            --accent-purple: #8B5CF6;
            --accent-rose: #F43F5E;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Outfit', sans-serif;
            background: var(--bg-dark);
            background-image: 
                radial-gradient(ellipse at top right, rgba(13, 148, 136, 0.1) 0%, transparent 50%),
                radial-gradient(ellipse at bottom left, rgba(139, 92, 246, 0.08) 0%, transparent 50%);
            min-height: 100vh;
            color: var(--text-primary);
        }
        
        h1, h2, h3, h4, h5, h6 {
            font-family: 'Cormorant Garamond', serif;
            font-weight: 600;
        }
        
        /* Sidebar */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 280px;
            height: 100vh;
            background: var(--sidebar-bg);
            border-right: 1px solid var(--border-color);
            z-index: 1000;
            overflow-y: auto;
            transition: all 0.3s ease;
        }
        
        .sidebar-brand {
            padding: 25px 20px;
            border-bottom: 1px solid var(--border-color);
            background: linear-gradient(135deg, var(--celestial-blue) 0%, #0F172A 100%);
            position: relative;
            overflow: hidden;
        }
        
        .sidebar-brand::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 100%;
            height: 200%;
            background: radial-gradient(circle, rgba(13, 148, 136, 0.3) 0%, transparent 70%);
            animation: pulse 4s ease-in-out infinite;
        }
        
        @keyframes pulse {
            0%, 100% { opacity: 0.5; transform: scale(1); }
            50% { opacity: 1; transform: scale(1.1); }
        }
        
        .sidebar-brand h3 {
            color: var(--primary-teal);
            font-weight: 700;
            margin: 0;
            font-size: 1.5rem;
            position: relative;
            z-index: 1;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .sidebar-brand h3 .brand-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, var(--primary-teal), var(--accent-purple));
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            color: white;
        }
        
        .sidebar-brand small {
            color: rgba(255,255,255,0.7);
            font-family: 'Outfit', sans-serif;
            position: relative;
            z-index: 1;
        }
        
        .sidebar-nav {
            padding: 20px 0;
        }
        
        .nav-section {
            padding: 0 15px;
            margin-bottom: 20px;
        }
        
        .nav-section-title {
            color: var(--text-secondary);
            font-size: 0.7rem;
            text-transform: uppercase;
            letter-spacing: 2px;
            padding: 10px 15px;
            font-weight: 600;
        }
        
        .nav-link {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            color: var(--text-secondary);
            text-decoration: none;
            border-radius: 10px;
            margin: 3px 0;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .nav-link::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            height: 100%;
            width: 3px;
            background: var(--primary-teal);
            transform: scaleY(0);
            transition: transform 0.3s ease;
        }
        
        .nav-link:hover, .nav-link.active {
            background: linear-gradient(135deg, rgba(13, 148, 136, 0.2) 0%, rgba(139, 92, 246, 0.1) 100%);
            color: var(--primary-teal);
        }
        
        .nav-link:hover::before, .nav-link.active::before {
            transform: scaleY(1);
        }
        
        .nav-link i {
            width: 20px;
            margin-right: 12px;
            font-size: 1rem;
        }
        
        .nav-link .badge {
            margin-left: auto;
            background: var(--accent-rose);
            font-size: 0.7rem;
        }
        
        /* Main Content */
        .main-content {
            margin-left: 280px;
            min-height: 100vh;
            transition: all 0.3s ease;
        }
        
        /* Top Navbar */
        .top-navbar {
            background: rgba(15, 23, 42, 0.8);
            backdrop-filter: blur(20px);
            padding: 15px 30px;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 100;
        }
        
        .page-title {
            font-size: 1.75rem;
            color: var(--text-primary);
            margin: 0;
            font-weight: 600;
        }
        
        .user-menu {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        
        .user-avatar {
            width: 42px;
            height: 42px;
            border-radius: 12px;
            background: linear-gradient(135deg, var(--primary-teal) 0%, var(--accent-purple) 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            color: white;
            font-size: 1.1rem;
        }
        
        .dropdown-menu {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 10px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
        }
        
        .dropdown-item {
            color: var(--text-secondary);
            border-radius: 8px;
            padding: 10px 15px;
            transition: all 0.2s ease;
        }
        
        .dropdown-item:hover {
            background: linear-gradient(135deg, var(--primary-teal) 0%, var(--primary-teal-dark) 100%);
            color: white;
        }
        
        /* Content Area */
        .content-area {
            padding: 30px;
        }
        
        /* Cards */
        .card {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .card:hover {
            box-shadow: 0 8px 30px rgba(13, 148, 136, 0.15);
        }
        
        .card-header {
            background: transparent;
            border-bottom: 1px solid var(--border-color);
            padding: 20px 25px;
        }
        
        .card-title {
            color: var(--text-primary);
            margin: 0;
            font-size: 1.25rem;
        }
        
        .card-body {
            padding: 25px;
        }
        
        /* Stats Cards */
        .stat-card {
            background: linear-gradient(145deg, var(--card-bg) 0%, rgba(30, 41, 59, 0.8) 100%);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 25px;
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
        }
        
        .stat-card:hover {
            transform: translateY(-4px);
            border-color: var(--primary-teal);
        }
        
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 120px;
            height: 120px;
            background: radial-gradient(circle at top right, rgba(13, 148, 136, 0.15) 0%, transparent 70%);
        }
        
        .stat-icon {
            width: 56px;
            height: 56px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
            margin-bottom: 15px;
        }
        
        .stat-icon.teal { background: linear-gradient(135deg, var(--primary-teal) 0%, var(--primary-teal-dark) 100%); color: white; }
        .stat-icon.gold { background: linear-gradient(135deg, var(--sacred-gold) 0%, var(--warm-amber) 100%); color: white; }
        .stat-icon.purple { background: linear-gradient(135deg, var(--accent-purple) 0%, #7C3AED 100%); color: white; }
        .stat-icon.rose { background: linear-gradient(135deg, var(--accent-rose) 0%, #DC2626 100%); color: white; }
        .stat-icon.blue { background: linear-gradient(135deg, #3B82F6 0%, #1D4ED8 100%); color: white; }
        
        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-primary);
            font-family: 'Outfit', sans-serif;
        }
        
        .stat-label {
            color: var(--text-secondary);
            font-size: 0.9rem;
            font-weight: 500;
        }
        
        /* Tables */
        .table {
            color: var(--text-primary);
        }
        
        .table thead th {
            background: rgba(13, 148, 136, 0.1);
            border-bottom: 2px solid var(--primary-teal);
            color: var(--primary-teal);
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 1px;
            padding: 15px;
        }
        
        .table tbody td {
            border-bottom: 1px solid var(--border-color);
            padding: 15px;
            vertical-align: middle;
        }
        
        .table tbody tr {
            transition: background 0.2s ease;
        }
        
        .table tbody tr:hover {
            background: rgba(13, 148, 136, 0.05);
        }
        
        /* Buttons */
        .btn-primary {
            background: linear-gradient(135deg, var(--primary-teal) 0%, var(--primary-teal-dark) 100%);
            border: none;
            color: white;
            font-weight: 600;
            padding: 10px 25px;
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(13, 148, 136, 0.4);
            background: linear-gradient(135deg, var(--primary-teal-dark) 0%, var(--primary-teal) 100%);
        }
        
        .btn-danger {
            background: linear-gradient(135deg, var(--accent-rose) 0%, #DC2626 100%);
            border: none;
        }
        
        .btn-outline-primary {
            border: 2px solid var(--primary-teal);
            color: var(--primary-teal);
            background: transparent;
            border-radius: 10px;
            font-weight: 600;
        }
        
        .btn-outline-primary:hover {
            background: var(--primary-teal);
            color: white;
            border-color: var(--primary-teal);
        }
        
        .btn-outline-gold {
            border: 2px solid var(--sacred-gold);
            color: var(--sacred-gold);
            background: transparent;
        }
        
        .btn-outline-gold:hover {
            background: var(--sacred-gold);
            color: var(--bg-dark);
        }
        
        /* Forms */
        .form-control, .form-select {
            background: rgba(0,0,0,0.3);
            border: 1px solid var(--border-color);
            color: var(--text-primary);
            border-radius: 10px;
            padding: 12px 15px;
            transition: all 0.3s ease;
        }
        
        .form-control:focus, .form-select:focus {
            background: rgba(0,0,0,0.4);
            border-color: var(--primary-teal);
            box-shadow: 0 0 0 3px rgba(13, 148, 136, 0.2);
            color: var(--text-primary);
        }
        
        .form-control::placeholder {
            color: var(--text-secondary);
        }
        
        .form-label {
            color: var(--text-secondary);
            font-weight: 600;
            margin-bottom: 8px;
        }
        
        /* Badges */
        .badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.75rem;
        }
        
        .badge-pending { background: var(--warm-amber); color: #1a1a2e; }
        .badge-approved { background: #22c55e; color: white; }
        .badge-rejected { background: var(--accent-rose); color: white; }
        .badge-active { background: var(--primary-teal); color: white; }
        
        .bg-gold { background: var(--sacred-gold) !important; }
        .text-gold { color: var(--sacred-gold) !important; }
        .bg-teal { background: var(--primary-teal) !important; }
        .text-teal { color: var(--primary-teal) !important; }
        
        /* Alerts */
        .alert {
            border-radius: 12px;
            border: none;
            padding: 15px 20px;
        }
        
        .alert-success {
            background: rgba(34, 197, 94, 0.15);
            color: #22c55e;
            border-left: 4px solid #22c55e;
        }
        
        .alert-danger {
            background: rgba(244, 63, 94, 0.15);
            color: var(--accent-rose);
            border-left: 4px solid var(--accent-rose);
        }
        
        /* Pagination */
        .pagination .page-link {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            color: var(--text-secondary);
            border-radius: 8px;
            margin: 0 3px;
        }
        
        .pagination .page-item.active .page-link {
            background: var(--primary-teal);
            border-color: var(--primary-teal);
            color: white;
        }
        
        /* Scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }
        
        ::-webkit-scrollbar-track {
            background: var(--bg-darker);
        }
        
        ::-webkit-scrollbar-thumb {
            background: var(--border-color);
            border-radius: 4px;
        }
        
        ::-webkit-scrollbar-thumb:hover {
            background: var(--primary-teal);
        }
        
        /* Religion indicator badges */
        .religion-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.7rem;
            font-weight: 600;
            text-transform: uppercase;
        }
        
        .religion-all { background: linear-gradient(135deg, var(--primary-teal), var(--accent-purple)); color: white; }
        
        /* Responsive */
        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
            }
            
            .sidebar.show {
                transform: translateX(0);
            }
            
            .main-content {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-brand">
            <h3>
                <span class="brand-icon"><i class="fas fa-globe-americas"></i></span>
                Global Pilgrim
            </h3>
            <small>Universal Faith Platform</small>
        </div>
        
        <nav class="sidebar-nav">
            <div class="nav-section">
                <div class="nav-section-title">Main</div>
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link ${currentPage == 'dashboard' ? 'active' : ''}">
                    <i class="fas fa-th-large"></i> Dashboard
                </a>
            </div>
            
            <div class="nav-section">
                <div class="nav-section-title">Sacred Places</div>
                <a href="${pageContext.request.contextPath}/admin/temples" class="nav-link ${currentPage == 'temples' ? 'active' : ''}">
                    <i class="fas fa-place-of-worship"></i> Sacred Places
                </a>
                <a href="${pageContext.request.contextPath}/admin/pooja-items" class="nav-link ${currentPage == 'pooja-items' ? 'active' : ''}">
                    <i class="fas fa-hands-praying"></i> Ritual Items
                </a>
                <a href="${pageContext.request.contextPath}/admin/scholars" class="nav-link ${currentPage == 'scholars' ? 'active' : ''}">
                    <i class="fas fa-user-graduate"></i> Scholars & Astrologers
                </a>
            </div>
            
            <div class="nav-section">
                <div class="nav-section-title">Community</div>
                <a href="${pageContext.request.contextPath}/admin/users" class="nav-link ${currentPage == 'users' ? 'active' : ''}">
                    <i class="fas fa-users"></i> Pilgrims
                </a>
                <a href="${pageContext.request.contextPath}/admin/vendors" class="nav-link ${currentPage == 'vendors' ? 'active' : ''}">
                    <i class="fas fa-store"></i> Partners
                </a>
            </div>
            
            <div class="nav-section">
                <div class="nav-section-title">Bookings</div>
                <a href="${pageContext.request.contextPath}/admin/orders" class="nav-link ${currentPage == 'orders' ? 'active' : ''}">
                    <i class="fas fa-receipt"></i> Orders
                </a>
                <a href="${pageContext.request.contextPath}/admin/orders/darshana-bookings" class="nav-link ${currentPage == 'darshana-bookings' ? 'active' : ''}">
                    <i class="fas fa-ticket-alt"></i> Sacred Visits
                </a>
            </div>
            
            <div class="nav-section">
                <div class="nav-section-title">System</div>
                <a href="${pageContext.request.contextPath}/admin/support" class="nav-link ${currentPage == 'support' ? 'active' : ''}">
                    <i class="fas fa-headset"></i> Support
                </a>
                <a href="${pageContext.request.contextPath}/admin/notifications" class="nav-link ${currentPage == 'notifications' ? 'active' : ''}">
                    <i class="fas fa-bell"></i> Notifications
                </a>
                <a href="${pageContext.request.contextPath}/admin/logs" class="nav-link ${currentPage == 'logs' ? 'active' : ''}">
                    <i class="fas fa-clipboard-list"></i> Audit Logs
                </a>
                <a href="${pageContext.request.contextPath}/admin/settings" class="nav-link ${currentPage == 'settings' ? 'active' : ''}">
                    <i class="fas fa-cog"></i> Settings
                </a>
            </div>
        </nav>
    </aside>
    
    <!-- Main Content -->
    <main class="main-content">
        <!-- Top Navbar -->
        <nav class="top-navbar">
            <h2 class="page-title">${pageTitle}</h2>
            
            <div class="user-menu">
                <div class="dropdown">
                    <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle" data-bs-toggle="dropdown">
                        <div class="user-avatar">
                            ${sessionScope.adminName.charAt(0)}
                        </div>
                        <span class="ms-2 text-white">${sessionScope.adminName}</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/profile"><i class="fas fa-user me-2"></i> Profile</a></li>
                        <li><hr class="dropdown-divider" style="border-color: var(--border-color);"></li>
                        <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/admin/logout"><i class="fas fa-sign-out-alt me-2"></i> Logout</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        
        <!-- Content Area -->
        <div class="content-area">
            <!-- Flash Messages -->
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i> ${success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i> ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
