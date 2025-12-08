<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Privacy Policy | Pilgrim Project</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

    <style>
        /* ===== GLOBAL STYLES (from index.jsp) ===== */
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
        
        /* ===== HEADER STYLES (from index.jsp) ===== */
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
        
        /* ===== PAGE HERO ===== */
        .page-hero {
            background: linear-gradient(rgba(0,0,0,.7), rgba(0,0,0,.5)),
                        url("<%=request.getContextPath()%>/views/images/shiva2.jpg") center/cover;
            padding: 140px 20px;
            text-align: center;
            color: #fff;
            position: relative;
            overflow: hidden;
        }
        
        .page-hero h1 {
            font-family: 'Playfair Display', serif;
            font-size: 3.2rem;
            margin-bottom: 1rem;
        }
        
        .page-hero p {
            font-size: 1.2rem;
            opacity: 0.9;
            max-width: 600px;
            margin: 0 auto;
        }
        
        /* ===== CONTENT BOX ===== */
        .content-box {
            background: #fff;
            border-radius: 25px;
            padding: 50px;
            margin: -80px auto 60px;
            max-width: 1100px;
            box-shadow: 0 20px 60px rgba(0,0,0,.15);
            position: relative;
            z-index: 2;
        }
        
        .content-box h2 {
            font-family: 'Playfair Display', serif;
            margin-top: 40px;
            margin-bottom: 20px;
            color: #222;
            font-size: 2rem;
        }
        
        .content-box h3 {
            font-family: 'Inter', sans-serif;
            margin-top: 30px;
            margin-bottom: 15px;
            color: #333;
            font-weight: 600;
            font-size: 1.3rem;
        }
        
        .content-box p {
            color: #555;
            line-height: 1.8;
            margin-bottom: 20px;
            font-size: 1.05rem;
        }
        
        .content-box ul, .content-box ol {
            margin-left: 25px;
            margin-bottom: 25px;
        }
        
        .content-box li {
            color: #555;
            line-height: 1.8;
            margin-bottom: 10px;
            font-size: 1.05rem;
        }
        
        /* ===== HIGHLIGHT BOXES ===== */
        .highlight-box {
            background: #f7efdf;
            border-left: 5px solid #d4af37;
            padding: 25px;
            margin: 25px 0;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.05);
        }
        
        .highlight-box strong {
            color: #8b4513;
        }
        
        .warning-box {
            background: #fff4f4;
            border: 2px solid #e74c3c;
            padding: 25px;
            margin: 25px 0;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(231, 76, 60, 0.1);
        }
        
        .warning-box strong {
            color: #e74c3c;
        }
        
        /* ===== FOOTER STYLES (from index.jsp) ===== */
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
            .page-hero {
                padding: 100px 20px;
            }
            
            .page-hero h1 {
                font-size: 2.5rem;
            }
            
            .content-box {
                padding: 35px 25px;
                margin: -60px 15px 40px;
            }
            
            .content-box h2 {
                font-size: 1.7rem;
            }
            
            .footer-wrap {
                grid-template-columns: repeat(2, 1fr);
                gap: 30px;
            }
        }
        
        @media (max-width: 576px) {
            .page-hero {
                padding: 80px 20px;
            }
            
            .page-hero h1 {
                font-size: 2rem;
            }
            
            .page-hero p {
                font-size: 1rem;
            }
            
            .content-box {
                padding: 25px 20px;
                margin: -50px 10px 30px;
            }
            
            .content-box h2 {
                font-size: 1.5rem;
            }
            
            .footer-wrap {
                grid-template-columns: 1fr;
                gap: 30px;
            }
        }
    </style>
</head>

<body>

<!-- HEADER (from index.jsp) -->
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
    <h1>Privacy Policy</h1>
    <p>Your trust • Our responsibility • Complete transparency</p>
</section>

<!-- CONTENT -->
<div class="container">
    <div class="content-box">

        <h2>1. Introduction</h2>
        <p>
            Pilgrim Project respects your privacy and is committed to protecting the
            personal information you share with us. This Privacy Policy explains how
            we handle information when you use our platform.
        </p>

        <h2>2. Nature of This Project</h2>
        <div class="highlight-box">
            <p>
                <strong>Pilgrim Project acts only as a bridge between users and sacred places
                of all religions.</strong> We provide information, guidance, and connections,
                but we are <strong>not affiliated with any religious institution, authority,
                or financial body.</strong>
            </p>
        </div>

        <h2>3. Information We May Collect</h2>
        <ul>
            <li>Basic details such as name, email, or contact information (if voluntarily provided)</li>
            <li>General usage data for improving site performance</li>
            <li>Messages submitted through contact forms</li>
        </ul>

        <h2>4. Information We Do NOT Collect</h2>
        <div class="highlight-box">
            <ul>
                <li>We do NOT collect bank details, card numbers, or PINs</li>
                <li>We do NOT store UPI, wallet, or net-banking credentials</li>
                <li>We do NOT process or control money transactions</li>
            </ul>
        </div>

        <h2>5. Money Transaction Disclaimer (100% Assurance)</h2>
        <div class="warning-box">
            <p>
                <strong>Important Assurance:</strong><br>
                Pilgrim Project is <strong>NOT responsible</strong> for any payments,
                donations, offerings, bookings, or financial transactions made by users.
                Any monetary transaction occurs directly between users and third-party
                service providers or religious institutions.
            </p>
            <p>
                <strong>Pilgrim Project shall not be held liable for:</strong>
            </p>
            <ul>
                <li>Payment failures or transaction errors</li>
                <li>Fraud, misuse, or loss of money</li>
                <li>Refund disputes or chargebacks</li>
                <li>Third-party payment gateway issues</li>
            </ul>
        </div>

        <h2>6. Data Protection & Security</h2>
        <p>
            We use reasonable security practices to protect user information.
            However, no digital platform can guarantee complete security.
        </p>
        <p>
            By using this platform, you acknowledge that data transmission over the
            internet is at your own risk.
        </p>

        <h2>7. Third-Party Links & Services</h2>
        <p>
            Our platform may contain links to external websites or services.
            We are not responsible for the privacy practices, content, or policies
            of any third-party websites.
        </p>

        <h2>8. User Responsibility</h2>
        <ul>
            <li>You are responsible for safeguarding your own personal information</li>
            <li>You must verify authenticity before engaging in financial activities</li>
            <li>You must respect all religions, beliefs, and traditions</li>
        </ul>

        <h2>9. Policy Updates</h2>
        <p>
            This Privacy Policy may be updated at any time. Continued use of the platform
            indicates acceptance of any changes.
        </p>

        <h2>10. Contact Information</h2>
        <p>
            For privacy-related questions or concerns, please contact us through the
            details provided on the Contact Us page.
        </p>

    </div>
</div>

<!-- FOOTER (from index.jsp) -->
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

<!-- Navbar Active Link Script -->
<script>
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
        
        // Highlight privacy policy link in navbar
        if (currentPage === 'privacy.jsp') {
            document.querySelector('a[href="privacy.jsp"]').classList.add('active');
        }
    });
</script>

</body>
</html>