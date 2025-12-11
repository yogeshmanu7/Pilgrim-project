<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pilgrim Project | Sacred Places of All Faiths</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    
    <!-- Custom CSS -->
    <style>
        /* ===== GLOBAL ===== */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Inter', sans-serif;
            background: #f3e6d3;
            color: #222;
        }
        
        /* ===== HEADER ===== */
header {
    position: sticky;
    top: 0;
    z-index: 1000;
    background: rgba(20, 20, 20, 0.98);
    backdrop-filter: blur(10px);
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}

.header-wrap {
    max-width: 1300px;
    margin: auto;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 18px 30px;
}

.logo {
    display: flex;
    align-items: center;
    gap: 12px;
    color: #fff;
    text-decoration: none;
}

.logo i {
    font-size: 28px;
    color: #d4af37;
}

.logo h1 {
    font-family: 'Playfair Display', serif;
    font-size: 28px;
    font-weight: 700;
}

.logo span {
    color: #d4af37;
}

nav {
    display: flex;
    align-items: center;
}

nav a {
    color: #ddd;
    margin-left: 32px;
    text-decoration: none;
    font-weight: 500;
    font-size: 16px;
    position: relative;
    transition: color 0.3s ease;
}

nav a:after {
    content: "";
    position: absolute;
    width: 0;
    height: 2px;
    background: #d4af37;
    left: 0;
    bottom: -6px;
    transition: width 0.3s ease;
}

nav a:hover {
    color: #fff;
}

nav a:hover:after {
    width: 100%;
}

nav a.active {
    color: #d4af37;
}

nav a.active:after {
    width: 100%;
    background: #d4af37;
}

/* ===== JOIN US BUTTON ===== */
.join-us-btn {
    background: linear-gradient(135deg, #d4af37, #c19b2e);
    color: #000;
    padding: 10px 25px;
    border-radius: 30px;
    text-decoration: none;
    font-weight: 600;
    font-size: 16px;
    margin-left: 32px;
    transition: all 0.3s ease;
    border: 2px solid #d4af37;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    box-shadow: 0 4px 15px rgba(212, 175, 55, 0.3);
}

.join-us-btn:hover {
    background: transparent;
    color: #d4af37;
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(212, 175, 55, 0.4);
}

.join-us-btn i {
    font-size: 0.9rem;
}

/* ===== SERVICES DROPDOWN ===== */
.nav-services {
    position: relative;
}

.nav-services > a {
    position: relative;
    display: flex;
    align-items: center;
    gap: 8px;
}

.nav-services > a .dropdown-icon {
    font-size: 0.8rem;
    transition: transform 0.3s ease;
}

.nav-services:hover > a .dropdown-icon,
.nav-services.active > a .dropdown-icon {
    transform: rotate(180deg);
}

.services-dropdown {
    position: absolute;
    top: 100%;
    left: 50%;
    transform: translateX(-50%) translateY(10px);
    background: rgba(20, 20, 20, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 15px;
    padding: 20px;
    min-width: 300px;
    box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3);
    opacity: 0;
    visibility: hidden;
    transition: all 0.3s ease;
    z-index: 1001;
    border: 1px solid rgba(212, 175, 55, 0.2);
}

.nav-services:hover .services-dropdown,
.nav-services.active .services-dropdown {
    opacity: 1;
    visibility: visible;
    transform: translateX(-50%) translateY(0);
}

.dropdown-header {
    color: #d4af37;
    font-weight: 600;
    margin-bottom: 15px;
    padding-bottom: 10px;
    border-bottom: 1px solid rgba(212, 175, 55, 0.3);
    font-family: 'Playfair Display', serif;
    font-size: 1.1rem;
    display: flex;
    align-items: center;
    gap: 10px;
}

.dropdown-header i {
    font-size: 1rem;
}

.dropdown-services {
    display: grid;
    grid-template-columns: 1fr;
    gap: 8px;
}

.dropdown-service-item {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 12px 15px;
    border-radius: 10px;
    text-decoration: none;
    color: #ddd;
    transition: all 0.3s ease;
    cursor: pointer;
}

.dropdown-service-item:hover {
    background: rgba(212, 175, 55, 0.1);
    color: #fff;
    transform: translateX(5px);
}

.dropdown-service-item i {
    color: #d4af37;
    font-size: 1rem;
    width: 24px;
}

.dropdown-service-item span {
    font-size: 0.95rem;
    font-weight: 500;
}

/* Mobile dropdown */
@media (max-width: 768px) {
    .nav-services {
        position: static;
    }
    
    .services-dropdown {
        position: fixed;
        top: 70px;
        left: 20px;
        right: 20px;
        transform: translateX(0) translateY(-20px);
        max-width: 100%;
        min-width: auto;
        background: rgba(20, 20, 20, 0.98);
    }
    
    .nav-services.active .services-dropdown {
        transform: translateX(0) translateY(0);
    }
    
    .dropdown-services {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (max-width: 480px) {
    .dropdown-services {
        grid-template-columns: 1fr;
    }
}

/* Touch device support */
.touch-device .services-dropdown {
    display: none;
}

.touch-device .nav-services.active .services-dropdown {
    display: block;
}

/* ===== SERVICES HERO ===== */
.services-hero {
    background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)),
                url('<%=request.getContextPath()%>/views/images/chri2.jpg') center center / cover no-repeat;
    height: 100vh;
    min-height: 100vh;
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: center;
    color: white;
    margin-bottom: 80px;
    position: relative;
}

.services-hero-content {
    max-width: 800px;
    padding: 0 20px;
    position: relative;
    z-index: 2;
}

.services-hero h1 {
    font-family: 'Playfair Display', serif;
    font-size: 3.5rem;
    margin-bottom: 20px;
    font-weight: 800;
    text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.5);
}

