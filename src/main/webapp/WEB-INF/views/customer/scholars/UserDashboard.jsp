<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scholar Dashboard - GlobalPiligrim</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        /* ===== GLOBAL STYLES ===== */
        :root {
            --primary-green: #2d8659;
            --accent-gold: #d4af37;
            --accent-gold-light: #f4e4a6;
            --primary-dark: #1a1a1a;
            --bg-light: #f8f9fa;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: #f3e6d3;
            font-family: 'Inter', sans-serif;
            padding-bottom: 40px;
            margin: 0;
            padding: 0;
        }
        
        /* ===== SIDEBAR STYLES ===== */
        .dashboard-wrapper {
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: 280px;
            background: white;
            padding: 30px 0;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
            overflow-y: auto;
            border-right: 1px solid rgba(0, 0, 0, 0.1);
        }

        .sidebar-header {
            padding: 0 25px 25px;
            border-bottom: 2px solid var(--bg-light);
            margin-bottom: 20px;
        }

        .sidebar-header h3 {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            color: var(--primary-dark);
            font-weight: 700;
            margin: 0;
        }

        .sidebar-menu {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .sidebar-menu li {
            margin: 0;
        }

        .sidebar-menu a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 15px 25px;
            color: #666;
            text-decoration: none;
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
            position: relative;
        }

        .sidebar-menu a:hover {
            background: var(--bg-light);
            color: var(--primary-dark);
            border-left-color: var(--accent-gold);
            transform: translateX(5px);
        }

        .sidebar-menu a.active {
            background: linear-gradient(135deg, rgba(212, 175, 55, 0.1), rgba(212, 175, 55, 0.05));
            color: var(--primary-dark);
            border-left-color: var(--accent-gold);
            font-weight: 600;
        }

        .sidebar-menu a.active::before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            transform: translateY(-50%);
            width: 4px;
            height: 60%;
            background: var(--accent-gold);
            border-radius: 0 4px 4px 0;
        }

        .sidebar-menu a i {
            width: 24px;
            font-size: 18px;
        }

        .sidebar-menu a.logout {
            color: #e74c3c;
            border-top: 1px solid var(--bg-light);
            margin-top: 10px;
        }

        .sidebar-menu a.logout:hover {
            background: rgba(231, 76, 60, 0.1);
            border-left-color: #e74c3c;
        }

        .main-content {
            flex: 1;
            margin-left: 280px;
            width: calc(100% - 280px);
            padding: 0;
        }

        /* ===== WELCOME BANNER ===== */
        .welcome-banner {
            background: linear-gradient(135deg, rgba(20, 20, 20, 0.95) 0%, rgba(34, 34, 34, 0.95) 100%);
            padding: 25px 0;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .welcome-banner .content {
            max-width: 100%;
            margin: 0 auto;
            padding: 0 30px;
        }

        .welcome-banner h2 {
            color: white;
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .welcome-banner p {
            color: rgba(255, 255, 255, 0.9);
            font-size: 0.95rem;
            margin-bottom: 0;
        }

        .btn-gold {
            background: linear-gradient(135deg, var(--accent-gold), var(--accent-gold-light));
            color: var(--primary-dark);
            border: none;
            padding: 14px 30px;
            border-radius: 12px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(212, 175, 55, 0.3);
        }

        .btn-gold:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(212, 175, 55, 0.4);
            color: var(--primary-dark);
        }

        /* ===== STATS GRID (Inside Bookings) ===== */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            border-radius: 16px;
            padding: 20px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            text-align: center;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin: 0 auto 15px;
        }

        .stat-icon.gold {
            background: linear-gradient(135deg, var(--accent-gold), var(--accent-gold-light));
            color: var(--primary-dark);
        }

        .stat-icon.teal {
            background: linear-gradient(135deg, #1abc9c, #16a085);
            color: white;
        }

        .stat-icon.orange {
            background: linear-gradient(135deg, #f39c12, #e67e22);
            color: white;
        }

        .stat-icon.blue {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
        }

        .stat-content h3 {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-dark);
            margin-bottom: 5px;
        }

        .stat-content p {
            color: #666;
            font-size: 0.9rem;
            margin: 0;
        }

        /* ===== DASHBOARD CARDS ===== */
        .dashboard-card {
            background: white;
            border-radius: 22px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            margin-bottom: 30px;
        }
        
        .card-header-custom {
            background: linear-gradient(135deg, var(--accent-gold) 0%, var(--accent-gold-light) 100%);
            padding: 20px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-header-custom .card-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            color: var(--primary-dark);
            font-weight: 700;
            margin: 0;
        }

        .card-body-custom {
            padding: 30px;
        }

        .btn-outline-gold {
            border: 2px solid var(--accent-gold);
            color: var(--accent-gold);
            background: transparent;
            font-weight: 600;
            padding: 8px 20px;
            border-radius: 10px;
            text-decoration: none;
            transition: all 0.3s ease;
            font-size: 14px;
        }

        .btn-outline-gold:hover {
            background: linear-gradient(135deg, var(--accent-gold), var(--accent-gold-light));
            color: var(--primary-dark);
            border-color: var(--accent-gold);
        }

        /* ===== SERVICE CARD STYLES (Like Image) ===== */
        .service-cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 280px));
            gap: 20px;
            padding: 20px 0;
            justify-content: start;
        }

        .service-card {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            width: 280px;
            max-width: 100%;
        }
        
        .service-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        .service-card-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 48px;
            font-weight: bold;
        }

        .service-card-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .service-card-body {
            padding: 20px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .service-card-title {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--primary-dark);
            margin-bottom: 10px;
            line-height: 1.3;
        }

        .service-card-price {
            color: #ff6b35;
            font-size: 1rem;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .service-card-button {
            background: #ff6b35;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            text-align: center;
            display: block;
            transition: all 0.3s ease;
            margin-top: auto;
        }

        .service-card-button:hover {
            background: #e55a2b;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 107, 53, 0.3);
        }

        /* ===== ORDER SUMMARY TABLE STYLES ===== */
        .orders-section {
            background: white;
            border-radius: 22px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            margin-bottom: 30px;
        }

        .orders-header {
            background: linear-gradient(135deg, var(--accent-gold) 0%, var(--accent-gold-light) 100%);
            padding: 20px 30px;
        }
        
        .orders-header h3 {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            color: var(--primary-dark);
            font-weight: 700;
            margin: 0;
        }
        
        .orders-table-container {
            padding: 30px;
            overflow-x: auto;
        }

        .orders-table {
            width: 100%;
            border-collapse: collapse;
            margin: 0;
        }

        .orders-table thead {
            background: #ff6b35;
        }

        .orders-table thead th {
            color: white;
            padding: 15px 12px;
            text-align: left;
            font-weight: 600;
            font-size: 0.9rem;
            white-space: nowrap;
        }

        .orders-table tbody td {
            padding: 15px 12px;
            border-bottom: 1px solid #e0e0e0;
            color: #333;
            font-size: 0.9rem;
        }

        .orders-table tbody tr:hover {
            background: #f8f9fa;
        }

        .orders-table tbody tr:last-child td {
            border-bottom: none;
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            display: inline-block;
        }

        .status-confirmed {
            background: #d4edda;
            color: #155724;
        }

        .status-pending {
            background: #fff3cd;
            color: #856404;
        }

        .status-completed {
            background: #d1ecf1;
            color: #0c5460;
        }

        .status-rejected {
            background: #f8d7da;
            color: #721c24;
        }

        .action-btn {
            background: #ff6b35;
            color: white;
            border: none;
            padding: 6px 15px;
            border-radius: 6px;
            font-size: 0.85rem;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
        }

        .action-btn:hover {
            background: #e55a2b;
            color: white;
            transform: translateY(-1px);
        }

        .empty-orders {
            text-align: center;
            padding: 60px 20px;
        }

        .empty-orders-emoji {
            font-size: 4rem;
            margin-bottom: 15px;
            opacity: 0.5;
        }
        
        .empty-orders-text {
            color: #666;
            font-size: 1.1rem;
            font-weight: 500;
        }

        /* ===== QUICK ACTIONS ===== */
        .quick-action-btn {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 12px;
            padding: 25px 15px;
            background: var(--bg-light);
            border-radius: 16px;
            text-decoration: none;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .quick-action-btn:hover {
            background: white;
            border-color: var(--accent-gold);
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(212, 175, 55, 0.15);
        }
        
        .quick-action-btn .action-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--accent-gold), var(--accent-gold-light));
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: var(--primary-dark);
            transition: all 0.3s ease;
        }

        .quick-action-btn:hover .action-icon {
            transform: scale(1.1);
        }

        .quick-action-btn span {
            font-weight: 600;
            color: var(--primary-dark);
            font-size: 14px;
        }

        /* ===== LIST ITEMS ===== */
        .list-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            background: var(--bg-light);
            border-radius: 12px;
            margin-bottom: 15px;
            border-left: 4px solid var(--accent-gold);
            transition: all 0.3s ease;
        }
        
        .list-item:hover {
            background: white;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        }

        .list-item-content h4 {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--primary-dark);
            margin-bottom: 8px;
        }

        .list-item-content p {
            color: #666;
            font-size: 0.9rem;
            margin: 0;
        }

        .list-item-meta {
            text-align: right;
        }

        .badge-status {
            padding: 6px 14px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.85rem;
            display: inline-block;
        }

        .badge-pending {
            background: linear-gradient(135deg, #f39c12, #e67e22);
            color: white;
        }

        .badge-confirmed {
            background: linear-gradient(135deg, #2ecc71, #27ae60);
            color: white;
        }

        .badge-cancelled {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
        }

        .badge-completed {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
        }
        
        /* ===== SCHOLAR CARDS ===== */
        .scholar-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            height: 100%;
            border: 2px solid transparent;
        }
        
        .scholar-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            border-color: var(--accent-gold);
        }
        
        .scholar-image-container {
            height: 200px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .scholar-image {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            border: 4px solid white;
            object-fit: cover;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }
        
        .scholar-initial {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
            font-weight: bold;
            color: #667eea;
            border: 4px solid white;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }
        
        .scholar-card-body {
            padding: 20px;
        }
        
        .scholar-name {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--primary-dark);
            margin-bottom: 12px;
            text-align: center;
            font-family: 'Playfair Display', serif;
        }
        
        .scholar-info {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 8px;
        }
        
        .scholar-info strong {
            color: var(--primary-dark);
            font-weight: 600;
        }

        .scholar-info i {
            color: var(--accent-gold);
            width: 20px;
        }
        
        .rating-badge {
            background: linear-gradient(135deg, rgba(212, 175, 55, 0.1), rgba(212, 175, 55, 0.2));
            color: #5a4a1f;
            padding: 4px 10px;
            border-radius: 15px;
            display: inline-block;
            font-weight: 600;
            font-size: 0.85rem;
        }

        .price-highlight {
            color: var(--accent-gold);
            font-weight: 700;
            font-size: 1.1rem;
        }

        .btn-book {
            background: linear-gradient(135deg, var(--accent-gold), var(--accent-gold-light));
            color: var(--primary-dark);
            border: none;
            padding: 12px 25px;
            border-radius: 10px;
            font-weight: 600;
            width: 100%;
            text-decoration: none;
            display: block;
            text-align: center;
            transition: all 0.3s ease;
            margin-top: 15px;
        }

        .btn-book:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
            color: var(--primary-dark);
        }
        
        /* ===== BOOKING CARDS (Same as Service Cards) ===== */
        .booking-cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 280px));
            gap: 20px;
            padding: 20px 0;
            justify-content: start;
        }

        .booking-card {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            width: 280px;
            max-width: 100%;
        }
        
        .booking-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        .booking-card-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 48px;
            font-weight: bold;
        }

        .booking-card-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .booking-card-body {
            padding: 20px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .booking-card-title {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--primary-dark);
            margin-bottom: 10px;
            line-height: 1.3;
        }

        .booking-card-info {
            color: #666;
            font-size: 0.85rem;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .booking-card-info i {
            color: var(--accent-gold);
            width: 16px;
        }

        .booking-card-price {
            color: #ff6b35;
            font-size: 1rem;
            font-weight: 600;
            margin: 10px 0;
        }

        .booking-card-status {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 600;
            margin-bottom: 10px;
            text-transform: uppercase;
        }

        .status-confirmed {
            background: #d4edda;
            color: #155724;
        }

        .status-pending {
            background: #fff3cd;
            color: #856404;
        }

        .status-completed {
            background: #d1ecf1;
            color: #0c5460;
        }

        .status-rejected {
            background: #f8d7da;
            color: #721c24;
        }

        .booking-card-button {
            background: #ff6b35;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            text-align: center;
            display: block;
            transition: all 0.3s ease;
            margin-top: auto;
        }

        .booking-card-button:hover {
            background: #e55a2b;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 107, 53, 0.3);
        }

        .booking-card-button.pay-button {
            background: #28a745;
        }

        .booking-card-button.pay-button:hover {
            background: #218838;
            box-shadow: 0 4px 12px rgba(40, 167, 69, 0.3);
        }

        /* ===== EMPTY STATE ===== */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }

        .empty-state-icon {
            font-size: 4rem;
            color: var(--accent-gold);
            margin-bottom: 1rem;
        }

        .empty-state h4 {
            color: var(--primary-dark);
            margin-bottom: 1rem;
            font-weight: 600;
        }

        .empty-state p {
            color: #666;
            font-size: 1rem;
            margin-bottom: 2rem;
        }
        
        /* ===== CONTAINER ===== */
        .container-custom {
            max-width: 100%;
            margin: 0;
            padding: 20px 30px;
        }
        
        /* ===== RESPONSIVE ===== */
        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
                transition: transform 0.3s ease;
        }
        
            .sidebar.open {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
                width: 100%;
            }

            .container-custom {
            padding: 15px 20px;
        }
        }

        @media (max-width: 768px) {
            .welcome-banner {
                padding: 20px 0;
            }

            .welcome-banner h2 {
                font-size: 1.5rem;
            }

            .welcome-banner p {
                font-size: 0.9rem;
            }

            .welcome-banner .content {
                padding: 0 20px;
            }

            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .sidebar {
                width: 260px;
            }

            .service-cards-grid,
            .booking-cards-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 250px));
                gap: 15px;
                justify-content: center;
            }

            .service-card,
            .booking-card {
                width: 250px;
            }

            .service-card-image {
                height: 150px;
        }
        
            .service-card-title {
                font-size: 1rem;
            }

            .service-card-price {
                font-size: 0.9rem;
            }
        }

        @media (max-width: 576px) {
            .service-cards-grid {
                grid-template-columns: 1fr;
                justify-content: center;
            }

            .service-card {
                width: 100%;
                max-width: 300px;
                margin: 0 auto;
        }
        }
        /* Mobile Menu Toggle Button */
        .menu-toggle {
            display: none;
            position: fixed;
            top: 15px;
            left: 15px;
            z-index: 1001;
            background: white;
            border: none;
            padding: 10px 15px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            cursor: pointer;
            font-size: 20px;
            color: var(--primary-dark);
        }
        
        /* Mobile Overlay */
        .sidebar-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }

        @media (max-width: 992px) {
            .menu-toggle {
                display: block;
            }

            .sidebar-overlay {
                display: block;
                opacity: 0;
                visibility: hidden;
                transition: opacity 0.3s ease, visibility 0.3s ease;
            }
            
            .sidebar.open ~ .sidebar-overlay,
            .sidebar.open + .main-content::before {
                opacity: 1;
                visibility: visible;
            }
        }
    </style>
