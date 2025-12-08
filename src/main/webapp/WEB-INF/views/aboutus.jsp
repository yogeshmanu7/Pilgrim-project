<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>About Us | Pilgrim Project</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Learn about Pilgrim Project - Connecting all religions, respecting pilgrims, and celebrating India's and world's spiritual heritage for travelers and tours.">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700;800&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
/* ===== GLOBAL ===== */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Inter', sans-serif;
    background: #f9f7f2;
    color: #333;
    line-height: 1.6;
}

.container {
    max-width: 1300px;
    margin: 0 auto;
    padding: 0 30px;
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

/* ===== ABOUT HERO ===== */
.about-hero {
    background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)),
                url('<%=request.getContextPath()%>/views/images/new2.jpg') center center / cover no-repeat;
    height: 100vh;                 /* FULL SCREEN HEIGHT */
    min-height: 100vh;
    width: 100%;
    display: flex;
    align-items: center;           /* Vertical centering */
    justify-content: center;       /* Horizontal centering */
    text-align: center;
    color: white;
    margin-bottom: 80px;
}


.about-hero-content {
    max-width: 800px;
    padding: 0 20px;
}

.about-hero h1 {
    font-family: 'Playfair Display', serif;
    font-size: 3.8rem;
    margin-bottom: 20px;
    font-weight: 800;
}

.about-hero p {
    font-size: 1.2rem;
    opacity: 0.9;
    max-width: 700px;
    margin: 0 auto;
}

/* ===== MISSION SECTION ===== */
.mission-section {
    padding: 100px 0;
    background: #fff;
    border-radius: 40px;
    margin-bottom: 80px;
    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.08);
}

.mission-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 50px;
    align-items: center;
}

.mission-content h2 {
    font-family: 'Playfair Display', serif;
    font-size: 2.8rem;
    color: #2c3e50;
    margin-bottom: 25px;
    line-height: 1.2;
}

.mission-content h2 span {
    color: #d4af37;
}

.mission-content p {
    font-size: 1.1rem;
    color: #555;
    margin-bottom: 25px;
    line-height: 1.8;
}

.mission-stats {
    display: flex;
    gap: 40px;
    margin-top: 40px;
}

.stat-item {
    text-align: center;
}

.stat-number {
    font-family: 'Playfair Display', serif;
    font-size: 2.5rem;
    color: #d4af37;
    font-weight: 700;
    margin-bottom: 5px;
}

.stat-label {
    color: #666;
    font-size: 0.9rem;
    text-transform: uppercase;
    letter-spacing: 1px;
}

.mission-image {
    border-radius: 30px;
    overflow: hidden;
    box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
}

.mission-image img {
    width: 100%;
    height: auto;
    display: block;
    transition: transform 0.5s ease;
}

.mission-image:hover img {
    transform: scale(1.05);
}

/* ===== VALUES SECTION ===== */
.values-section {
    padding: 100px 0;
    background: #f7f3e9;
    border-radius: 40px;
    margin-bottom: 80px;
}

.section-title {
    text-align: center;
    font-family: 'Playfair Display', serif;
    font-size: 2.8rem;
    color: #2c3e50;
    margin-bottom: 60px;
}

.values-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 40px;
}