.services-hero p {
    font-size: 1.2rem;
    opacity: 0.95;
    max-width: 700px;
    margin: 0 auto;
    text-shadow: 1px 1px 5px rgba(0, 0, 0, 0.5);
}

/* ===== SERVICES INTRO ===== */
.services-intro {
    padding: 60px 0;
    text-align: center;
    background: #fff;
    border-radius: 40px;
    margin-bottom: 60px;
    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.08);
}

.services-intro h2 {
    font-family: 'Playfair Display', serif;
    font-size: 2.8rem;
    color: #2c3e50;
    margin-bottom: 20px;
}

.services-intro h2 span {
    color: #d4af37;
}

.services-intro p {
    font-size: 1.1rem;
    color: #555;
    max-width: 800px;
    margin: 0 auto 40px;
    line-height: 1.8;
}

/* ===== BACKGROUND IMAGE FOR SERVICES SECTION ===== */
.services-section-with-bg {
    position: relative;
    padding: 60px 20px;
    border-radius: 20px;
    margin: 40px auto;
    overflow: hidden;
}

.services-section-with-bg::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-image: url('<%=request.getContextPath()%>/views/images/chri2.jpg');
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    background-attachment: fixed;
    z-index: -2;
    filter: brightness(0.6) contrast(1.2);
}

.services-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(135deg, 
        rgba(255, 255, 255, 0.95) 0%, 
        rgba(255, 255, 255, 0.92) 50%,
        rgba(249, 247, 242, 0.97) 100%);
    z-index: -1;
    border-radius: 20px;
}

/* ===== COMPACT SERVICES STYLING ===== */
.section-title {
    text-align: center;
    font-family: 'Playfair Display', serif;
    font-size: 2.8rem;
    color: #2c3e50;
    margin-bottom: 15px;
    position: relative;
    z-index: 1;
}

.section-subtitle {
    text-align: center;
    color: #555;
    margin-bottom: 60px;
    font-size: 1.2rem;
    max-width: 700px;
    margin-left: auto;
    margin-right: auto;
    position: relative;
    z-index: 1;
    font-weight: 400;
}

.services-grid-compact {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 30px;
    margin-bottom: 40px;
    position: relative;
    z-index: 1;
}

.service-card-compact {
    background: rgba(255, 255, 255, 0.95);
    border-radius: 18px;
    overflow: hidden;
    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
    transition: all 0.4s ease;
    border: 1px solid rgba(255, 255, 255, 0.3);
    display: flex;
    flex-direction: column;
    height: 100%;
    backdrop-filter: blur(5px);
    -webkit-backdrop-filter: blur(5px);
}

.service-card-compact:hover {
    transform: translateY(-8px);
    box-shadow: 0 15px 40px rgba(0, 0, 0, 0.18);
    border-color: rgba(212, 175, 55, 0.3);
    background: rgba(255, 255, 255, 0.98);
}

.service-card-header {
    padding: 25px 25px 15px;
    background: linear-gradient(135deg, rgba(212, 175, 55, 0.1), rgba(139, 69, 19, 0.05));
    display: flex;
    align-items: center;
    gap: 15px;
    border-bottom: 1px solid rgba(212, 175, 55, 0.2);
}

