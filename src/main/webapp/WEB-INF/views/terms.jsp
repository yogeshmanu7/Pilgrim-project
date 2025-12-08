<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Terms & Conditions | Pilgrim Project</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: #f3e6d3;
            color: #222;
        }

        /* HEADER STYLES - Matching original */
        header {
            background: rgba(20, 20, 20, 0.95);
            backdrop-filter: blur(10px);
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        
        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
            color: #fff;
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
        
        .nav-link {
            color: #ddd !important;
            margin-left: 20px;
            font-weight: 500;
            position: relative;
            transition: color 0.3s ease;
        }
        
        .nav-link:hover {
            color: #fff !important;
        }
        
        .nav-link.active {
            color: #d4af37 !important;
        }
        
        .nav-link::after {
            content: "";
            position: absolute;
            width: 0;
            height: 2px;
            background: #d4af37;
            left: 0;
            bottom: 0;
            transition: width 0.3s ease;
        }
        
        .nav-link:hover::after,
        .nav-link.active::after {
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

        /* HERO */
        .page-hero {
            background: linear-gradient(rgba(0,0,0,.7), rgba(0,0,0,.5)),
            url("<%=request.getContextPath()%>/views/images/shiva2.jpg") center/cover;
            padding: 120px 20px;
            text-align: center;
            color: #fff;
        }

        .page-hero h1 {
            font-family: 'Playfair Display', serif;
            font-size: 3rem;
        }

        /* CONTENT */
        .content-box {
            background: #fff;
            border-radius: 25px;
            padding: 50px;
            margin: -80px auto 60px;
            max-width: 1100px;
            box-shadow: 0 20px 60px rgba(0,0,0,.15);
        }

        .content-box h2 {
            font-family: 'Playfair Display', serif;
            margin-top: 30px;
            color: #222;
        }

        .content-box p, li {
            color: #555;
            line-height: 1.8;
        }

        ul li {
            margin-left: 18px;
        }

        .security-box {
            background: #f7efdf;
            border-left: 5px solid #d4af37;
            padding: 25px;
            margin: 25px 0;
            border-radius: 15px;
        }

        .warning-box {
            background: #fff4f4;
            border: 2px solid #e74c3c;
            padding: 25px;
            margin: 25px 0;
            border-radius: 15px;
        }

        /* FOOTER STYLES - Matching original */
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
        
        /* RESPONSIVE */
        @media (max-width: 768px) {
            .page-hero h1 {
                font-size: 2.5rem;
            }
            
            .page-hero p {
                font-size: 1.1rem;
                padding: 0 1rem;
            }
            
            .content-box {
                padding: 40px 20px;
                margin: -60px auto 60px;
            }
            
            .footer-wrap {
                grid-template-columns: repeat(2, 1fr);
                gap: 30px;
            }
        }
        
        @media (max-width: 576px) {
            .page-hero h1 {
                font-size: 2rem;
            }
            
            .page-hero {
                padding: 100px 20px;
            }
            
            .footer-wrap {
                grid-template-columns: 1fr;
                gap: 30px;
            }
        }
    </style>
</head>

<body>

<!-- HEADER - Matching original design -->
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
                        <a class="nav-link" href="<%=request.getContextPath()%>/">Home</a>
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
                </ul>
            </div>
        </div>
    </nav>
</header>

<!-- HERO -->
<section class="page-hero">
    <h1>Terms & Conditions</h1>
    <p>Respecting all faiths • Serving every pilgrim</p>
</section>

<!-- CONTENT -->
<div class="content-box">

    <h2>1. Acceptance of Terms</h2>
    <p>
        By accessing and using Pilgrim Project, you agree to comply with these
        Terms & Conditions. If you do not agree, please discontinue using our services.
    </p>

    <h2>2. Nature of Service</h2>
    <p>
        Pilgrim Project is a spiritual information and facilitation platform connecting
        users with sacred places across all religions. We are not a religious authority,
        travel agency, or governing body.
    </p>

    <h2>3. Data Security & Data Breach Disclaimer</h2>

    <div class="security-box">
        <p>
            Pilgrim Project takes reasonable and industry-standard measures to protect
            user data, including administrative, technical, and physical safeguards.
            These measures are designed to reduce the risk of unauthorized access,
            disclosure, or misuse.
        </p>
        <ul>
            <li>Secure servers and encrypted connections where applicable</li>
            <li>Limited access to sensitive information</li>
            <li>Regular security reviews and updates</li>
        </ul>
    </div>

    <div class="warning-box">
        <p>
            <strong>Important Disclaimer:</strong><br>
            While we strive to protect your information, no system can be guaranteed
            to be 100% secure. By using this platform, you acknowledge that Pilgrim Project
            shall not be held liable for data breaches caused by factors beyond our
            reasonable control, including cyber-attacks, third-party failures, or
            unforeseen technical vulnerabilities.
        </p>
    </div>

    <h2>4. User Responsibilities</h2>
    <ul>
        <li>Provide accurate and lawful information</li>
        <li>Maintain the confidentiality of your own credentials</li>
        <li>Respect all religions, beliefs, and traditions</li>
        <li>Avoid misuse or harmful activities on the platform</li>
    </ul>

    <h2>5. Content Usage & Ownership</h2>
    <p>
        All content, including text, images, designs, and logos, is protected by
        intellectual property laws. Unauthorized copying, reproduction, or distribution
        is strictly prohibited.
    </p>

    <h2>6. Limitation of Liability</h2>
    <p>
        Pilgrim Project shall not be responsible for travel disruptions, changes in
        religious site rules, third-party services, technical outages, or indirect
        damages arising from platform usage.
    </p>

    <h2>7. Modifications to Terms</h2>
    <p>
        These Terms may be updated at any time. Continued use of the platform
        after changes indicates acceptance of the revised Terms.
    </p>
</div>

<!-- FOOTER - Matching original design -->
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
        © <span id="current-year"></span> Pilgrim Project. All Rights Reserved. | Made with <i class="fa-solid fa-heart" style="color:#d4af37;"></i> for humanity
    </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom JavaScript -->
<script>
    // Set current year in footer
    document.getElementById('current-year').textContent = new Date().getFullYear();
    
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
</script>
</body>
</html>