.value-card {
    background: white;
    padding: 40px 30px;
    border-radius: 25px;
    text-align: center;
    box-shadow: 0 15px 40px rgba(0, 0, 0, 0.08);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.value-card:hover {
    transform: translateY(-10px);
    box-shadow: 0 25px 60px rgba(0, 0, 0, 0.12);
}

.value-icon {
    font-size: 3rem;
    color: #d4af37;
    margin-bottom: 25px;
}

.value-card h3 {
    font-family: 'Playfair Display', serif;
    font-size: 1.8rem;
    color: #2c3e50;
    margin-bottom: 15px;
}

.value-card p {
    color: #666;
    font-size: 1rem;
    line-height: 1.7;
}

/* ===== INDIA HERITAGE SECTION ===== */
.heritage-section {
    padding: 100px 0;
    background: linear-gradient(to right, #f9f7f2 50%, #fff 50%);
    margin-bottom: 80px;
    border-radius: 40px;
    overflow: hidden;
}

.heritage-content {
    max-width: 1300px;
    margin: 0 auto;
    padding: 0 30px;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 60px;
    align-items: center;
}

.heritage-text h2 {
    font-family: 'Playfair Display', serif;
    font-size: 2.8rem;
    color: #2c3e50;
    margin-bottom: 25px;
}

.heritage-text p {
    font-size: 1.1rem;
    color: #555;
    margin-bottom: 25px;
    line-height: 1.8;
}

.heritage-list {
    list-style: none;
    margin-top: 30px;
}

.heritage-list li {
    margin-bottom: 15px;
    display: flex;
    align-items: center;
    font-size: 1.1rem;
    color: #444;
}

.heritage-list i {
    color: #d4af37;
    margin-right: 15px;
    font-size: 1.2rem;
}

.heritage-image {
    border-radius: 30px;
    overflow: hidden;
    box-shadow: 0 30px 60px rgba(0, 0, 0, 0.15);
}

.heritage-image img {
    width: 100%;
    height: auto;
    display: block;
}

/* ===== TRAVELERS SECTION ===== */
.travelers-section {
    padding: 100px 0;
    background: #fff;
    border-radius: 40px;
    margin-bottom: 80px;
}

.travelers-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 50px;
    align-items: center;
}

.traveler-feature {
    background: #f9f7f2;
    padding: 40px;
    border-radius: 25px;
    border-left: 5px solid #d4af37;
    margin-bottom: 30px;
}

.traveler-feature h3 {
    font-family: 'Playfair Display', serif;
    font-size: 1.8rem;
    color: #2c3e50;
    margin-bottom: 15px;
}

.traveler-feature p {
    color: #666;
    line-height: 1.7;
}

.traveler-image {
    border-radius: 30px;
    overflow: hidden;
    box-shadow: 0 25px 50px rgba(0, 0, 0, 0.12);
}

.traveler-image img {
    width: 100%;
    height: auto;
    display: block;
}

/* ===== TEAM SECTION ===== */
.team-section {
    padding: 100px 0;
    background: #f7f3e9;
    border-radius: 40px;
    margin-bottom: 80px;
}

.team-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 40px;
}

.team-card {
    background: white;
    border-radius: 25px;
    overflow: hidden;
    text-align: center;
    box-shadow: 0 15px 40px rgba(0, 0, 0, 0.08);
    transition: transform 0.3s ease;
}

.team-card:hover {
    transform: translateY(-10px);
}

.team-image {
    height: 250px;
    overflow: hidden;
}

.team-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.5s ease;
}

.team-card:hover .team-image img {
    transform: scale(1.1);
}

.team-info {
    padding: 30px 20px;
}

.team-info h3 {
    font-family: 'Playfair Display', serif;
    font-size: 1.5rem;
    color: #2c3e50;
    margin-bottom: 5px;
}

.team-info p {
    color: #d4af37;
    font-weight: 500;
    margin-bottom: 15px;
}

.team-info .description {
    color: #666;
    font-size: 0.95rem;
    line-height: 1.6;
}

/* ===== CTA SECTION ===== */
.cta-section {
    padding: 100px 0;
    background: linear-gradient(rgba(0, 0, 0, 0.8), rgba(0, 0, 0, 0.8)),
                url('<%=request.getContextPath()%>/views/images/gumb.jpg') center/cover no-repeat;
    color: white;
    text-align: center;
    border-radius: 40px;
    margin-bottom: 80px;
}

.cta-content {
    max-width: 800px;
    margin: 0 auto;
    padding: 0 20px;
}

.cta-content h2 {
    font-family: 'Playfair Display', serif;
    font-size: 2.8rem;
    margin-bottom: 20px;
}

.cta-content p {
    font-size: 1.2rem;
    opacity: 0.9;
    margin-bottom: 40px;
    line-height: 1.7;
}

.cta-button {
    display: inline-block;
    background: #d4af37;
    color: #000;
    padding: 18px 45px;
    border-radius: 50px;
    text-decoration: none;
    font-weight: 600;
    font-size: 1.1rem;
    transition: all 0.3s ease;
    border: 2px solid #d4af37;
}

.cta-button:hover {
    background: transparent;
    color: #d4af37;
    transform: translateY(-3px);
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
    .about-hero {
        height: 100vh;
        padding: 0 15px;
    }
}
    
    .mission-content h2,
    .section-title,
    .heritage-text h2 {
        font-size: 2.3rem;
    }
    
    .heritage-section {
        background: #f9f7f2;
    }
}

