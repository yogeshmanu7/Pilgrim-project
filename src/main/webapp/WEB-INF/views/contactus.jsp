<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Contact Us | Pilgrim Project</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Contact Pilgrim Project for all your pilgrimage needs. Get in touch for travel arrangements, spiritual guidance, and more.">

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

/* ===== CONTACT HERO ===== */
.contact-hero {
    background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)),
                url('https://images.unsplash.com/photo-1548013146-72479768bada?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80')
                center center / cover no-repeat;
    min-height: 100vh;        /* FULL SCREEN */
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: center;
    color: white;
    position: relative;
}

.contact-hero-content {
    max-width: 800px;
    padding: 0 20px;
    position: relative;
    z-index: 2;
}

.contact-hero h1 {
    font-family: 'Playfair Display', serif;
    font-size: 3.5rem;
    margin-bottom: 20px;
    font-weight: 800;
    text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.5);
}

.contact-hero p {
    font-size: 1.2rem;
    opacity: 0.95;
    max-width: 700px;
    margin: 0 auto;
    text-shadow: 1px 1px 5px rgba(0, 0, 0, 0.5);
}

/* ===== CONTACT GRID ===== */
.contact-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 30px;
    margin-bottom: 80px;
}

.contact-card {
    background: white;
    border-radius: 20px;
    padding: 40px 30px;
    text-align: center;
    box-shadow: 0 15px 40px rgba(0, 0, 0, 0.08);
    transition: all 0.3s ease;
    border: 2px solid transparent;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.contact-card:hover {
    transform: translateY(-10px);
    box-shadow: 0 25px 60px rgba(0, 0, 0, 0.15);
    border-color: #d4af37;
}

.contact-icon {
    width: 80px;
    height: 80px;
    background: linear-gradient(135deg, #d4af37, #8b4513);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 25px;
    color: white;
    font-size: 2.2rem;
}

.contact-card h3 {
    font-family: 'Playfair Display', serif;
    font-size: 1.6rem;
    color: #2c3e50;
    margin-bottom: 15px;
}

.contact-card p {
    color: #666;
    line-height: 1.7;
    margin-bottom: 20px;
    flex-grow: 1;
}

.contact-details {
    margin-top: 15px;
    width: 100%;
}

.contact-details a {
    display: block;
    color: #555;
    text-decoration: none;
    margin-bottom: 10px;
    transition: color 0.3s ease;
    font-weight: 500;
}

.contact-details a:hover {
    color: #d4af37;
}

.contact-details i {
    margin-right: 10px;
    color: #d4af37;
}

.contact-button {
    display: inline-block;
    background: #d4af37;
    color: #000;
    padding: 12px 30px;
    border-radius: 50px;
    text-decoration: none;
    font-weight: 600;
    font-size: 1rem;
    transition: all 0.3s ease;
    border: 2px solid #d4af37;
    margin-top: 15px;
}

.contact-button:hover {
    background: transparent;
    color: #d4af37;
    transform: translateY(-3px);
}

/* ===== CONTACT FORM ===== */
.contact-form-section {
    background: white;
    border-radius: 30px;
    padding: 60px;
    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
    margin-bottom: 80px;
    position: relative;
    overflow: hidden;
}

.contact-form-section::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 5px;
    background: linear-gradient(to right, #d4af37, #8b4513);
}

.form-header {
    text-align: center;
    margin-bottom: 40px;
}

.form-header h2 {
    font-family: 'Playfair Display', serif;
    font-size: 2.5rem;
    color: #2c3e50;
    margin-bottom: 10px;
}

.form-header p {
    color: #666;
    font-size: 1.1rem;
    max-width: 600px;
    margin: 0 auto;
}

.contact-form {
    max-width: 800px;
    margin: 0 auto;
}

.form-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 25px;
    margin-bottom: 25px;
}

.form-group {
    margin-bottom: 25px;
}

.form-group label {
    display: block;
    margin-bottom: 10px;
    color: #2c3e50;
    font-weight: 600;
    font-size: 1rem;
}

.form-group input,
.form-group select,
.form-group textarea {
    width: 100%;
    padding: 15px 20px;
    border: 2px solid #eee;
    border-radius: 12px;
    font-family: 'Inter', sans-serif;
    font-size: 1rem;
    transition: all 0.3s ease;
    background: #f9f9f9;
}

.form-group input:focus,
.form-group select:focus,
.form-group textarea:focus {
    outline: none;
    border-color: #d4af37;
    background: white;
    box-shadow: 0 5px 20px rgba(212, 175, 55, 0.1);
}

.form-group textarea {
    min-height: 180px;
    resize: vertical;
}

.submit-button {
    background: linear-gradient(135deg, #d4af37, #c19b2e);
    color: #000;
    padding: 18px 45px;
    border-radius: 50px;
    border: none;
    font-weight: 600;
    font-size: 1.1rem;
    cursor: pointer;
    transition: all 0.3s ease;
    display: block;
    margin: 40px auto 0;
    width: 200px;
    box-shadow: 0 5px 20px rgba(212, 175, 55, 0.3);
}

.submit-button:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 25px rgba(212, 175, 55, 0.4);
    background: linear-gradient(135deg, #c19b2e, #d4af37);
}

/* ===== FAQ SECTION ===== */
.faq-section {
    background: #f7f3e9;
    border-radius: 30px;
    padding: 60px;
    margin-bottom: 80px;
}

.section-title {
    text-align: center;
    font-family: 'Playfair Display', serif;
    font-size: 2.5rem;
    color: #2c3e50;
    margin-bottom: 50px;
}

.faq-container {
    max-width: 800px;
    margin: 0 auto;
}

.faq-item {
    background: white;
    border-radius: 15px;
    margin-bottom: 20px;
    overflow: hidden;
    box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
    border: 1px solid #eee;
}

.faq-question {
    padding: 25px 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    cursor: pointer;
    transition: all 0.3s ease;
}

.faq-question:hover {
    background: #f9f9f9;
}

.faq-question h3 {
    font-size: 1.2rem;
    color: #2c3e50;
    font-weight: 600;
}

.faq-toggle {
    color: #d4af37;
    font-size: 1.2rem;
    transition: transform 0.3s ease;
}

.faq-answer {
    padding: 0 30px;
    max-height: 0;
    overflow: hidden;
    transition: all 0.3s ease;
}

.faq-answer p {
    color: #666;
    line-height: 1.7;
    padding-bottom: 25px;
}

.faq-item.active .faq-answer {
    max-height: 300px;
}

.faq-item.active .faq-toggle {
    transform: rotate(45deg);
}

/* ===== MAP SECTION ===== */
.map-section {
    margin-bottom: 80px;
    border-radius: 30px;
    overflow: hidden;
    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
}

.map-container {
    position: relative;
    height: 500px;
    background: #f0f0f0;
}

.map-placeholder {
    width: 100%;
    height: 100%;
    background: linear-gradient(rgba(0, 0, 0, 0.1), rgba(0, 0, 0, 0.1)),
                url('https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80') center center / cover no-repeat;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    color: white;
    text-align: center;
    padding: 20px;
}

.map-placeholder i {
    font-size: 4rem;
    margin-bottom: 20px;
    color: #d4af37;
    text-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
}

.map-placeholder h3 {
    font-family: 'Playfair Display', serif;
    font-size: 2rem;
    margin-bottom: 10px;
    text-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
}

.map-placeholder p {
    font-size: 1.1rem;
    max-width: 600px;
    opacity: 0.9;
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
@media (max-width: 992px) {
    .contact-hero h1,
    .form-header h2,
    .section-title {
        font-size: 2.3rem;
    }
    
    .form-row {
        grid-template-columns: 1fr;
        gap: 0;
    }
    
    .contact-form-section,
    .faq-section {
        padding: 40px 30px;
    }
}

@media (max-width: 768px) {
    nav {
        display: none;
    }
    
    .contact-hero {
        height: 50vh;
    }
    
    .contact-hero h1 {
        font-size: 2.2rem;
    }
    
    .contact-grid {
        grid-template-columns: 1fr;
    }
    
    .map-placeholder h3 {
        font-size: 1.5rem;
    }
    
    .map-placeholder i {
        font-size: 3rem;
    }
}

@media (max-width: 480px) {
    .header-wrap {
        padding: 15px 20px;
    }
    
    .container {
        padding: 0 20px;
    }
    
    .contact-hero h1 {
        font-size: 1.8rem;
    }
    
    .contact-form-section,
    .faq-section {
        padding: 30px 20px;
    }
    
    .contact-icon {
        width: 70px;
        height: 70px;
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
            <a href="<%=request.getContextPath()%>/aboutus">About Us</a>
            <a href="<%=request.getContextPath()%>/services">Services</a>
            <a href="<%=request.getContextPath()%>/contactus" class="active">Contact Us</a>
        </nav>
    </div>
</header>

<!-- CONTACT HERO -->
<section class="contact-hero">
    <div class="contact-hero-content">
        <h1>Connect With Us</h1>
        <p>We're here to help you plan your sacred journey. Reach out to us for any questions about our pilgrimage services.</p>
    </div>
</section>

<!-- CONTACT GRID -->
<section class="container">
    <div class="contact-grid">
        
        <!-- Phone Contact -->
        <div class="contact-card">
            <div class="contact-icon">
                <i class="fa-solid fa-phone"></i>
            </div>
            <h3>Call Us</h3>
            <p>Speak directly with our pilgrimage experts for immediate assistance and personalized guidance.</p>
            <div class="contact-details">
                <a href="tel:+911800123456"><i class="fa-solid fa-phone"></i> Toll-Free: 1800-123-456</a>
                <a href="tel:+919876543210"><i class="fa-solid fa-mobile"></i> Mobile: +91 98765 43210</a>
            </div>
            <a href="tel:+911800123456" class="contact-button">Call Now</a>
        </div>
        
        <!-- Email Contact -->
        <div class="contact-card">
            <div class="contact-icon">
                <i class="fa-solid fa-envelope"></i>
            </div>
            <h3>Email Us</h3>
            <p>Send us your queries, and our team will respond within 24 hours with detailed information.</p>
            <div class="contact-details">
                <a href="mailto:info@pilgrimproject.com"><i class="fa-solid fa-envelope"></i> info@pilgrimproject.com</a>
                <a href="mailto:support@pilgrimproject.com"><i class="fa-solid fa-headset"></i> support@pilgrimproject.com</a>
                <a href="mailto:bookings@pilgrimproject.com"><i class="fa-solid fa-calendar-check"></i> bookings@pilgrimproject.com</a>
            </div>
            <a href="mailto:info@pilgrimproject.com" class="contact-button">Send Email</a>
        </div>
        
        <!-- Visit Us -->
        <div class="contact-card">
            <div class="contact-icon">
                <i class="fa-solid fa-location-dot"></i>
            </div>
            <h3>Visit Us</h3>
            <p>Meet our team in person at our headquarters for comprehensive pilgrimage planning.</p>
            <div class="contact-details">
                <p style="color: #555; line-height: 1.6; text-align: center;">
                    <i class="fa-solid fa-building"></i> Pilgrim Project Headquarters<br>
                    123 Sacred Street, Temple Road<br>
                    Varanasi, Uttar Pradesh 221001<br>
                    India
                </p>
            </div>
            <a href="#map-section" class="contact-button">View Location</a>
        </div>
        
    </div>
</section>

<!-- CONTACT FORM -->
<section class="container">
    <div class="contact-form-section">
        <div class="form-header">
            <h2>Send Us a Message</h2>
            <p>Fill out the form below, and our pilgrimage specialists will get back to you with personalized assistance.</p>
        </div>
        
        <form class="contact-form" id="contactForm" onsubmit="return submitForm(event)">
            <div class="form-row">
                <div class="form-group">
                    <label for="fullName">Full Name *</label>
                    <input type="text" id="fullName" name="fullName" placeholder="Enter your full name" required>
                </div>
                
                <div class="form-group">
                    <label for="email">Email Address *</label>
                    <input type="email" id="email" name="email" placeholder="Enter your email address" required>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="phone">Phone Number *</label>
                    <input type="tel" id="phone" name="phone" placeholder="Enter your phone number" required>
                </div>
                
                <div class="form-group">
                    <label for="country">Country</label>
                    <input type="text" id="country" name="country" placeholder="Your country">
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="service">Service Interested In</label>
                    <select id="service" name="service">
                        <option value="">Select a service</option>
                        <option value="travel">Pilgrimage Travel</option>
                        <option value="guidance">Spiritual Guidance</option>
                        <option value="ritual-items">Ritual Items</option>
                        <option value="prasad">Temple Prasad</option>
                        <option value="information">Sacred Information</option>
                        <option value="multiple">Multiple Services</option>
                        <option value="other">Other</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="pilgrimage">Pilgrimage Destination</label>
                    <input type="text" id="pilgrimage" name="pilgrimage" placeholder="e.g., Varanasi, Amarnath, Mecca, etc.">
                </div>
            </div>
            
            <div class="form-group">
                <label for="message">Your Message *</label>
                <textarea id="message" name="message" placeholder="Please describe your pilgrimage needs, questions, or requirements..." required></textarea>
            </div>
            
            <button type="submit" class="submit-button">Send Message</button>
        </form>
    </div>
</section>

<!-- FAQ SECTION -->
<section class="container">
    <div class="faq-section">
        <h2 class="section-title">Frequently Asked Questions</h2>
        
        <div class="faq-container">
            
            <div class="faq-item" onclick="toggleFAQ(this)">
                <div class="faq-question">
                    <h3>How quickly will I receive a response to my inquiry?</h3>
                    <span class="faq-toggle">+</span>
                </div>
                <div class="faq-answer">
                    <p>We respond to all inquiries within 24 hours on business days. For urgent matters, please call our toll-free number for immediate assistance.</p>
                </div>
            </div>
            
            <div class="faq-item" onclick="toggleFAQ(this)">
                <div class="faq-question">
                    <h3>Do you offer services for all religions?</h3>
                    <span class="faq-toggle">+</span>
                </div>
                <div class="faq-answer">
                    <p>Yes, we provide pilgrimage services for all major religions including Hinduism, Islam, Christianity, Sikhism, Buddhism, and Judaism. Our services are tailored to respect each faith's traditions and requirements.</p>
                </div>
            </div>
            
            <div class="faq-item" onclick="toggleFAQ(this)">
                <div class="faq-question">
                    <h3>Can I book last-minute pilgrimage arrangements?</h3>
                    <span class="faq-toggle">+</span>
                </div>
                <div class="faq-answer">
                    <p>Yes, we offer last-minute booking services, but availability may be limited during peak pilgrimage seasons. We recommend booking at least 2-4 weeks in advance for the best arrangements.</p>
                </div>
            </div>
            
            <div class="faq-item" onclick="toggleFAQ(this)">
                <div class="faq-question">
                    <h3>What are your business hours?</h3>
                    <span class="faq-toggle">+</span>
                </div>
                <div class="faq-answer">
                    <p>Our customer support team is available Monday to Saturday from 9:00 AM to 8:00 PM IST. For emergencies outside these hours, you can call our 24/7 emergency helpline.</p>
                </div>
            </div>
            
            <div class="faq-item" onclick="toggleFAQ(this)">
                <div class="faq-question">
                    <h3>Do you provide international pilgrimage services?</h3>
                    <span class="faq-toggle">+</span>
                </div>
                <div class="faq-answer">
                    <p>Yes, we arrange pilgrimages to international destinations including Mecca, Vatican City, Jerusalem, Bodh Gaya, and other significant religious sites worldwide.</p>
                </div>
            </div>
            
        </div>
    </div>
</section>

<!-- MAP SECTION -->
<section class="container map-section" id="map-section">
    <div class="map-container">
        <div class="map-placeholder">
            <i class="fa-solid fa-map-location-dot"></i>
            <h3>Our Headquarters Location</h3>
            <p>Visit us at our headquarters in Varanasi, the spiritual capital of India, to discuss your pilgrimage needs in person.</p>
            <p style="margin-top: 20px; font-size: 1rem;">
                <strong>Address:</strong> 123 Sacred Street, Temple Road, Varanasi, Uttar Pradesh 221001, India
            </p>
        </div>
        <!-- In a real implementation, you would embed a Google Maps iframe here -->
        <!-- <iframe src="https://www.google.com/maps/embed?pb=..." width="100%" height="500" style="border:0;" allowfullscreen="" loading="lazy"></iframe> -->
    </div>
</section>

<!-- FOOTER -->
    <div class="footer-wrap">
        <div>
            <h4>Pilgrim Project</h4>
            <p>Making pilgrimage accessible, meaningful, and complete for people of all faiths.</p>
            <div style="margin-top: 20px;">
                <a href="#" style="display: inline-block; margin-right: 15px;"><i class="fab fa-facebook"></i></a>
                <a href="#" style="display: inline-block; margin-right: 15px;"><i class="fab fa-twitter"></i></a>
                <a href="#" style="display: inline-block; margin-right: 15px;"><i class="fab fa-instagram"></i></a>
                <a href="#" style="display: inline-block;"><i class="fab fa-youtube"></i></a>
            </div>
        </div>
        
        <div>
            <h4>Our Services</h4>
            <a href="<%=request.getContextPath()%>/services">Pilgrimage Travel</a>
            <a href="<%=request.getContextPath()%>/services">Spiritual Guidance</a>
            <a href="<%=request.getContextPath()%>/services">Spiritual Resources</a>
            <a href="<%=request.getContextPath()%>/services">Temple Prasad</a>
            <a href="<%=request.getContextPath()%>/services">Sacred Information</a>
        </div>
        
        <div>
            <h4>Quick Links</h4>
            <a href="<%=request.getContextPath()%>/">Home</a>
            <a href="<%=request.getContextPath()%>/aboutus">About Us</a>
            <a href="<%=request.getContextPath()%>/services">Services</a>
            <a href="<%=request.getContextPath()%>/contactus">Contact Us</a>
            <a href="<%=request.getContextPath()%>/privacy">Privacy Policy</a>
            <a href="<%=request.getContextPath()%>/terms">Terms & Conditions</a>
        </div>
        
        <div>
            <h4>Contact Info</h4>
            <p><i class="fa-solid fa-phone"></i> 1800-123-456</p>
            <p><i class="fa-solid fa-envelope"></i> info@pilgrimproject.com</p>
            <p><i class="fa-solid fa-location-dot"></i> Varanasi, India</p>
            <p><i class="fa-solid fa-clock"></i> Mon-Sat: 9AM-8PM</p>
        </div>
    </div>
    
    <div class="footer-bottom">
        � 2024 Pilgrim Project. All Rights Reserved. | Serving pilgrims across all faiths
    </div>
</footer>

<%@ include file="includes/footer.jsp" %>

<script>
// Form Submission
function submitForm(event) {
    event.preventDefault();
    
    // Get form values
    const formData = {
        name: document.getElementById('fullName').value,
        email: document.getElementById('email').value,
        phone: document.getElementById('phone').value,
        service: document.getElementById('service').value,
        message: document.getElementById('message').value
    };
    
    // Basic validation
    if (!formData.name || !formData.email || !formData.phone || !formData.message) {
        alert('Please fill in all required fields.');
        return false;
    }
    
    // In a real application, you would send this data to a server
    // For demo purposes, we'll show a success message
    alert('Thank you, ' + formData.name + '! Your message has been sent. We will contact you within 24 hours.');
    
    // Reset form
    document.getElementById('contactForm').reset();
    
    return false;
}

// FAQ Toggle
function toggleFAQ(item) {
    // Close all other FAQs
    const allFAQs = document.querySelectorAll('.faq-item');
    allFAQs.forEach(faq => {
        if (faq !== item) {
            faq.classList.remove('active');
        }
    });
    
    // Toggle current FAQ
    item.classList.toggle('active');
}

// Smooth scrolling for anchor links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function(e) {
        e.preventDefault();
        
        const targetId = this.getAttribute('href');
        if (targetId === '#') return;
        
        const targetElement = document.querySelector(targetId);
        if (targetElement) {
            window.scrollTo({
                top: targetElement.offsetTop - 100,
                behavior: 'smooth'
            });
        }
    });
});

// Form input animation
document.querySelectorAll('.form-group input, .form-group select, .form-group textarea').forEach(input => {
    input.addEventListener('focus', function() {
        this.parentElement.style.transform = 'translateY(-2px)';
    });
    
    input.addEventListener('blur', function() {
        this.parentElement.style.transform = 'translateY(0)';
    });
});

// Initialize with first FAQ open (optional)
document.addEventListener('DOMContentLoaded', function() {
    // Open first FAQ by default
    const firstFAQ = document.querySelector('.faq-item');
    if (firstFAQ) {
        firstFAQ.classList.add('active');
    }
});
</script>

</body>
</html>