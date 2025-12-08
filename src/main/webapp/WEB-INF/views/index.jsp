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
            background: rgba(20, 20, 20, 0.95);
            backdrop-filter: blur(10px);
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
            margin: 0;
        }
        
        .logo span {
            color: #d4af37;
        }
        
        .navbar-nav .nav-link {
            color: #ddd;
            margin-left: 20px;
            font-weight: 500;
            position: relative;
            transition: color 0.3s ease;
        }
        
        .navbar-nav .nav-link:hover {
            color: #fff;
        }
        
        .navbar-nav .nav-link.active {
            color: #d4af37;
        }
        
        .navbar-nav .nav-link::after {
            content: "";
            position: absolute;
            width: 0;
            height: 2px;
            background: #d4af37;
            left: 0;
            bottom: 0;
            transition: width 0.3s ease;
        }
        
        .navbar-nav .nav-link:hover::after,
        .navbar-nav .nav-link.active::after {
            width: 100%;
        }
        
        .navbar-toggler {
            border: none;
            padding: 0;
        }
        
        .navbar-toggler:focus {
            box-shadow: none;
        }
        
        .navbar-toggler-icon {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba%28255, 255, 255, 0.8%29' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
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
    <header>
        <nav class="navbar navbar-expand-lg">
            <div class="container">
                <a href="<%=request.getContextPath()%>/" class="logo">
                    <i class="fa-solid fa-hands-praying"></i>
                    <h1>Pilgrim<span>Project</span></h1>
                </a>
                
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link active" href="<%=request.getContextPath()%>/">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<%=request.getContextPath()%>/aboutus">About Us</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<%=request.getContextPath()%>/services">Services</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<%=request.getContextPath()%>/contactus">Contact Us</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<%=request.getContextPath()%>/login">
                                <i class="fa-solid fa-user"></i> Login
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link btn btn-primary text-white ms-2" href="<%=request.getContextPath()%>/register" style="border-radius: 5px; padding: 5px 15px;">
                                <i class="fa-solid fa-user-plus"></i> Register
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
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

    <!-- FOOTER (From aboutus.jsp) -->
    <footer>
        <div class="footer-wrap">
            <div>
                <h4>Pilgrim Project</h4>
                <p>Building harmony by showcasing sacred places of every faith. Connecting humanity through shared spiritual heritage.</p>
            </div>
            
            <div>
                <h4>Quick Links</h4>
                <a href="<%=request.getContextPath()%>/">Home</a>
                <a href="<%=request.getContextPath()%>/services">Services</a>
                <a href="<%=request.getContextPath()%>/aboutus">About Us</a>
                <a href="<%=request.getContextPath()%>/contactus">Contact Us</a>
            </div>
            
            <div>
                <h4>Religions</h4>
                <a href="#">Hinduism</a>
                <a href="#">Christianity</a>
                <a href="#">Islam</a>
                <a href="#">Buddhism</a>
                <a href="#">Sikhism</a>
                <a href="#">Judaism</a>
            </div>
            
            <div>
                <h4>Legal</h4>
                <a href="<%=request.getContextPath()%>/privacy">Privacy Policy</a>
                <a href="<%=request.getContextPath()%>/terms">Terms & Conditions</a>


                <a href="#">Accessibility</a>
                <a href="#">Partnerships</a>
            </div>
        </div>
        
        <div class="footer-bottom">
            © <%= java.time.Year.now() %> Pilgrim Project. All Rights Reserved. | Made with <i class="fa-solid fa-heart" style="color:#d4af37;"></i> for humanity
        </div>
    </footer>

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