</head>
<body>
    <!-- Mobile Menu Toggle -->
    <button class="menu-toggle" id="menuToggle" onclick="toggleSidebar()">
        <i class="fas fa-bars"></i>
    </button>

    <!-- Mobile Overlay -->
    <div class="sidebar-overlay" id="sidebarOverlay" onclick="toggleSidebar()"></div>

    <div class="container-custom">
        <div class="dashboard-wrapper">
            <!-- Sidebar -->
            <aside class="sidebar">
                <div class="sidebar-header">
                    <h3><i class="fas fa-user-circle me-2"></i>Menu</h3>
        </div>
                <ul class="sidebar-menu">
                    <li>
                        <a href="${pageContext.request.contextPath}/customer/scholar/dashboard" class="active">
                            <i class="fas fa-home"></i>
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/book-scholar">
                            <i class="fas fa-user-graduate"></i>
                            <span>Browse Scholar</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/customer/scholar/search">
                            <i class="fas fa-search"></i>
                            <span>Search & Filter</span>
                        </a>
                    </li>
                    <li>
                        <a href="#order-summary">
                            <i class="fas fa-list-alt"></i>
                            <span>Order Summary</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/customer/scholar/payment/history">
                            <i class="fas fa-credit-card"></i>
                            <span>Payments</span>
                        </a>
                    </li>
                    <li>
                        <a href="#bookings">
                            <i class="fas fa-calendar-check"></i>
                            <span>My Bookings</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/customer/logout" class="logout">
                            <i class="fas fa-sign-out-alt"></i>
                            <span>Logout</span>
                        </a>
                    </li>
                </ul>
            </aside>

            <!-- Main Content -->
            <div class="main-content">
                <!-- Welcome Banner -->
                <div class="welcome-banner">
                    <div class="content">
                        <div class="row align-items-center">
                            <div class="col-lg-12">
                                <h2>Welcome back, ${not empty user ? user.name : 'Guest'}! 👋</h2>
                                <p>Discover experienced spiritual scholars and book your religious ceremonies. Your path to divine blessings starts here.</p>
                            </div>
                        </div>
                    </div>
                </div>
        <!-- Available Scholars Section -->
                <div class="dashboard-card mb-4">
                    <div class="card-header-custom">
                        <h3 class="card-title">
                            <i class="fas fa-user-graduate"></i> Available Scholars
                        </h3>
                        <a href="${pageContext.request.contextPath}/book-scholar" class="btn-outline-gold btn-sm">
                            View All <i class="fas fa-arrow-right"></i>
                        </a>
            </div>
                    <div class="card-body-custom">
                <c:choose>
                            <c:when test="${not empty scholars}">
                                <div class="service-cards-grid">
                                    <c:forEach var="scholar" items="${scholars}" end="3">
                                        <c:if test="${scholar.type != 'ASTROLOGER'}">
                                            <div class="service-card">
                                                <div class="service-card-image">
                                        <c:choose>
                                            <c:when test="${not empty scholar.profilePhotoPath}">
                                                <img src="${pageContext.request.contextPath}/uploads/${scholar.profilePhotoPath}" 
                                                                 alt="${scholar.user.name}"
                                                                 onerror="this.onerror=null; this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                                            <div style="display: none; width: 100%; height: 100%; align-items: center; justify-content: center; color: white; font-size: 48px; font-weight: bold;">
                                                                ${fn:substring(scholar.user.name, 0, 1)}
                                                            </div>
                                            </c:when>
                                            <c:otherwise>
                                                            ${fn:substring(scholar.user.name, 0, 1)}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="service-card-body">
                                                    <h3 class="service-card-title">${scholar.user.name}</h3>
                                                    <div class="service-card-price">
                                                        ₹<fmt:formatNumber value="${scholar.basePrice != null ? scholar.basePrice : 0}" pattern="#,##0"/>
                                                        <c:if test="${scholar.basePrice != null && scholar.basePrice > 0}">
                                                            <c:set var="maxPrice" value="${scholar.basePrice * 2}"/>
                                                            - ₹<fmt:formatNumber value="${maxPrice}" pattern="#,##0"/>
                                                        </c:if>
                                                    </div>
                                                    <a href="${pageContext.request.contextPath}/customer/scholar/book?scholarId=${scholar.id}" 
                                                       class="service-card-button">
                                                        Book Now
                                                    </a>
                                                </div>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state" style="padding: 40px 20px; text-align: center;">
                                    <div class="empty-state-icon">
                                        <i class="fas fa-user-slash"></i>
                                    </div>
                                    <h4>No Scholars Available</h4>
                                    <p>We're updating our scholar directory. Please check back later.</p>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                            </div>
                                            </div>
                                            
                <!-- Available Astrologers Section -->
                <div class="dashboard-card mb-4">
                    <div class="card-header-custom">
                        <h3 class="card-title">
                            <i class="fas fa-star-and-crescent"></i> Available Astrologers
                        </h3>
                        <a href="${pageContext.request.contextPath}/customer/scholar/search?type=ASTROLOGER" class="btn-outline-gold btn-sm">
                            View All <i class="fas fa-arrow-right"></i>
                        </a>
                                            </div>
                    <div class="card-body-custom">
                        <c:choose>
                            <c:when test="${not empty scholars}">
                                <c:set var="astrologerCount" value="0"/>
                                <div class="service-cards-grid">
                                    <c:forEach var="scholar" items="${scholars}">
                                        <c:if test="${scholar.type == 'ASTROLOGER' && astrologerCount < 4}">
                                            <c:set var="astrologerCount" value="${astrologerCount + 1}"/>
                                            <div class="service-card">
                                                <div class="service-card-image">
                                                    <c:choose>
                                                        <c:when test="${not empty scholar.profilePhotoPath}">
                                                            <img src="${pageContext.request.contextPath}/uploads/${scholar.profilePhotoPath}" 
                                                                 alt="${scholar.user.name}"
                                                                 onerror="this.onerror=null; this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                                            <div style="display: none; width: 100%; height: 100%; align-items: center; justify-content: center; color: white; font-size: 48px; font-weight: bold;">
                                                                ${fn:substring(scholar.user.name, 0, 1)}
                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${fn:substring(scholar.user.name, 0, 1)}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="service-card-body">
                                                    <h3 class="service-card-title">${scholar.user.name}</h3>
                                                    <div class="service-card-price">
                                                        ₹<fmt:formatNumber value="${scholar.basePrice != null ? scholar.basePrice : 0}" pattern="#,##0"/>
                                                        <c:if test="${scholar.basePrice != null && scholar.basePrice > 0}">
                                                            <c:set var="maxPrice" value="${scholar.basePrice * 2}"/>
                                                            - ₹<fmt:formatNumber value="${maxPrice}" pattern="#,##0"/>
                                            </c:if>
                                                    </div>
                                                <a href="${pageContext.request.contextPath}/customer/scholar/book?scholarId=${scholar.id}" 
                                                       class="service-card-button">
                                                        Book Now
                                                </a>
                                            </div>
                                        </div>
                                        </c:if>
                                    </c:forEach>
                                    </div>
                                <c:if test="${astrologerCount == 0}">
                                    <div class="empty-state" style="padding: 40px 20px; text-align: center;">
                                        <p style="color: #999; font-size: 0.9rem;">No astrologers available at the moment</p>
                                </div>
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state" style="padding: 40px 20px; text-align: center;">
                                    <p style="color: #999; font-size: 0.9rem;">No astrologers available at the moment</p>
                        </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Order Summary Section -->
                <div class="orders-section" id="order-summary">
                    <div class="orders-header">
                        <h3><i class="fas fa-list-alt me-2"></i>Orders</h3>
                    </div>
                    <div class="orders-table-container">
                        <c:choose>
                            <c:when test="${not empty bookings && bookings.size() > 0}">
                                <table class="orders-table">
                                    <thead>
                                        <tr>
                                            <th>Order Code</th>
                                            <th>Pooja Name</th>
                                            <th>Pooja Date</th>
                                            <th>Pooja Type</th>
                                            <th>Pooja Location</th>
                                            <th>Total Amount</th>
                                            <th>Paid Amount</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="booking" items="${bookings}">
                                            <tr>
                                                <td>#${booking.id}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty booking.serviceDescription}">
                                                            ${fn:substring(booking.serviceDescription, 0, 30)}${fn:length(booking.serviceDescription) > 30 ? '...' : ''}
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${booking.scholar.user.name}'s Service
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty booking.serviceDate}">
                                                            ${fn:substring(booking.serviceDate.toString().replace('T', ' '), 0, 10)}
                                                        </c:when>
                                                        <c:otherwise>N/A</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>${booking.serviceType}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty booking.serviceLocation}">
                                                            ${fn:substring(booking.serviceLocation, 0, 20)}${fn:length(booking.serviceLocation) > 20 ? '...' : ''}
                                                        </c:when>
                                                        <c:otherwise>N/A</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>₹<fmt:formatNumber value="${booking.totalAmount != null ? booking.totalAmount : 0}" pattern="#,##0.00"/></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${booking.status == 'CONFIRMED' || booking.status == 'COMPLETED'}">
                                                            ₹<fmt:formatNumber value="${booking.totalAmount != null ? booking.totalAmount : 0}" pattern="#,##0.00"/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            ₹0.00
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${booking.status == 'CONFIRMED'}">
                                                            <span class="status-badge status-confirmed">CONFIRMED</span>
                                                        </c:when>
                                                        <c:when test="${booking.status == 'PENDING_CONFIRMATION'}">
                                                            <span class="status-badge status-pending">PENDING</span>
                                                        </c:when>
                                                        <c:when test="${booking.status == 'COMPLETED'}">
                                                            <span class="status-badge status-completed">COMPLETED</span>
                                                        </c:when>
                                                        <c:when test="${booking.status == 'REJECTED'}">
                                                            <span class="status-badge status-rejected">REJECTED</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="status-badge status-pending">${booking.status}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/customer/scholar/booking/view?bookingId=${booking.id}" 
                                                       class="action-btn">
                                                        View
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-orders">
                                    <div class="empty-orders-emoji">😞</div>
                                    <div class="empty-orders-text">Nothing Found</div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
                <!-- My Bookings Section with Stats -->
                <div class="dashboard-card" id="bookings">
                    <div class="card-header-custom">
                        <h3 class="card-title">
                            <i class="fas fa-calendar-alt"></i> My Bookings
                        </h3>
            </div>
                    <div class="card-body-custom">
                        <!-- Booking Statistics -->
                        <c:set var="totalBookings" value="${not empty bookings ? bookings.size() : 0}"/>
                        <c:set var="confirmedBookings" value="0"/>
                        <c:set var="pendingBookings" value="0"/>
                        <c:set var="completedBookings" value="0"/>
                        <c:forEach var="booking" items="${bookings}">
                            <c:if test="${booking.status == 'CONFIRMED'}">
                                <c:set var="confirmedBookings" value="${confirmedBookings + 1}"/>
                            </c:if>
                            <c:if test="${booking.status == 'PENDING_CONFIRMATION'}">
                                <c:set var="pendingBookings" value="${pendingBookings + 1}"/>
                            </c:if>
                            <c:if test="${booking.status == 'COMPLETED'}">
                                <c:set var="completedBookings" value="${completedBookings + 1}"/>
                            </c:if>
                        </c:forEach>

                        <div class="stats-grid">
                            <div class="stat-card">
                                <div class="stat-icon gold">
                                    <i class="fas fa-calendar-check"></i>
                                </div>
                                <div class="stat-content">
                                    <h3>${totalBookings}</h3>
                                    <p>Total Bookings</p>
                                </div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-icon teal">
                                    <i class="fas fa-check-circle"></i>
                                </div>
                                <div class="stat-content">
                                    <h3>${confirmedBookings}</h3>
                                    <p>Confirmed</p>
                                </div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-icon orange">
                                    <i class="fas fa-clock"></i>
                                </div>
                                <div class="stat-content">
                                    <h3>${pendingBookings}</h3>
                                    <p>Pending</p>
                                </div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-icon blue">
                                    <i class="fas fa-check-double"></i>
                                </div>
                                <div class="stat-content">
                                    <h3>${completedBookings}</h3>
                                    <p>Completed</p>
                                </div>
                            </div>
                        </div>

                        <!-- Bookings List -->
                <c:choose>
                    <c:when test="${empty bookings || bookings.size() == 0}">
                        <div class="empty-state">
                                    <div class="empty-state-icon">
                            <i class="fas fa-calendar-times"></i>
                                    </div>
                                    <h4>No Bookings Yet</h4>
                                    <p>You haven't made any bookings yet. Start by exploring our available scholars!</p>
                                    <a href="${pageContext.request.contextPath}/book-scholar" class="btn-gold">
                                        <i class="fas fa-search me-2"></i>Browse Scholars
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="booking-cards-grid">
                            <c:forEach var="booking" items="${bookings}">
                                <div class="booking-card">
                                    <div class="booking-card-image">
                                        <c:choose>
                                            <c:when test="${not empty booking.scholar.profilePhotoPath}">
                                                <img src="${pageContext.request.contextPath}/uploads/${booking.scholar.profilePhotoPath}" 
                                                     alt="${booking.scholar.user.name}"
                                                     onerror="this.onerror=null; this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                                <div style="display: none; width: 100%; height: 100%; align-items: center; justify-content: center; color: white; font-size: 48px; font-weight: bold;">
                                                    ${fn:substring(booking.scholar.user.name, 0, 1)}
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                ${fn:substring(booking.scholar.user.name, 0, 1)}
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="booking-card-body">
                                        <h3 class="booking-card-title">${booking.scholar.user.name}</h3>
                                        
                                        <div class="booking-card-info">
                                            <i class="fas fa-calendar"></i>
                                            <span>${booking.serviceDate != null ? booking.serviceDate.toString().replace('T', ' ').substring(0, 16) : 'N/A'}</span>
                                        </div>
                                        
                                        <div class="booking-card-info">
                                            <i class="fas fa-tag"></i>
                                            <span>${booking.serviceType}</span>
                                        </div>
                                        
                                        <c:choose>
                                            <c:when test="${booking.status == 'CONFIRMED'}">
                                                <span class="booking-card-status status-confirmed">CONFIRMED</span>
                                            </c:when>
                                            <c:when test="${booking.status == 'PENDING_CONFIRMATION'}">
                                                <span class="booking-card-status status-pending">PENDING</span>
                                            </c:when>
                                            <c:when test="${booking.status == 'REJECTED'}">
                                                <span class="booking-card-status status-rejected">REJECTED</span>
                                            </c:when>
                                            <c:when test="${booking.status == 'COMPLETED'}">
                                                <span class="booking-card-status status-completed">COMPLETED</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="booking-card-status status-pending">${booking.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                        
                                        <div class="booking-card-price">
                                            ₹<fmt:formatNumber value="${booking.totalAmount != null ? booking.totalAmount : 0}" pattern="#,##0"/>
                                        </div>
                                        
                                        <c:choose>
                                            <c:when test="${booking.status == 'PENDING_CONFIRMATION'}">
                                                <a href="${pageContext.request.contextPath}/customer/scholar/payment/initiate?bookingId=${booking.id}" 
                                                   class="booking-card-button pay-button">
                                                    <i class="fas fa-credit-card"></i> Pay Now
                                                </a>
                                            </c:when>
                                            <c:when test="${booking.status == 'CONFIRMED'}">
                                                <a href="${pageContext.request.contextPath}/customer/scholar/chat?scholarId=${booking.scholar.id}&bookingId=${booking.id}" 
                                                   class="booking-card-button" style="background: #28a745;">
                                                    <i class="fas fa-comments"></i> Chat
                                                </a>
                                                <c:if test="${booking.serviceType == 'VIDEO_CALL' && not empty booking.videoCallLink}">
                                                    <a href="${pageContext.request.contextPath}/customer/scholar/video-call?bookingId=${booking.id}" 
                                                       class="booking-card-button" style="margin-top: 8px; background: #17a2b8;">
                                                        <i class="fas fa-video"></i> Video Call
                                                    </a>
                                                </c:if>
                                            </c:when>
                                            <c:when test="${booking.status == 'COMPLETED'}">
                                                <a href="${pageContext.request.contextPath}/customer/scholar/review/submit?bookingId=${booking.id}" 
                                                   class="booking-card-button" style="background: #ffc107; color: #000;">
                                                    <i class="fas fa-star"></i> Submit Review
                                                </a>
                                            </c:when>
                                            <c:when test="${booking.status == 'REJECTED'}">
                                                <!-- No action buttons for rejected bookings -->
                                            </c:when>
                                            <c:otherwise>
                                                <!-- No action buttons for other statuses -->
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Smooth scroll for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });

        // Mobile sidebar toggle
        function toggleSidebar() {
            const sidebar = document.querySelector('.sidebar');
            const overlay = document.getElementById('sidebarOverlay');
            sidebar.classList.toggle('open');
            if (sidebar.classList.contains('open')) {
                overlay.style.opacity = '1';
                overlay.style.visibility = 'visible';
            } else {
                overlay.style.opacity = '0';
                overlay.style.visibility = 'hidden';
            }
        }

        // Close sidebar when clicking outside on mobile
        document.addEventListener('click', function(event) {
            const sidebar = document.querySelector('.sidebar');
            const menuToggle = document.getElementById('menuToggle');
            const overlay = document.getElementById('sidebarOverlay');
            
            if (window.innerWidth <= 992) {
                if (!sidebar.contains(event.target) && !menuToggle.contains(event.target) && event.target === overlay) {
                    sidebar.classList.remove('open');
                    overlay.style.opacity = '0';
                    overlay.style.visibility = 'hidden';
                }
            }
        });
    </script>
</body>
</html>
