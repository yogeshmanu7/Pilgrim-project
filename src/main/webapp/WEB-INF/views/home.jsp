<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pilgrimage Connect - Explore Divine Destinations</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #3a6ea5;
            --primary-dark: #2a4d7a;
            --primary-light: #5a8bc5;
            --secondary: #e76f51;
            --secondary-dark: #d45a3c;
            --accent: #f4a261;
            --light: #f8f9fa;
            --dark: #212529;
            --gray: #6c757d;
            --light-gray: #e9ecef;
            --success: #2a9d8f;
            --card-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            --card-shadow-hover: 0 8px 24px rgba(0, 0, 0, 0.12);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html, body {
            min-height: 100%;
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa;
            color: var(--dark);
            line-height: 1.6;
        }

        /* Header */
        header {
            background-color:yellow;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.2rem 0;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            text-decoration: none;
        }

        .logo i {
            font-size: 2.2rem;
            color: var(--primary);
        }

        .logo h1 {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--dark);
        }

        .logo span {
            color: var(--secondary);
        }

        nav ul {
            display: flex;
            list-style: none;
            gap: 1.5rem;
        }

        nav ul li {
            position: relative;
        }

        nav ul li a {
            color: var(--dark);
            text-decoration: none;
            font-weight: 500;
            padding: 0.5rem 0.8rem;
            border-radius: 4px;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 0.4rem;
            font-size: 0.95rem;
        }

        nav ul li a:hover {
            color: var(--primary);
            background-color: var(--light-gray);
        }

        nav ul li.active a {
            color: var(--primary);
            background-color: rgba(58, 110, 165, 0.1);
        }

        .dropdown {
            position: absolute;
            top: 100%;
            left: 0;
            min-width: 220px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
            opacity: 0;
            visibility: hidden;
            transform: translateY(10px);
            transition: var(--transition);
            z-index: 100;
        }

        nav ul li:hover .dropdown {
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }

        .dropdown a {
            display: block;
            padding: 0.8rem 1.2rem;
            border-bottom: 1px solid var(--light-gray);
            color: var(--dark) !important;
            background: none !important;
        }

        .dropdown a:hover {
            background-color: rgba(58, 110, 165, 0.08) !important;
            color: var(--primary) !important;
        }

        .dropdown a:last-child {
            border-bottom: none;
        }

        .auth-buttons {
            display: flex;
            gap: 0.8rem;
        }

        .btn {
            padding: 0.6rem 1.5rem;
            border-radius: 4px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            border: none;
            font-size: 0.95rem;
        }

        .btn-login {
            background: transparent;
            color: var(--primary);
            border: 1px solid var(--primary);
        }

        .btn-login:hover {
            background: var(--primary);
            color: white;
        }

        .btn-register {
            background: var(--primary);
            color: white;
        }

        .btn-register:hover {
            background: var(--primary-dark);
        }

        /* Hero Section */
        .hero {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            padding: 5rem 0;
            text-align: center;
        }

        .hero h2 {
            font-size: 2.8rem;
            margin-bottom: 1.2rem;
            font-weight: 700;
            line-height: 1.2;
        }

        .hero p {
            font-size: 1.2rem;
            max-width: 700px;
            margin: 0 auto 2rem;
            opacity: 0.9;
        }

        .btn-hero {
            display: inline-block;
            padding: 0.9rem 2.2rem;
            background: var(--secondary);
            color: white;
            border-radius: 4px;
            font-weight: 600;
            text-decoration: none;
            transition: var(--transition);
            border: none;
            font-size: 1.05rem;
            cursor: pointer;
        }

        .btn-hero:hover {
            background: var(--secondary-dark);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        /* Features Section */
        .features {
            padding: 5rem 0;
        }

        .section-title {
            text-align: center;
            margin-bottom: 3rem;
        }

        .section-title h2 {
            font-size: 2.2rem;
            color: var(--dark);
            margin-bottom: 0.8rem;
            font-weight: 700;
        }

        .section-title p {
            color: var(--gray);
            max-width: 700px;
            margin: 0 auto;
            font-size: 1.1rem;
        }

        .cards-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
        }

        .card {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: var(--card-shadow);
            transition: var(--transition);
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow-hover);
        }

        .card-img {
            height: 180px;
            overflow: hidden;
        }

        .card-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: var(--transition);
        }

        .card:hover .card-img img {
            transform: scale(1.05);
        }

        .card-content {
            padding: 1.5rem;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .card-icon {
            width: 50px;
            height: 50px;
            background: var(--primary);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
            margin-bottom: 1rem;
        }

        .card-content h3 {
            font-size: 1.4rem;
            margin-bottom: 0.8rem;
            color: var(--dark);
            font-weight: 600;
        }

        .card-details {
            background: rgba(58, 110, 165, 0.08);
            padding: 0.8rem;
            border-radius: 6px;
            margin-bottom: 1rem;
            color: var(--primary-dark);
            font-size: 0.95rem;
        }

        .card-content ul {
            margin: 0.5rem 0 1rem 1.2rem;
            color: var(--gray);
        }

        .card-content ul li {
            margin-bottom: 0.4rem;
            font-size: 0.95rem;
        }

        .card-content p {
            color: var(--gray);
            margin-bottom: 1.5rem;
            flex-grow: 1;
        }

        .btn-card {
            background: var(--primary);
            color: white;
            border: none;
            padding: 0.7rem 1.2rem;
            border-radius: 4px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            align-self: flex-start;
        }

        .btn-card:hover {
            background: var(--primary-dark);
        }

        /* AI Chat Section */
        .ai-chat-section {
            padding: 4rem 0;
            background: var(--light);
        }

        .ai-chat-wrapper {
            max-width: 700px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: var(--card-shadow);
            padding: 2rem;
        }

        .ai-chat-header {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            margin-bottom: 1rem;
        }

        .ai-chat-header i {
            font-size: 1.8rem;
            color: var(--primary);
        }

        .ai-chat-header h2 {
            font-size: 1.6rem;
            color: var(--dark);
        }

        .ai-chat-subtitle {
            margin-bottom: 1.5rem;
            color: var(--gray);
        }

        #chat {
            border: 1px solid var(--light-gray);
            padding: 1rem;
            height: 300px;
            overflow-y: auto;
            border-radius: 8px;
            background: #fafafa;
            margin-bottom: 1rem;
        }

        .msg {
            margin: 0.8rem 0;
            font-size: 0.95rem;
        }

        .user {
            font-weight: 600;
            color: var(--primary);
        }

        .bot {
            color: var(--dark);
        }

        #inputRow {
            display: flex;
            gap: 0.8rem;
        }

        #msgInput {
            flex: 1;
            padding: 0.8rem 1rem;
            border-radius: 4px;
            border: 1px solid var(--light-gray);
            font-size: 0.95rem;
        }

        #sendBtn {
            padding: 0.8rem 1.5rem;
            border-radius: 4px;
            border: none;
            background: var(--primary);
            color: white;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
        }

        #sendBtn:hover {
            background: var(--primary-dark);
        }

        /* Footer */
        footer {
            background: var(--dark);
            color: white;
            padding: 4rem 0 1.5rem;
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .footer-column h3 {
            font-size: 1.2rem;
            margin-bottom: 1.2rem;
            color: white;
            font-weight: 600;
        }

        .footer-column p {
            color: #adb5bd;
            margin-bottom: 1.2rem;
            line-height: 1.6;
        }

        .footer-links {
            list-style: none;
        }

        .footer-links li {
            margin-bottom: 0.7rem;
        }

        .footer-links a {
            color: #adb5bd;
            text-decoration: none;
            transition: var(--transition);
        }

        .footer-links a:hover {
            color: white;
        }

        .social-links {
            display: flex;
            gap: 0.8rem;
            margin-top: 1.2rem;
        }

        .social-links a {
            width: 36px;
            height: 36px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: var(--transition);
        }

        .social-links a:hover {
            background: var(--primary);
            transform: translateY(-2px);
        }

        .footer-bottom {
            text-align: center;
            padding-top: 1.5rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            color: #adb5bd;
            font-size: 0.9rem;
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .header-content {
                flex-direction: column;
                gap: 1rem;
            }
            
            nav ul {
                flex-wrap: wrap;
                justify-content: center;
            }
            
            .hero h2 {
                font-size: 2.2rem;
            }
        }

        @media (max-width: 768px) {
            .cards-container {
                grid-template-columns: 1fr;
            }
            
            .hero {
                padding: 3rem 0;
            }
            
            .hero h2 {
                font-size: 1.8rem;
            }
            
            .hero p {
                font-size: 1rem;
            }
            
            .section-title h2 {
                font-size: 1.8rem;
            }
            
            .features {
                padding: 3rem 0;
            }
            
            .ai-chat-section {
                padding: 3rem 0;
            }
        }

        @media (max-width: 576px) {
            nav ul {
                flex-direction: column;
                align-items: center;
                gap: 0.5rem;
            }
            
            .auth-buttons {
                width: 100%;
                justify-content: center;
            }
            
            .btn {
                padding: 0.6rem 1rem;
            }
            
            .ai-chat-wrapper {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <div class="container">
            <div class="header-content">
                <div class="logo">
                    <i class="fas fa-hands-praying"></i>
                    <h1>Pilgrim<span>Connect</span></h1>
                </div>
                <nav>
                    <ul>
                        <li><a href="#"><i class="fas fa-home"></i> Home</a></li>
                        <li>
                            <a href="#"><i class="fas fa-temple"></i> Temples <i class="fas fa-chevron-down"></i></a>
                            <div class="dropdown">
                                <a href="#">Tirupati Balaji</a>
                                <a href="#">Vaishno Devi</a>
                                <a href="#">Golden Temple</a>
                                <a href="#">Sabarimala</a>
                                <a href="#">Jagannath Puri</a>
                                <a href="#">Kashi Vishwanath</a>
                                <a href="#">Kedarnath</a>
                                <a href="#">Amarnath</a>
                                <a href="#">Meenakshi Amman</a>
                            </div>
                        </li>
                        <li>
                            <a href="#"><i class="fas fa-hiking"></i> Trekking <i class="fas fa-chevron-down"></i></a>
                            <div class="dropdown">
                                <a href="#">Vaishno Devi Trek</a>
                                <a href="#">Kedarnath Yatra</a>
                                <a href="#">Amarnath Cave Trek</a>
                                <a href="#">Hemkund Sahib</a>
                                <a href="#">Tungnath Trek</a>
                            </div>
                        </li>
                        <li>
                            <a href="#"><i class="fas fa-praying-hands"></i> Events <i class="fas fa-chevron-down"></i></a>
                            <div class="dropdown">
                                <a href="#">Maha Shivratri</a>
                                <a href="#">Navratri</a>
                                <a href="#">Ganesh Chaturthi</a>
                                <a href="#">Diwali Puja</a>
                                <a href="#">Satyanarayan Katha</a>
                                <a href="#">Rudrabhishek</a>
                                <a href="#">Kartika Purnima</a>
                            </div>
                        </li>
                        <li>
                            <a href="#"><i class="fas fa-user-alt"></i> Astrologer & Pandit <i class="fas fa-chevron-down"></i></a>
                            <div class="dropdown">
                                <a href="#">Book a Pandit</a>
                                <a href="#">Horoscope Reading</a>
                                <a href="#">Vastu Consultation</a>
                                <a href="#">Muhurat Selection</a>
                                <a href="#">Gemstone Advice</a>
                                <a href="#">Kundli Matching</a>
                            </div>
                        </li>
                        <li><a href="#"><i class="fas fa-info-circle"></i> About Us</a></li>
                        <li><a href="#"><i class="fas fa-phone-alt"></i> Contact</a></li>
                    </ul>
                </nav>
                
            </div>
        </div>
    </header>

    <!-- Hero Section -->
    <section class="hero">
        <div class="container">
            <h2>Embark on your Spiritual & Adventure Journey</h2>
            <p>Discover ancient temples, scenic treks, book sacred rituals, and attend grand religious events. PilgrimConnect guides you to a meaningful and unforgettable pilgrimage experience.</p>
            <button class="btn-hero">Start Your Journey</button>
        </div>
    </section>

    <!-- Features Section (Cards) -->
    <section class="features">
        <div class="container">
            <div class="section-title">
                <h2>What You Can Explore</h2>
                <p>From the historical grandeur of ancient temples to breathtaking Himalayan treks and vibrant spiritual events, PilgrimConnect brings your spiritual aspirations into reality.</p>
            </div>
            <div class="cards-container">
                <!-- Temple Guide Card -->
                <div class="card">
                    <div class="card-img">
                        <img src="https://images.unsplash.com/photo-1549272090-c89e8e4794b3?auto=format&fit=crop&w=900&q=80" alt="Temple">
                    </div>
                    <div class="card-content">
                        <div class="card-icon"><i class="fas fa-temple"></i></div>
                        <h3>Historical Temples</h3>
                        <div class="card-details">
                            Ancient shrines, sacred legends, and architectural marvels.
                        </div>
                        <ul>
                            <li>Tirupati Balaji: World's richest and most-visited Hindu temple.</li>
                            <li>Kashi Vishwanath: Among India's 12 Jyotirlingas, Varanasi.</li>
                            <li>Golden Temple: Sikhism's holiest shrine, Amritsar.</li>
                            <li>Meenakshi Amman: Dravidian beauty, Madurai.</li>
                        </ul>
                        <p>
                            Explore temple history, legends, rituals, best darshan timings, and cultural significance with personalized guides and virtual tours.
                        </p>
                        <button class="btn-card">Find Temples</button>
                    </div>
                </div>

                <!-- Trekking Card -->
                <div class="card">
                    <div class="card-img">
                        <img src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=900&q=80" alt="Trekking">
                    </div>
                    <div class="card-content">
                        <div class="card-icon"><i class="fas fa-hiking"></i></div>
                        <h3>Pilgrimage Trekking</h3>
                        <div class="card-details">
                            Experience spirituality amid Himalayan landscapes.
                        </div>
                        <ul>
                            <li>Kedarnath & Tungnath: Himalayan treks to sacred shrines.</li>
                            <li>Vaishno Devi Yatra: Scenic journey to the cave temple.</li>
                            <li>Amarnath Cave: Snowy trek, divine adventure.</li>
                        </ul>
                        <p>
                            Plan treks with guides, route details, difficulty levels, must-carry items, and weather alerts for a hassle-free journey.
                        </p>
                        <button class="btn-card">Discover Treks</button>
                    </div>
                </div>

                <!-- Puja Booking Card -->
                <div class="card">
                    <div class="card-img">
                        <img src="https://images.unsplash.com/photo-1506784365847-bbad939e9335?auto=format&fit=crop&w=900&q=80" alt="Puja Booking">
                    </div>
                    <div class="card-content">
                        <div class="card-icon"><i class="fas fa-praying-hands"></i></div>
                        <h3>Book Sacred Pujas</h3>
                        <div class="card-details">
                            Personalized rituals at your chosen temple or online.
                        </div>
                        <ul>
                            <li>Select puja, temple, and experienced Pandits.</li>
                            <li>Digital e-Puja & livestream options available.</li>
                            <li>Receive genuine Prasad & blessings at home.</li>
                        </ul>
                        <p>
                            Seamless booking for major festivals (Diwali, Navratri, Shivratri), special occasions, and daily rituals.
                        </p>
                        <button class="btn-card">Book Puja</button>
                    </div>
                </div>

                <!-- Event Participation Card -->
                <div class="card">
                    <div class="card-img">
                        <img src="https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=900&q=80" alt="Events">
                    </div>
                    <div class="card-content">
                        <div class="card-icon"><i class="fas fa-calendar-star"></i></div>
                        <h3>Festivals & Events</h3>
                        <div class="card-details">
                            Spiritual gatherings, kirtans, aartis & yatras.
                        </div>
                        <ul>
                            <li>Check upcoming festival dates and highlights.</li>
                            <li>Join major yatras, community seva, and processions.</li>
                            <li>Exclusive access to digital event registrations.</li>
                        </ul>
                        <p>Be part of inspiring spiritual energy with our event notifications and festival calendars.</p>
                        <button class="btn-card">See Events</button>
                    </div>
                </div>

                <!-- Astrologers Card -->
                <div class="card">
                    <div class="card-img">
                        <img src="https://images.unsplash.com/photo-1531750960039-dc7f05c99b1b?auto=format&fit=crop&w=900&q=80" alt="Astrologer">
                    </div>
                    <div class="card-content">
                        <div class="card-icon"><i class="fas fa-user-astronaut"></i></div>
                        <h3>Astrology & Guidance</h3>
                        <div class="card-details">
                            Ancient Vedic wisdom for modern lives.
                        </div>
                        <ul>
                            <li>Consult certified Pandits and Astrologers.</li>
                            <li>Kundli matching, Vastu, Gemstone, Muhurat.</li>
                            <li>Get daily, weekly, and annual horoscope.</li>
                        </ul>
                        <p>
                            Book personalized guidance sessions for peace and prosperity.
                        </p>
                        <button class="btn-card">Consult Now</button>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- AI Chat Bot Section -->
    <section class="ai-chat-section">
        <div class="container">
            <div class="ai-chat-wrapper">
                <div class="ai-chat-header">
                    <i class="fas fa-robot"></i>
                    <h2>PilgrimConnect AI Guide</h2>
                </div>
                <p class="ai-chat-subtitle">
                    Ask anything about temples, treks, pujas, or planning your next yatra. Our AI guide will assist you.
                </p>
                <div id="chat"></div>
                <div id="inputRow">
                    <input id="msgInput" type="text" placeholder="Type your question about your pilgrimage..." />
                    <button id="sendBtn" onclick="sendMessage()">Send</button>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="footer-content">
                <div class="footer-column">
                    <h3>About PilgrimConnect</h3>
                    <p>PilgrimConnect is dedicated to connecting seekers with India's spiritual heritage – temples, treks, rituals, and wisdom for every pilgrim.</p>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>
                <div class="footer-column">
                    <h3>Quick Links</h3>
                    <ul class="footer-links">
                        <li><a href="#">Home</a></li>
                        <li><a href="#">Temples</a></li>
                        <li><a href="#">Puja Events</a></li>
                        <li><a href="#">Astrologers</a></li>
                        <li><a href="#">Pandits</a></li>
                        <li><a href="#">Trekking</a></li>
                        <li><a href="#">About Us</a></li>
                    </ul>
                </div>
                <div class="footer-column">
                    <h3>Popular Destinations</h3>
                    <ul class="footer-links">
                        <li><a href="#">Tirupati Balaji</a></li>
                        <li><a href="#">Vaishno Devi</a></li>
                        <li><a href="#">Gold Temple</a></li>
                        <li><a href="#">Kedarnath Trek</a></li>
                        <li><a href="#">Jagannath Puri</a></li>
                        <li><a href="#">Amarnath Yatra</a></li>
                    </ul>
                </div>
                <div class="footer-column">
                    <h3>Contact Us</h3>
                    <ul class="footer-links">
                        <li><i class="fas fa-map-marker-alt"></i> 123 Spiritual Street, Varanasi, India</li>
                        <li><i class="fas fa-phone"></i> +91 98765 43210</li>
                        <li><i class="fas fa-envelope"></i> info@pilgrimconnect.com</li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2023-2025 PilgrimConnect. All Rights Reserved. | Designed with <i class="fas fa-heart" style="color: #e74c3c;"></i> for Spiritual Journeys</p>
            </div>
        </div>
    </footer>

    <script>
        // Script for dropdown menu
        document.addEventListener('DOMContentLoaded', function() {
            const dropdowns = document.querySelectorAll('nav ul li');
            dropdowns.forEach(item => {
                item.addEventListener('mouseenter', function() {
                    this.classList.add('active');
                });
                item.addEventListener('mouseleave', function() {
                    this.classList.remove('active');
                });
            });

            // Allow Enter key to send message
            const msgInput = document.getElementById('msgInput');
            if (msgInput) {
                msgInput.addEventListener('keydown', function(e) {
                    if (e.key === 'Enter') {
                        e.preventDefault();
                        sendMessage();
                    }
                });
            }
        });

        // AI Chat Bot JS
        async function sendMessage() {
            const input = document.getElementById('msgInput');
            const text = input.value.trim();
            if (!text) return;

            addMessage('You', text, 'user');
            input.value = '';

            try {
                const res = await fetch('/api/chat', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ message: text })
                });

                const data = await res.json();
                console.log('API response:', data);  // 👈 debug

                const reply = data && data.reply 
                    ? data.reply 
                    : 'No reply field in server response.';

                addMessage('Bot', reply, 'bot');

            } catch (e) {
                console.error('Error calling /api/chat:', e);
                addMessage('Error', 'Something went wrong.', 'bot');
            }
        }

        function addMessage(sender, text, cssClass) {
            const chat = document.getElementById('chat');
            const div = document.createElement('div');
            div.className = 'msg ' + cssClass;
            div.textContent = sender + ': ' + text;
            chat.appendChild(div);
            chat.scrollTop = chat.scrollHeight;
        }
    </script>
</body>
</html>