.service-icon-compact {
    width: 55px;
    height: 55px;
    background: linear-gradient(135deg, #d4af37, #c19b2e);
    border-radius: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 1.6rem;
    flex-shrink: 0;
    box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
    transition: all 0.3s ease;
}

.service-card-compact:hover .service-icon-compact {
    transform: scale(1.05);
    box-shadow: 0 8px 20px rgba(212, 175, 55, 0.4);
}

.service-card-header h3 {
    font-family: 'Playfair Display', serif;
    font-size: 1.4rem;
    color: #2c3e50;
    margin: 0;
    line-height: 1.3;
    font-weight: 600;
}

.service-card-body {
    padding: 25px;
    flex-grow: 1;
}

.service-card-body p {
    color: #555;
    font-size: 1rem;
    line-height: 1.7;
    margin-bottom: 20px;
    min-height: 70px;
}

.service-features-compact {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    margin-bottom: 20px;
}

.service-features-compact span {
    background: rgba(212, 175, 55, 0.1);
    padding: 8px 15px;
    border-radius: 25px;
    font-size: 0.9rem;
    color: #5a4a1f;
    display: flex;
    align-items: center;
    gap: 8px;
    border: 1px solid rgba(212, 175, 55, 0.2);
    font-weight: 500;
}

.service-features-compact i {
    color: #d4af37;
    font-size: 0.85rem;
}

.read-more-content {
    margin-top: 20px;
    padding-top: 20px;
    border-top: 1px solid rgba(212, 175, 55, 0.2);
    animation: fadeIn 0.4s ease;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
}

.extra-info h4 {
    font-size: 1.1rem;
    color: #2c3e50;
    margin-bottom: 12px;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 10px;
}

.extra-info h4:before {
    content: '';
    width: 5px;
    height: 18px;
    background: #d4af37;
    border-radius: 3px;
    display: inline-block;
}

.extra-info ul {
    list-style: none;
    padding-left: 0;
    margin-bottom: 20px;
}

.extra-info li {
    padding: 8px 0;
    color: #555;
    font-size: 0.95rem;
    position: relative;
    padding-left: 25px;
    line-height: 1.5;
}

.extra-info li:before {
    content: "✓";
    color: #d4af37;
    position: absolute;
    left: 0;
    font-weight: bold;
    font-size: 0.9rem;
}

.pricing-info {
    background: linear-gradient(135deg, rgba(212, 175, 55, 0.1), rgba(139, 69, 19, 0.05));
    padding: 15px;
    border-radius: 12px;
    text-align: center;
    margin-top: 20px;
    border: 1px solid rgba(212, 175, 55, 0.2);
}

.pricing-info strong {
    color: #2c3e50;
    font-size: 1.2rem;
    display: block;
    margin-bottom: 5px;
    font-weight: 700;
}

.pricing-info span {
    color: #777;
    font-size: 0.95rem;
    font-weight: 500;
}

.service-card-footer {
    padding: 20px 25px;
    background: rgba(249, 249, 249, 0.8);
    border-top: 1px solid rgba(212, 175, 55, 0.2);
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 15px;
}

.service-button-compact {
    background: linear-gradient(135deg, #d4af37, #c19b2e);
    color: #000;
    padding: 10px 25px;
    border-radius: 30px;
    text-decoration: none;
    font-weight: 600;
    font-size: 0.95rem;
    transition: all 0.3s ease;
    border: 2px solid #d4af37;
    flex-grow: 1;
    text-align: center;
    box-shadow: 0 4px 15px rgba(212, 175, 55, 0.3);
}

.service-button-compact:hover {
    background: transparent;
    color: #d4af37;
    transform: translateY(-3px);
    box-shadow: 0 6px 20px rgba(212, 175, 55, 0.4);
}

.read-more-btn {
    background: transparent;
    border: 1px solid rgba(212, 175, 55, 0.4);
    color: #5a4a1f;
    padding: 10px 20px;
    border-radius: 30px;
    font-size: 0.9rem;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    gap: 8px;
    min-width: 120px;
    justify-content: center;
    font-weight: 500;
    background: rgba(255, 255, 255, 0.9);
}

.read-more-btn:hover {
    border-color: #d4af37;
    background: rgba(212, 175, 55, 0.1);
    color: #d4af37;
    transform: translateY(-2px);
}

.read-more-btn i {
    transition: transform 0.3s ease;
    font-size: 0.85rem;
}

.read-more-btn.active i {
    transform: rotate(180deg);
}

/* ===== RELIGION SPECIFIC ===== */
.religion-services {
    padding: 80px 0;
    background: #f7f3e9;
    border-radius: 40px;
    margin-bottom: 80px;
}

.religion-tabs {
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    gap: 15px;
    margin-bottom: 40px;
}

.religion-tab {
    padding: 12px 30px;
    background: white;
    border: 2px solid #ddd;
    border-radius: 50px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    gap: 10px;
}

.religion-tab:hover {
    border-color: #d4af37;
    color: #d4af37;
}

.religion-tab.active {
    background: #d4af37;
    color: #000;
    border-color: #d4af37;
}

.religion-content {
    background: white;
    padding: 40px;
    border-radius: 25px;
    box-shadow: 0 15px 40px rgba(0, 0, 0, 0.08);
}

.religion-item {
    display: none;
}

.religion-item.active {
    display: block;
}

.religion-item h3 {
    font-family: 'Playfair Display', serif;
    font-size: 2rem;
    color: #2c3e50;
    margin-bottom: 20px;
    display: flex;
    align-items: center;
    gap: 15px;
}

.religion-item p {
    color: #555;
    line-height: 1.8;
    margin-bottom: 25px;
}

.religion-features {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 30px;
    margin-top: 30px;
}

.feature {
    display: flex;
    align-items: flex-start;
    gap: 15px;
}

.feature i {
    color: #d4af37;
    font-size: 1.5rem;
    margin-top: 5px;
}

.feature h4 {
    color: #2c3e50;
    margin-bottom: 8px;
    font-size: 1.1rem;
}

.feature p {
    color: #666;
    font-size: 0.95rem;
    line-height: 1.6;
    margin: 0;
}

        
        /* ===== HERO ===== */
        .hero {
            height: 90vh;
            background: linear-gradient(to bottom, rgba(0,0,0,.65), rgba(0,0,0,.45)),
                        url("<%=request.getContextPath()%>/views/images/temple.jpg") center/cover fixed;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: #fff;
        }
        /* ===== SCROLL PERFORMANCE FIX (DO NOT TOUCH ORIGINAL CODE) ===== */
.hero {
    background-attachment: scroll !important;
}

/* Optional: smoother scrolling */
html {
    scroll-behavior: smooth;
}

/* Improve GPU rendering */
.hero, .religion-card {
    will-change: transform;
}
        
        
        .hero h2 {
            font-family: 'Playfair Display', serif;
            font-size: 3.5rem;
            margin-bottom: 1.5rem;
        }
        
        .hero p {
            font-size: 1.25rem;
            opacity: .9;
            max-width: 800px;
            margin: 0 auto;
        }
        
        /* ===== SECTION ===== */
        .section {
            padding: 6rem 0;
        }
        
        .section-title {
            text-align: center;
            font-family: 'Playfair Display', serif;
            font-size: 3rem;
            margin-bottom: 1rem;
            color: #222;
        }
        
        .section-title span {
            color: #d4af37;
        }
        
        .section-subtitle {
            text-align: center;
            color: #666;
            max-width: 700px;
            margin: 0 auto 4rem;
        }
        
        /* ===== CARD STYLES ===== */
        .religion-card {
            background: #fff;
            border-radius: 22px;
            overflow: hidden;
            box-shadow: 0 20px 45px rgba(0,0,0,.12);
            transition: all 0.4s ease;
            height: 100%;
        }
        
        .religion-card:hover {
            transform: translateY(-18px);
            box-shadow: 0 35px 70px rgba(0,0,0,.18);
        }
        
        .card-img-top {
            width: 100%;
            height: 240px;
            object-fit: cover;
        }
        
        .card-body {
            padding: 1.5rem;
        }
        
        .card-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            margin-bottom: 0.75rem;
            color: #222;
        }
        
        .card-text {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 1rem;
            line-height: 1.6;
        }
        
        .card-link {
            text-decoration: none;
            font-weight: 600;
            color: #8b4513;
            transition: color 0.3s ease;
        }
        
        .card-link:hover {
            color: #d4af37;
        }
        
        /* ===== SAND BACKGROUND PANEL ===== */
        .sand-panel {
            background: #f7efdf;
            padding: 7rem 2rem;
            border-radius: 40px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.15);
        }
        
        /* ===== SERVICES SHOWCASE STYLES ===== */