@media (max-width: 768px) {
    nav {
        display: none;
    }
    
    .about-hero {
        height: 50vh;
    }
    
    .about-hero h1 {
        font-size: 2.2rem;
    }
    
    .mission-stats {
        flex-direction: column;
        gap: 20px;
    }
    
    .mission-section,
    .values-section,
    .heritage-section,
    .travelers-section,
    .team-section,
    .cta-section {
        padding: 60px 0;
    }
}

@media (max-width: 480px) {
    .header-wrap {
        padding: 15px 20px;
    }
    
    .container {
        padding: 0 20px;
    }
    
    .about-hero h1 {
        font-size: 1.8rem;
    }
    
    .mission-content h2,
    .section-title,
    .heritage-text h2,
    .cta-content h2 {
        font-size: 1.8rem;
    }
}
</style>
</head>

<body>

<!-- HEADER -->
<header>
    <div class="header-wrap">
        <a href="<%=request.getContextPath()%>/" class="logo">
            <i class="fa-solid fa-hands-praying"></i>
            <h1>Pilgrim<span>Project</span></h1>
        </a>
        <nav>
            <a href="<%=request.getContextPath()%>/">Home</a>
         
            <a href="<%=request.getContextPath()%>/aboutus" class="active">About Us</a>
            <a href="<%=request.getContextPath()%>/services">Services</a>
            <a href="<%=request.getContextPath()%>/contactus">Contact Us</a>
        </nav>
    </div>
</header>

<!-- ABOUT HERO -->
<section class="about-hero">
    <div class="about-hero-content">
        <h1>Our Journey of Unity</h1>
        <p>Connecting humanity through the sacred spaces that define our spiritual heritage across India and the world</p>
    </div>
</section>

<!-- MISSION SECTION -->
<section class="mission-section">
    <div class="container mission-grid">
        <div class="mission-content">
            <h2>Our <span>Mission</span>: Bridging Faiths, Connecting Souls</h2>
            <p>Pilgrim Project was born from a simple yet profound idea: that in a world often divided by religious differences, we can build bridges through understanding and appreciation of each other's sacred spaces.</p>
            <p>We are not a religion-based organization. We are a celebration of all religions—a platform that honors Hindu temples, Christian churches, Islamic mosques, Sikh gurudwaras, Buddhist monasteries, Jewish synagogues, and every other place where people seek connection with the divine.</p>
            <p>Our work is dedicated to the millions of pilgrims who travel in faith, the curious travelers seeking spiritual understanding, and the tours that facilitate these transformative journeys.</p>
            
            <div class="mission-stats">
                <div class="stat-item">
                    <div class="stat-number">500+</div>
                    <div class="stat-label">Sacred Places</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">25+</div>
                    <div class="stat-label">Countries</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">50K+</div>
                    <div class="stat-label">Travelers Served</div>
                </div>
            </div>
        </div>
        
        <div class="mission-image">
            <img src="<%=request.getContextPath()%>/views/images/mission.jpg" alt="Interfaith harmony - people of different religions together">
        </div>
    </div>
</section>

<!-- VALUES SECTION -->
<section class="values-section">
    <div class="container">
        <h2 class="section-title">Our Core Values</h2>
        <div class="values-grid">
            <div class="value-card">
                <div class="value-icon">
                    <i class="fa-solid fa-hands-holding-heart"></i>
                </div>
                <h3>Respect for All Faiths</h3>
                <p>We approach every religion with equal reverence, acknowledging that all paths lead to spiritual truth in their own way.</p>
            </div>
            
            <div class="value-card">
                <div class="value-icon">
                    <i class="fa-solid fa-hands-praying"></i>
                </div>
                <h3>Pilgrim-Centered</h3>
                <p>Everything we do focuses on making pilgrimage easier, more meaningful, and accessible for people of all backgrounds.</p>
            </div>
            
            <div class="value-card">
                <div class="value-icon">
                    <i class="fa-solid fa-landmark-dome"></i>
                </div>
                <h3>Cultural Preservation</h3>
                <p>We document and celebrate the architectural and cultural heritage of sacred places before they are lost to time.</p>
            </div>
            
            <div class="value-card">
                <div class="value-icon">
                    <i class="fa-solid fa-people-group"></i>
                </div>
                <h3>Inclusive Community</h3>
                <p>We create spaces where people from different religions can share experiences without judgment or conversion agenda.</p>
            </div>
        </div>
    </div>
</section>