.services-showcase {
    padding: 100px 0;
    background: linear-gradient(135deg, #f3e6d3 0%, #fff 100%);
    position: relative;
    overflow: hidden;
}

.services-showcase::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 300px;
    background: linear-gradient(to bottom, rgba(212, 175, 55, 0.1), transparent);
    z-index: 0;
}

.services-showcase .section-header {
    text-align: center;
    margin-bottom: 60px;
    position: relative;
    z-index: 1;
}

.services-showcase .section-title {
    font-family: 'Playfair Display', serif;
    font-size: 3.2rem;
    color: #222;
    margin-bottom: 15px;
    position: relative;
    display: inline-block;
}

.services-showcase .section-title span {
    color: #d4af37;
    position: relative;
}

.services-showcase .section-title::after {
    content: '';
    position: absolute;
    bottom: -10px;
    left: 50%;
    transform: translateX(-50%);
    width: 100px;
    height: 4px;
    background: linear-gradient(90deg, transparent, #d4af37, transparent);
    border-radius: 2px;
}

.services-showcase .section-subtitle {
    font-size: 1.2rem;
    color: #666;
    max-width: 700px;
    margin: 0 auto;
    line-height: 1.6;
}

/* ===== SPECIAL OFFERS BANNER ===== */
.special-offers-banner {
    background: linear-gradient(135deg, #222, #111);
    border-radius: 20px;
    padding: 25px 40px;
    margin-bottom: 60px;
    position: relative;
    overflow: hidden;
    box-shadow: 0 20px 40px rgba(34, 34, 34, 0.2);
    border: 1px solid rgba(212, 175, 55, 0.3);
}

.offer-slide {
    display: none;
    align-items: center;
    gap: 20px;
    animation: slideIn 0.5s ease;
}

@keyframes slideIn {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.offer-slide.active {
    display: flex;
}

.offer-slide i {
    font-size: 2rem;
    color: #d4af37;
    background: rgba(212, 175, 55, 0.1);
    padding: 15px;
    border-radius: 15px;
}

.offer-slide span {
    flex-grow: 1;
    color: white;
    font-size: 1.2rem;
    font-weight: 500;
}

.offer-cta {
    background: linear-gradient(135deg, #d4af37, #c19b2e);
    color: #000;
    padding: 12px 30px;
    border-radius: 30px;
    text-decoration: none;
    font-weight: 600;
    transition: all 0.3s ease;
    white-space: nowrap;
    border: 2px solid #d4af37;
}

.offer-cta:hover {
    background: transparent;
    color: #d4af37;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
}

.offer-nav {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    background: rgba(255, 255, 255, 0.1);
    border: none;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    color: white;
    cursor: pointer;
    transition: all 0.3s ease;
    backdrop-filter: blur(10px);
    display: flex;
    align-items: center;
    justify-content: center;
}

.offer-nav:hover {
    background: rgba(212, 175, 55, 0.3);
    transform: translateY(-50%) scale(1.1);
}

.offer-nav.prev {
    left: 15px;
}

.offer-nav.next {
    right: 15px;
}

/* ===== SERVICES GRID ===== */
.services-showcase-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
    gap: 30px;
    margin-bottom: 50px;
    position: relative;
    z-index: 1;
}

.service-showcase-card {
    background: white;
    border-radius: 25px;
    padding: 30px;
    box-shadow: 0 15px 40px rgba(0, 0, 0, 0.1);
    transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    border: 1px solid rgba(212, 175, 55, 0.1);
    position: relative;
    overflow: hidden;
    display: flex;
    flex-direction: column;
    height: 100%;
}

.service-showcase-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 5px;
    background: linear-gradient(90deg, #d4af37, #c19b2e);
    border-radius: 5px 5px 0 0;
}

.service-showcase-card:hover {
    transform: translateY(-15px);
    box-shadow: 0 25px 60px rgba(0, 0, 0, 0.15);
    border-color: rgba(212, 175, 55, 0.3);
}

.service-showcase-card.sacred-journey::before {
    background: linear-gradient(90deg, #d4af37, #c19b2e);
}

.service-showcase-card.spiritual-guidance::before {
    background: linear-gradient(90deg, #3498db, #2980b9);
}


.service-showcase-card.resources::before {
    background: linear-gradient(90deg, #9b59b6, #8e44ad);
}

.service-showcase-card.offerings::before {
    background: linear-gradient(90deg, #e74c3c, #c0392b);
}

.service-showcase-card.information::before {
    background: linear-gradient(90deg, #f39c12, #e67e22);
}

.service-icon-wrapper {
    margin-bottom: 25px;
    position: relative;
}

.service-icon {
    width: 80px;
    height: 80px;
    background: linear-gradient(135deg, #d4af37, #c19b2e);
    border-radius: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 2.2rem;
    margin-bottom: 20px;
    box-shadow: 0 10px 30px rgba(212, 175, 55, 0.3);
    transition: all 0.3s ease;
}

.service-showcase-card:hover .service-icon {
    transform: scale(1.1) rotate(5deg);
    box-shadow: 0 15px 40px rgba(212, 175, 55, 0.4);
}

.service-badge {
    position: absolute;
    top: -10px;
    right: -10px;
    background: linear-gradient(135deg, #e74c3c, #c0392b);
    color: white;
    padding: 6px 15px;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 600;
    animation: pulse 2s infinite;
}

@keyframes pulse {
    0% { transform: scale(1); }
    50% { transform: scale(1.05); }
    100% { transform: scale(1); }
}

.service-content h3 {
    font-family: 'Playfair Display', serif;
    font-size: 1.6rem;
    color: #222;
    margin-bottom: 15px;
    line-height: 1.3;
}

.service-content p {
    color: #666;
    line-height: 1.7;
    margin-bottom: 20px;
    font-size: 0.98rem;
}

.service-features {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    margin-bottom: 25px;
}

.service-features span {
    background: rgba(212, 175, 55, 0.1);
    padding: 8px 16px;
    border-radius: 25px;
    font-size: 0.9rem;
    color: #5a4a1f;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    border: 1px solid rgba(212, 175, 55, 0.2);
    font-weight: 500;
}

.service-features i {
    color: #d4af37;
    font-size: 0.9rem;
}

.service-price {
    margin-top: auto;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-top: 20px;
    border-top: 1px solid rgba(212, 175, 55, 0.2);
}

.price-tag {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
}

.starting {
    font-size: 0.85rem;
    color: #666;
    margin-bottom: 5px;
}

.amount {
    font-size: 2.2rem;
    font-weight: 700;
    color: #222;
    line-height: 1;
}

.period {
    font-size: 0.9rem;
    color: #666;
    margin-top: 5px;
}

.service-cta {
    background: linear-gradient(135deg, #d4af37, #c19b2e);
    color: #000;
    padding: 12px 25px;
    border-radius: 30px;
    text-decoration: none;
    font-weight: 600;
    transition: all 0.3s ease;
    border: 2px solid #d4af37;
    display: inline-flex;
    align-items: center;
    gap: 10px;
    white-space: nowrap;
}

.service-cta:hover {
    background: transparent;
    color: #d4af37;
    transform: translateX(5px);
    box-shadow: 0 5px 20px rgba(212, 175, 55, 0.3);
}

/* ===== VIEW ALL BUTTON ===== */
.view-all-services {
    text-align: center;
    margin-top: 40px;
}

.view-all-btn {
    display: inline-flex;
    align-items: center;
    gap: 15px;
    background: linear-gradient(135deg, #222, #111);
    color: white;
    padding: 18px 40px;
    border-radius: 50px;
    text-decoration: none;
    font-weight: 600;
    font-size: 1.1rem;
    transition: all 0.3s ease;
    border: 2px solid #222;
    box-shadow: 0 10px 30px rgba(34, 34, 34, 0.2);
}

.view-all-btn:hover {
    background: transparent;
    color: #222;
    transform: translateY(-3px);
    box-shadow: 0 15px 40px rgba(34, 34, 34, 0.3);
}

.view-all-btn i {
    transition: transform 0.3s ease;
}

.view-all-btn:hover i {
    transform: translateX(5px);
}

/* ===== RESPONSIVE DESIGN ===== */
@media (max-width: 1200px) {
    .services-showcase-grid {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (max-width: 768px) {
    .services-showcase {
        padding: 70px 0;
    }
    
    .services-showcase .section-title {
        font-size: 2.5rem;
    }
    
    .special-offers-banner {
        padding: 20px;
    }
    
    .offer-slide {
        flex-direction: column;
        text-align: center;
        gap: 15px;
    }
    
    .offer-slide span {
        font-size: 1rem;
    }
    
    .services-showcase-grid {
        grid-template-columns: 1fr;
        gap: 25px;
    }
    
    .service-showcase-card {
        padding: 25px;
    }
    
    .service-price {
        flex-direction: column;
        gap: 20px;
        align-items: stretch;
    }
    
    .price-tag {
        align-items: center;
    }
    
    .service-cta {
        text-align: center;
        justify-content: center;
    }
}

@media (max-width: 480px) {
    .services-showcase .section-title {
        font-size: 2rem;
    }
    
    .services-showcase .section-subtitle {
        font-size: 1.1rem;
    }
    
    .service-icon {
        width: 70px;
        height: 70px;
        font-size: 1.8rem;
    }
    
    .service-content h3 {
        font-size: 1.4rem;
    }
    
    .amount {
        font-size: 1.8rem;
    }
}
        
        /* ===== FOOTER ===== */
        footer {
            background: #111;
            color: #bbb;
            padding: 70px 30px 25px;
        }
        
        .footer-wrap {
            max-width: 1300px;
            margin: auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 40px;
        }
        
        footer h4 {
            color: #d4af37;
            margin-bottom: 15px;
            font-family: 'Playfair Display', serif;
            font-size: 1.3rem;
        }
        
        footer a {
            color: #bbb;
            text-decoration: none;
            display: block;
            margin-bottom: 8px;
            transition: color 0.3s ease;
        }
        
        footer a:hover {
            color: #d4af37;
        }
        
        .footer-bottom {
            text-align: center;
            border-top: 1px solid #333;
            margin-top: 40px;
            padding-top: 20px;
            font-size: 0.9rem;
            opacity: 0.7;
        }
        
        /* ===== RESPONSIVE ===== */
        @media (max-width: 768px) {
            .header-wrap {
                flex-wrap: wrap;
                padding: 15px 20px;
            }
            
            nav {
                width: 100%;
                margin-top: 15px;
                flex-wrap: wrap;
                gap: 10px;
            }
            
            nav a {
                margin-left: 0;
                margin-right: 15px;
            }
            
            .join-us-btn {
                margin-left: 0;
                margin-top: 10px;
                width: 100%;
                justify-content: center;
            }
            
            .hero h2 {
                font-size: 2.5rem;
            }
            
            .hero p {
                font-size: 1.1rem;
                padding: 0 1rem;
            }
            
            .section-title {
                font-size: 2.2rem;
            }
            
            .section {
                padding: 4rem 0;
            }
            
            .sand-panel {
                padding: 4rem 1.5rem;
                border-radius: 30px;
            }
            
            .footer-wrap {
                grid-template-columns: repeat(2, 1fr);
                gap: 30px;
            }
        }
        
        @media (max-width: 576px) {
            .hero h2 {
                font-size: 2rem;
            }
            
            .hero {
                height: 70vh;
            }
            
            .section-title {
                font-size: 1.8rem;
            }
            
            .footer-wrap {
                grid-template-columns: 1fr;
                gap: 30px;
            }
        }
    </style>
</head>

<body>
    <!-- HEADER WITH BOOTSTRAP NAVBAR -->
    <!-- HEADER -->
<header>
    <div class="header-wrap">
        <a href="<%=request.getContextPath()%>/" class="logo">
            <i class="fa-solid fa-hands-praying"></i>
            <h1>Pilgrim<span>Project</span></h1>
        </a>
        <nav>
            <a href="<%=request.getContextPath()%>/">Home</a>
            <a href="<%=request.getContextPath()%>/aboutus">About Us</a>
            <a href="<%=request.getContextPath()%>/services">services</a>
            
            <!-- Services with Dropdown -->
            <div class="nav-services">
                <a href="<%=request.getContextPath()%>/services" class="active">
                    Online Booking <i class="fa-solid fa-chevron-down dropdown-icon"></i>
                </a>
                <div class="services-dropdown">
                    <div class="dropdown-header">
                        <i class="fa-solid fa-list-check"></i> Our Services
                    </div>
                    <div class="dropdown-services">
                        <div class="dropdown-service-item" onclick="scrollToService('sacred-journey')">
                            <i class="fa-solid fa-plane-departure"></i>
                            <span>Sacred Journey Planning</span>
                        </div>
                        <div class="dropdown-service-item" onclick="scrollToService('spiritual-guidance')">
                            <i class="fa-solid fa-hands-praying"></i>
                            <span>Spiritual Guidance</span>
                        </div>
                        <div class="dropdown-service-item" onclick="scrollToService('spiritual-resources')">
                            <i class="fa-solid fa-book-quran"></i>
                            <span>Spiritual Resources</span>
                        </div>
                        <div class="dropdown-service-item" onclick="scrollToService('blessed-offerings')">
                            <i class="fa-solid fa-hand-holding-heart"></i>
                            <span>Blessed Offerings</span>
                        </div>
                        <div class="dropdown-service-item" onclick="scrollToService('sacred-information')">
                            <i class="fa-solid fa-landmark"></i>
                            <span>Sacred Information</span>
                        </div>
                        <div class="dropdown-service-item" onclick="scrollToService('religion-specific')">
                            <i class="fa-solid fa-hands-praying"></i>
                            <span>Religion Specific</span>
                        </div>
                        <div class="dropdown-service-item" onclick="scrollToService('how-it-works')">
                            <i class="fa-solid fa-gears"></i>
                            <span>How It Works</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <a href="<%=request.getContextPath()%>/contactus">Contact Us</a>
            <a href="<%=request.getContextPath()%>/register" class="join-us-btn">
                <i class="fa-solid fa-user-plus"></i> Join Us
            </a>
        </nav>
    </div>
</header>

    <!-- HERO SECTION -->
    <section class="hero">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <h2 class="display-3 fw-bold">One World. Many Faiths.</h2>
                    <p class="lead">Explore temples, churches, mosques, gurudwaras and sacred spaces from every religion — beautifully curated in one place.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- RELIGIONS SECTION -->
    <section class="section">
        <div class="container">
            <div class="sand-panel">
                <h2 class="section-title">All <span>Religions</span> Sacred, Holy & Spiritual Places</h2>
<p class="section-subtitle">
Respecting faith, preserving heritage, and connecting humanity through timeless sacred, holy, and spiritual architecture.
</p>

                <div class="row g-4">
                    <!-- Hindu Temple Card -->
                    <div class="col-lg-4 col-md-6">
                        <div class="religion-card">
                            <img src="<%=request.getContextPath()%>/views/images/Tirumala.jpg" class="card-img-top" alt="Hindu Temple">
                            <div class="card-body">
                                <h5 class="card-title">Hindu Temples</h5>
                                <p class="card-text">Timeless temples dedicated to ancient Hindu traditions.</p>
                                <a href="#" class="card-link">Explore Temples →</a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Christian Church Card -->
                    <div class="col-lg-4 col-md-6">
                        <div class="religion-card">
                           <img src="<%=request.getContextPath()%>/views/images/church.jpg" class="card-img-top" alt="Christian Church">
                            <div class="card-body">
                                <h5 class="card-title">Christian Churches</h5>
                                <p class="card-text">Iconic churches and cathedrals across the world.</p>
                                <a href="#" class="card-link">Explore Churches →</a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Islamic Mosque Card -->
                    <div class="col-lg-4 col-md-6">
                        <div class="religion-card">
                           <img src="<%=request.getContextPath()%>/views/images/islamic.jpg" class="card-img-top" alt="Islamic Mosque">
                            <div class="card-body">
                                <h5 class="card-title">Islamic Mosques</h5>
                                <p class="card-text">Architectural beauty and divine serenity.</p>
                                <a href="#" class="card-link">Explore Mosques →</a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Gurudwara Card -->
                    <div class="col-lg-4 col-md-6">
                        <div class="religion-card">
                         <img src="<%=request.getContextPath()%>/views/images/gurudwaras.jpg" class="card-img-top" alt="Gurudwara">
                            <div class="card-body">
                                <h5 class="card-title">Gurudwaras</h5>
                                <p class="card-text">Sikh places of worship welcoming all people.</p>
                                <a href="#" class="card-link">Explore Gurudwaras →</a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Buddhist Temple Card -->
                    <div class="col-lg-4 col-md-6">
                        <div class="religion-card">
                             <img src="<%=request.getContextPath()%>/views/images/budda1.jpg" class="card-img-top" alt="Buddhist Temple">
                            <div class="card-body">
                                <h5 class="card-title">Buddhist Temples</h5>
                                <p class="card-text">Peaceful spaces for mindfulness and meditation.</p>
                                <a href="#" class="card-link">Explore Temples →</a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Jewish Synagogue Card -->
                    <div class="col-lg-4 col-md-6">
                        <div class="religion-card">
                            <img src="<%=request.getContextPath()%>/views/images/syn.jpg" class="card-img-top" alt="Jewish Synagogue">
                            <div class="card-body">
                                <h5 class="card-title">Jewish Synagogues</h5>
                                <p class="card-text">Sacred centers of prayer, learning, and community.</p>
                                <a href="#" class="card-link">Explore Synagogues →</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- OUR PILGRIMAGE SERVICES SECTION -->
    <section class="services-showcase" id="services-section">
        <div class="container">
            <!-- Section Header -->
            <div class="section-header">
                <h2 class="section-title">Our <span>Pilgrimage Services</span></h2>
                <p class="section-subtitle">Everything you need for a meaningful spiritual journey, all in one place</p>
            </div>

            <!-- Special Offers Banner -->
            <div class="special-offers-banner">
                <div class="offer-slide active">
                    <i class="fa-solid fa-gift"></i>
                    <span>Limited Time: Book any pilgrimage package & get FREE Prasad delivery</span>
                    <a href="<%=request.getContextPath()%>/contactus" class="offer-cta">Claim Offer</a>
                </div>
                <div class="offer-slide">
                    <i class="fa-solid fa-percent"></i>
                    <span>Group Discount: 20% OFF for groups of 5+ pilgrims</span>
                    <a href="<%=request.getContextPath()%>/contactus" class="offer-cta">Book Now</a>
                </div>
                <div class="offer-slide">
                    <i class="fa-solid fa-plane"></i>
                    <span>Early Bird Special: 15% OFF on all international pilgrimages</span>
                    <a href="<%=request.getContextPath()%>/contactus" class="offer-cta">Explore</a>
                </div>
                <button class="offer-nav prev"><i class="fa-solid fa-chevron-left"></i></button>
                <button class="offer-nav next"><i class="fa-solid fa-chevron-right"></i></button>
            </div>

            <!-- Services Grid -->
            <div class="services-showcase-grid">
                <!-- Service 1 -->
                <div class="service-showcase-card sacred-journey">
                    <div class="service-icon-wrapper">
                        <div class="service-icon">
                            <i class="fa-solid fa-plane-departure"></i>
                        </div>
                        <div class="service-badge">
                            <span>Most Popular</span>
                        </div>
                    </div>
                    <div class="service-content">
                        <h3>Sacred Journey Planning</h3>
                        <p>Complete travel arrangements for pilgrimage sites worldwide with respect for all traditions</p>
                        <div class="service-features">
                            <span><i class="fa-solid fa-check"></i> Flight Bookings</span>
                            <span><i class="fa-solid fa-check"></i> Itinerary Planning</span>
                            <span><i class="fa-solid fa-check"></i> Group Coordination</span>
                        </div>
                        <div class="service-price">
                            <div class="price-tag">
                                <span class="starting">Starting from</span>
                                <span class="amount">₹8,999</span>
                                <span class="period">/person</span>
                            </div>
                            <a href="<%=request.getContextPath()%>/services#sacred-journey" class="service-cta">
                                Explore <i class="fa-solid fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Service 2 -->
                <div class="service-showcase-card spiritual-guidance">
                    <div class="service-icon-wrapper">
                        <div class="service-icon">
                            <i class="fa-solid fa-hands-praying"></i>
                        </div>
                        <div class="service-badge">
                            <span>Expert Guides</span>
                        </div>
                    </div>
                    <div class="service-content">
                        <h3>Spiritual Guidance</h3>
                        <p>Connect with verified spiritual guides and religious experts for ceremonies and rituals</p>
                        <div class="service-features">
                            <span><i class="fa-solid fa-check"></i> Verified Guides</span>
                            <span><i class="fa-solid fa-check"></i> Ceremony Support</span>
                            <span><i class="fa-solid fa-check"></i> Multi-faith</span>
                        </div>
                        <div class="service-price">
                            <div class="price-tag">
                                <span class="starting">Starting from</span>
                                <span class="amount">₹2,499</span>
                                <span class="period">/ceremony</span>
                            </div>
                            <a href="<%=request.getContextPath()%>/services#spiritual-guidance" class="service-cta">
                                Explore <i class="fa-solid fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>


                <!-- Service 4 -->
                <div class="service-showcase-card resources">
                    <div class="service-icon-wrapper">
                        <div class="service-icon">
                            <i class="fa-solid fa-book-quran"></i>
                        </div>
                    </div>
                    <div class="service-content">
                        <h3>Spiritual Resources</h3>
                        <p>Access to authentic religious items, sacred texts, and resources for spiritual practices</p>
                        <div class="service-features">
                            <span><i class="fa-solid fa-check"></i> Ritual Kits</span>
                            <span><i class="fa-solid fa-check"></i> Sacred Texts</span>
                            <span><i class="fa-solid fa-check"></i> Home Delivery</span>
                        </div>
                        <div class="service-price">
                            <div class="price-tag">
                                <span class="starting">Starting from</span>
                                <span class="amount">₹299</span>
                                <span class="period">/kit</span>
                            </div>
                            <a href="<%=request.getContextPath()%>/services#spiritual-resources" class="service-cta">
                                Explore <i class="fa-solid fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Service 5 -->
                <div class="service-showcase-card offerings">
                    <div class="service-icon-wrapper">
                        <div class="service-icon">
                            <i class="fa-solid fa-hand-holding-heart"></i>
                        </div>
                        <div class="service-badge">
                            <span>New</span>
                        </div>
                    </div>
                    <div class="service-content">
                        <h3>Blessed Offerings</h3>
                        <p>Receive authentic blessed offerings from sacred sites delivered to your home</p>
                        <div class="service-features">
                            <span><i class="fa-solid fa-check"></i> Temple Prasad</span>
                            <span><i class="fa-solid fa-check"></i> Nationwide</span>
                            <span><i class="fa-solid fa-check"></i> Verified</span>
                        </div>
                        <div class="service-price">
                            <div class="price-tag">
                                <span class="starting">Starting from</span>
                                <span class="amount">₹199</span>
                                <span class="period">/offering</span>
                            </div>
                            <a href="<%=request.getContextPath()%>/services#blessed-offerings" class="service-cta">
                                Explore <i class="fa-solid fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Service 6 -->
                <div class="service-showcase-card information">
                    <div class="service-icon-wrapper">
                        <div class="service-icon">
                            <i class="fa-solid fa-landmark"></i>
                        </div>
                    </div>
                    <div class="service-content">
                        <h3>Sacred Information</h3>
                        <p>Complete guides to sacred places with historical context and visiting information</p>
                        <div class="service-features">
                            <span><i class="fa-solid fa-check"></i> Site Guides</span>
                            <span><i class="fa-solid fa-check"></i> Timings</span>
                            <span><i class="fa-solid fa-check"></i> Virtual Tours</span>
                        </div>
                        <div class="service-price">
                            <div class="price-tag">
                                <span class="starting">Completely</span>
                                <span class="amount">FREE</span>
                                <span class="period">Access</span>
                            </div>
                            <a href="<%=request.getContextPath()%>/services#sacred-information" class="service-cta">
                                Explore <i class="fa-solid fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- View All Button -->
            <div class="view-all-services">
                <a href="<%=request.getContextPath()%>/services" class="view-all-btn">
                    <span>View All Services</span>
                    <i class="fa-solid fa-arrow-right"></i>
                </a>
            </div>
        </div>
    </section>

    <!-- FOOTER -->
    <%@ include file="includes/footer.jsp" %>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Optional: Custom JavaScript -->
    <script>
        // Activate current page in navbar
        document.addEventListener('DOMContentLoaded', function() {
            const currentPage = window.location.pathname.split('/').pop();
            const navLinks = document.querySelectorAll('.nav-link');
            
            navLinks.forEach(link => {
                if (link.getAttribute('href') === currentPage) {
                    link.classList.add('active');
                } else {
                    link.classList.remove('active');
                }
            });
        });
        
        // Services Section JavaScript
        // Offers Banner Slider
        const offerSlides = document.querySelectorAll('.offer-slide');
        const prevBtn = document.querySelector('.offer-nav.prev');
        const nextBtn = document.querySelector('.offer-nav.next');
        let currentSlide = 0;
        
        function showSlide(index) {
            offerSlides.forEach(slide => slide.classList.remove('active'));
            offerSlides[index].classList.add('active');
        }
        
        function nextSlide() {
            currentSlide = (currentSlide + 1) % offerSlides.length;
            showSlide(currentSlide);
        }
        
        function prevSlide() {
            currentSlide = (currentSlide - 1 + offerSlides.length) % offerSlides.length;
            showSlide(currentSlide);
        }
        
        // Auto slide every 5 seconds
        let slideInterval = setInterval(nextSlide, 5000);
        
        // Navigation buttons
        if (prevBtn && nextBtn) {
            prevBtn.addEventListener('click', function() {
                clearInterval(slideInterval);
                prevSlide();
                slideInterval = setInterval(nextSlide, 5000);
            });
            
            nextBtn.addEventListener('click', function() {
                clearInterval(slideInterval);
                nextSlide();
                slideInterval = setInterval(nextSlide, 5000);
            });
        }
        
        // Pause auto-slide on hover
        const banner = document.querySelector('.special-offers-banner');
        if (banner) {
            banner.addEventListener('mouseenter', () => clearInterval(slideInterval));
            banner.addEventListener('mouseleave', () => {
                slideInterval = setInterval(nextSlide, 5000);
            });
        }
        
        // Add hover effect to service cards
        const serviceCards = document.querySelectorAll('.service-showcase-card');
        serviceCards.forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-15px) scale(1.02)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(-15px)';
            });
        });
        
        // Animate cards on scroll
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, {
            threshold: 0.1,
            rootMargin: '50px'
        });
        
        serviceCards.forEach(card => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(30px)';
            card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
            observer.observe(card);
        });
    </script>
    
</body>
</html>