<!-- INDIA HERITAGE SECTION -->
<section class="heritage-section">
    <div class="heritage-content">
        <div class="heritage-text">
            <h2>India's Spiritual Tapestry</h2>
            <p>India, the birthplace of four major world religions and home to nearly all, represents the world's most profound experiment in religious coexistence. Our work here is particularly special.</p>
            <p>From the ancient temples of Tamil Nadu to the Sufi shrines of Delhi, from the Golden Temple in Amritsar to the Basilica of Bom Jesus in Goa—India's spiritual landscape is a living museum of faith.</p>
            
            <ul class="heritage-list">
                <li><i class="fa-solid fa-check"></i> Documenting 5000+ years of religious history</li>
                <li><i class="fa-solid fa-check"></i> Preserving endangered pilgrimage routes</li>
                <li><i class="fa-solid fa-check"></i> Supporting local communities around sacred sites</li>
                <li><i class="fa-solid fa-check"></i> Creating interfaith dialogue through shared spaces</li>
            </ul>
        </div>
        
        <div class="heritage-image">
            <img src="<%=request.getContextPath()%>/views/images/chriss.jpg" alt="India's diverse religious architecture">
        </div>
    </div>
</section>

<!-- TRAVELERS SECTION -->
<section class="travelers-section">
    <div class="container travelers-grid">
        <div>
            <div class="traveler-feature">
                <h3>For Spiritual Travelers</h3>
                <p>Whether you're on a traditional pilgrimage or a personal spiritual journey, we provide accurate information, cultural context, and practical guidance to make your experience meaningful.</p>
            </div>
            
            <div class="traveler-feature">
                <h3>For Tour Operators</h3>
                <p>We partner with ethical tour companies to create pilgrimage experiences that respect local traditions while providing comfortable access to sacred sites across religions.</p>
            </div>
            
            <div class="traveler-feature">
                <h3>For Academic Research</h3>
                <p>Our database serves scholars studying comparative religion, sacred architecture, pilgrimage patterns, and interfaith relations across cultures.</p>
            </div>
        </div>
        
        <div class="traveler-image">
            <img src="<%=request.getContextPath()%>/views/images/shiva2.jpg" alt="Travelers at a sacred site">
        </div>
    </div>
</section>

<!-- TEAM SECTION -->
<section class="team-section">
    <div class="container">
        <h2 class="section-title">Our Diverse Team</h2>
        <div class="team-grid">
            <div class="team-card">
                <div class="team-image">
                    <img src="<%=request.getContextPath()%>/views/images/team1.jpg" alt="Dr. Aravind Sharma">
                </div>
                <div class="team-info">
                    <h3>Dr. Aravind Sharma</h3>
                    <p>Founder & Historian</p>
                    <p class="description">Former professor of comparative religion with 25 years documenting sacred sites across Asia.</p>
                </div>
            </div>
            
            <div class="team-card">
                <div class="team-image">
                    <img src="<%=request.getContextPath()%>/views/images/team2.jpg" alt="Maria Fernandez">
                </div>
                <div class="team-info">
                    <h3>Maria Fernandez</h3>
                    <p>Travel Director</p>
                    <p class="description">Created pilgrimage experiences in 15 countries with focus on cultural sensitivity and accessibility.</p>
                </div>
            </div>
            
            <div class="team-card">
                <div class="team-image">
                    <img src="<%=request.getContextPath()%>/views/images/team5.jpg" alt="Kabir Singh">
                </div>
                <div class="team-info">
                    <h3>Ayaan Khan</h3>
                    <p>Community Lead</p>
                    <p class="description">Builds relationships with religious communities and ensures authentic representation of all faiths.</p>
                </div>
            </div>
            
            <div class="team-card">
                <div class="team-image">
                    <img src="<%=request.getContextPath()%>/views/images/team4.jpg" alt="Sofia Chen">
                </div>
                <div class="team-info">
                    <h3>Sofia Chen</h3>
                    <p>Technology Head</p>
                    <p class="description">Develops our platform to make spiritual heritage accessible through innovative digital solutions.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- CTA SECTION -->
<section class="cta-section">
    <div class="cta-content">
        <h2>Join Our Movement of Unity</h2>
        <p>Whether you're planning a pilgrimage, organizing interfaith tours, or simply want to learn about the world's sacred spaces, you have a home with us. Together, we can build understanding through shared spiritual heritage.</p>
        <a href="<%=request.getContextPath()%>/contactus" class="cta-button">Start Your Journey With Us</a>
    </div>
</section>

<!-- FOOTER -->
<%@ include file="includes/footer.jsp" %>

</body>
</html>