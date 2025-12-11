<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Our Services | Pilgrim Project</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Complete pilgrimage services - Travel arrangements, Pandit bookings, Pooja items, Temple Prasad, and sacred information for all religions.">

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

/* ===== HOW IT WORKS ===== */
.how-it-works {
    padding: 80px 0;
    background: #fff;
    border-radius: 40px;
    margin-bottom: 80px;
}

.steps {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 40px;
    margin-top: 50px;
}

.step {
    text-align: center;
    position: relative;
}

.step-number {
    width: 60px;
    height: 60px;
    background: #d4af37;
    color: #000;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.5rem;
    font-weight: 700;
    margin: 0 auto 25px;
    position: relative;
    z-index: 2;
}

.step:not(:last-child)::after {
    content: '';
    position: absolute;
    top: 30px;
    left: 50%;
    width: 100%;
    height: 2px;
    background: #ddd;
    z-index: 1;
}

.step h3 {
    font-family: 'Playfair Display', serif;
    font-size: 1.5rem;
    color: #2c3e50;
    margin-bottom: 15px;
}

.step p {
    color: #666;
    line-height: 1.7;
}

/* ===== CTA SECTION ===== */
.cta-section {
    padding: 100px 0;
    background: linear-gradient(rgba(0, 0, 0, 0.8), rgba(0, 0, 0, 0.8)),
                url('<%=request.getContextPath()%>/views/images/mus.jpg') center/cover no-repeat;
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
@media (max-width: 992px) {
    .services-hero h1,
    .services-intro h2,
    .section-title,
    .cta-content h2 {
        font-size: 2.3rem;
    }
}

@media (max-width: 768px) {
    nav {
        display: flex;
    }
    
    .services-hero {
        height: 300px;
    }
    
    .services-hero h1 {
        font-size: 2.2rem;
    }
    
    .services-grid-compact {
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 25px;
    }
    
    .religion-tabs {
        flex-direction: column;
        align-items: center;
    }
    
    .religion-tab {
        width: 100%;
        max-width: 300px;
        justify-content: center;
    }
    
    .steps {
        grid-template-columns: 1fr;
        gap: 60px;
    }
    
    .step:not(:last-child)::after {
        top: 100%;
        left: 50%;
        width: 2px;
        height: 60px;
        transform: translateX(-50%);
    }
    
    .services-section-with-bg::before {
        background-attachment: scroll;
    }
    
    .service-card-footer {
        flex-direction: column;
        gap: 15px;
    }
    
    .service-button-compact,
    .read-more-btn {
        width: 100%;
    }
}

@media (max-width: 480px) {
    .header-wrap {
        padding: 15px 20px;
    }
    
    .container {
        padding: 0 20px;
    }
    
    .services-hero h1 {
        font-size: 1.8rem;
    }
    
    .section-title {
        font-size: 2.2rem;
    }
    
    .section-subtitle {
        font-size: 1.1rem;
        margin-bottom: 40px;
    }
    
    .services-grid-compact {
        grid-template-columns: 1fr;
    }
    
    .service-card-header {
        padding: 20px 20px 15px;
    }
    
    .service-card-body {
        padding: 20px;
    }
    
    .religion-content {
        padding: 25px;
    }
}
</style>

<script>
// Tab switching for religion-specific services
function switchReligion(religion, element) {
    // Remove active class from all tabs
    document.querySelectorAll('.religion-tab').forEach(tab => {
        tab.classList.remove('active');
    });
    
    // Add active class to clicked tab
    element.classList.add('active');
    
    // Hide all religion content
    document.querySelectorAll('.religion-item').forEach(item => {
        item.classList.remove('active');
    });
    
    // Show selected religion content
    document.getElementById(religion).classList.add('active');
}

// Initialize with first religion active
document.addEventListener('DOMContentLoaded', function() {
    document.querySelector('.religion-tab').classList.add('active');
    document.querySelector('.religion-item').classList.add('active');
});

// Services Dropdown functionality
document.addEventListener('DOMContentLoaded', function() {
    const navServices = document.querySelector('.nav-services');
    const dropdownIcon = navServices.querySelector('.dropdown-icon');
    
    // Check if touch device
    const isTouchDevice = 'ontouchstart' in window || navigator.maxTouchPoints > 0;
    if (isTouchDevice) {
        document.body.classList.add('touch-device');
    }
    
    // Toggle dropdown on click for mobile/touch devices
    navServices.addEventListener('click', function(e) {
        if (isTouchDevice && e.target.closest('a')) {
            e.preventDefault();
            this.classList.toggle('active');
        }
    });
    
    // Close dropdown when clicking outside
    document.addEventListener('click', function(e) {
        if (!navServices.contains(e.target)) {
            navServices.classList.remove('active');
        }
    });
    
    // Handle hover for desktop
    if (!isTouchDevice) {
        navServices.addEventListener('mouseenter', function() {
            this.classList.add('active');
        });
        
        navServices.addEventListener('mouseleave', function() {
            this.classList.remove('active');
        });
    }
});

// Scroll to service function
function scrollToService(serviceId) {
    const element = document.getElementById(serviceId);
    if (element) {
        // Close dropdown
        document.querySelector('.nav-services').classList.remove('active');
        
        // Scroll to element with offset for header
        const headerHeight = document.querySelector('header').offsetHeight;
        const elementPosition = element.getBoundingClientRect().top;
        const offsetPosition = elementPosition + window.pageYOffset - headerHeight - 20;
        
        window.scrollTo({
            top: offsetPosition,
            behavior: 'smooth'
        });
    }
    return false;
}

// Read More Toggle Function
function toggleReadMore(button) {
    const card = button.closest('.service-card-compact');
    const content = card.querySelector('.read-more-content');
    const icon = button.querySelector('i');
    
    if (content.style.display === 'none' || content.style.display === '') {
        content.style.display = 'block';
        button.classList.add('active');
        button.innerHTML = 'Read Less <i class="fa-solid fa-chevron-up"></i>';
        
        // Smooth animation for expanding
        card.style.transition = 'all 0.4s ease';
        
        // Scroll to show full content if needed
        setTimeout(() => {
            card.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        }, 100);
    } else {
        content.style.display = 'none';
        button.classList.remove('active');
        button.innerHTML = 'Read More <i class="fa-solid fa-chevron-down"></i>';
    }
}

// Initialize all read more buttons
document.addEventListener('DOMContentLoaded', function() {
    // Add click animation to buttons
    const buttons = document.querySelectorAll('.read-more-btn');
    buttons.forEach(button => {
        button.addEventListener('click', function() {
            this.style.transform = 'scale(0.95)';
            setTimeout(() => {
                this.style.transform = '';
            }, 200);
        });
    });
    
    // Add subtle animation to cards when they come into view
    const cards = document.querySelectorAll('.service-card-compact');
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, { threshold: 0.1 });
    
    cards.forEach(card => {
        card.style.opacity = '0';
        card.style.transform = 'translateY(20px)';
        card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
        observer.observe(card);
    });
});
</script>
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
            
            <!-- Services with Dropdown -->
            <div class="nav-services">
                <a href="<%=request.getContextPath()%>/services" class="active">
                    Services <i class="fa-solid fa-chevron-down dropdown-icon"></i>
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
        </nav>
    </div>
</header>

<!-- SERVICES HERO -->
<section class="services-hero">
    <div class="services-hero-content">
        <h1>Complete Pilgrimage Services</h1>
        <p>Your one-stop solution for all pilgrimage needs - Travel, Rituals, and Sacred Items across all religions</p>
    </div>
</section>

<!-- SERVICES INTRO -->
<section class="services-intro">
    <div class="container">
        <h2>Your Journey Made <span>Sacred & Simple</span></h2>
        <p>At Pilgrim Project, we understand that a pilgrimage is more than just a journey - it's a spiritual experience. That's why we offer comprehensive services that cater to every aspect of your sacred travel, ensuring peace of mind and spiritual fulfillment.</p>
    </div>
</section>

<!-- MAIN SERVICES - COMPACT DESIGN -->
<section class="container services-section-with-bg">
    <div class="services-overlay"></div>
    <h2 class="section-title">Our <span>Pilgrimage Services</span></h2>
    <p class="section-subtitle">Everything you need for a meaningful spiritual journey</p>
    
    <div class="services-grid-compact">
        
        <!-- Travel Services -->
        <div class="service-card-compact" id="sacred-journey">
            <div class="service-card-header">
                <div class="service-icon-compact">
                    <i class="fa-solid fa-plane-departure"></i>
                </div>
                <h3>Sacred Journey Planning</h3>
            </div>
            <div class="service-card-body">
                <p>Complete travel arrangements for pilgrimage sites worldwide with respect for all traditions.</p>
                
                <div class="service-features-compact">
                    <span><i class="fa-solid fa-check"></i> Flight Bookings</span>
                    <span><i class="fa-solid fa-check"></i> Itinerary Planning</span>
                    <span><i class="fa-solid fa-check"></i> Group Coordination</span>
                </div>
                
                <div class="read-more-content" style="display: none;">
                    <div class="extra-info">
                        <h4>Detailed Features:</h4>
                        <ul>
                            <li>Multi-destination pilgrimage planning</li>
                            <li>Seasonal and festival considerations</li>
                            <li>Local transportation arrangements</li>
                            <li>Pilgrimage tour packages</li>
                            <li>Discounts for group pilgrimages</li>
                        </ul>
                        <div class="pricing-info">
                            <strong>Starting from: ₹8,999</strong>
                            <span>Per person</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="service-card-footer">
                <a href="#" class="service-button-compact">Book Now</a>
                <button class="read-more-btn" onclick="toggleReadMore(this)">Read More <i class="fa-solid fa-chevron-down"></i></button>
            </div>
        </div>
        
        <!-- Spiritual Guidance -->
        <div class="service-card-compact" id="spiritual-guidance">
            <div class="service-card-header">
                <div class="service-icon-compact">
                    <i class="fa-solid fa-hands-praying"></i>
                </div>
                <h3>Spiritual Guidance</h3>
            </div>
            <div class="service-card-body">
                <p>Connect with verified spiritual guides and religious experts for ceremonies and rituals.</p>
                
                <div class="service-features-compact">
                    <span><i class="fa-solid fa-check"></i> Verified Guides</span>
                    <span><i class="fa-solid fa-check"></i> Ceremony Support</span>
                    <span><i class="fa-solid fa-check"></i> Multi-faith</span>
                </div>
                
                <div class="read-more-content" style="display: none;">
                    <div class="extra-info">
                        <h4>Detailed Features:</h4>
                        <ul>
                            <li>Verified Pandits, Priests, Imams, Granthis</li>
                            <li>Language translation services available</li>
                            <li>Special occasion rituals</li>
                            <li>Wedding ceremony arrangements</li>
                            <li>Temple rituals & poojas coordination</li>
                        </ul>
                        <div class="pricing-info">
                            <strong>Starting from: ₹2,499</strong>
                            <span>Per ceremony</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="service-card-footer">
                <a href="<%=request.getContextPath()%>/customer/scholar/dashboard" class="service-button-compact">Book Guide</a>
                <button class="read-more-btn" onclick="toggleReadMore(this)">Read More <i class="fa-solid fa-chevron-down"></i></button>
            </div>
        </div>
        
        <!-- Pooja Items -->
        <div class="service-card-compact" id="spiritual-resources">
            <div class="service-card-header">
                <div class="service-icon-compact">
                    <i class="fa-solid fa-book-quran"></i>
                </div>
                <h3>Pooja Items & Rituals</h3>
            </div>
            <div class="service-card-body">
                <p>Access to authentic religious items, sacred texts, and resources for spiritual practices.</p>
                
                <div class="service-features-compact">
                    <span><i class="fa-solid fa-check"></i> Ritual Kits</span>
                    <span><i class="fa-solid fa-check"></i> Sacred Texts</span>
                    <span><i class="fa-solid fa-check"></i> Delivery</span>
                </div>
                
                <div class="read-more-content" style="display: none;">
                    <div class="extra-info">
                        <h4>Detailed Features:</h4>
                        <ul>
                            <li>Temple quality pooja items</li>
                            <li>Pre-packed ritual kits for all faiths</li>
                            <li>Sacred flowers, garlands, and offerings</li>
                            <li>Religious books and texts</li>
                            <li>Home delivery available</li>
                        </ul>
                        <div class="pricing-info">
                            <strong>Starting from: ₹299</strong>
                            <span>Per kit</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="service-card-footer">
                <a href="<%=request.getContextPath()%>/pooja/customer/items" class="service-button-compact">Shop Now</a>
                <button class="read-more-btn" onclick="toggleReadMore(this)">Read More <i class="fa-solid fa-chevron-down"></i></button>
            </div>
        </div>
        
        <!-- Accommodation -->
        <div class="service-card-compact" id="accommodation">
            <div class="service-card-header">
                <div class="service-icon-compact">
                    <i class="fa-solid fa-building"></i>
                </div>
                <h3>Sacred Accommodation</h3>
            </div>
            <div class="service-card-body">
                <p>Find comfortable and affordable accommodation near pilgrimage sites for a peaceful stay.</p>
                
                <div class="service-features-compact">
                    <span><i class="fa-solid fa-check"></i> Near Temples</span>
                    <span><i class="fa-solid fa-check"></i> Verified Properties</span>
                    <span><i class="fa-solid fa-check"></i> Easy Booking</span>
                </div>
                
                <div class="read-more-content" style="display: none;">
                    <div class="extra-info">
                        <h4>Detailed Features:</h4>
                        <ul>
                            <li>Properties near major pilgrimage sites</li>
                            <li>Verified and safe accommodations</li>
                            <li>Easy online booking system</li>
                            <li>Property owner registration available</li>
                            <li>24/7 customer support</li>
                        </ul>
                        <div class="pricing-info">
                            <strong>Starting from: ₹499</strong>
                            <span>Per night</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="service-card-footer">
                <a href="<%=request.getContextPath()%>/accommodation/user/search" class="service-button-compact">Search Properties</a>
                <button class="read-more-btn" onclick="toggleReadMore(this)">Read More <i class="fa-solid fa-chevron-down"></i></button>
            </div>
        </div>
        
        <!-- Prasad Delivery -->
        <div class="service-card-compact" id="blessed-offerings">
            <div class="service-card-header">
                <div class="service-icon-compact">
                    <i class="fa-solid fa-hand-holding-heart"></i>
                </div>
                <h3>Blessed Offerings</h3>
            </div>
            <div class="service-card-body">
                <p>Receive authentic blessed offerings from sacred sites delivered to your home.</p>
                
                <div class="service-features-compact">
                    <span><i class="fa-solid fa-check"></i> Temple Prasad</span>
                    <span><i class="fa-solid fa-check"></i> Nationwide</span>
                    <span><i class="fa-solid fa-check"></i> Verified</span>
                </div>
                
                <div class="read-more-content" style="display: none;">
                    <div class="extra-info">
                        <h4>Detailed Features:</h4>
                        <ul>
                            <li>Tirupati Laddu delivery</li>
                            <li>Guruvayur Appam</li>
                            <li>Shirdi Prasad and offerings</li>
                            <li>Golden Temple Karah Prasad</li>
                            <li>International delivery available</li>
                        </ul>
                        <div class="pricing-info">
                            <strong>Starting from: ₹199</strong>
                            <span>Per offering</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="service-card-footer">
                <a href="#" class="service-button-compact">Order Prasad</a>
                <button class="read-more-btn" onclick="toggleReadMore(this)">Read More <i class="fa-solid fa-chevron-down"></i></button>
            </div>
        </div>
        
        <!-- Information -->
        <div class="service-card-compact" id="sacred-information">
            <div class="service-card-header">
                <div class="service-icon-compact">
                    <i class="fa-solid fa-landmark"></i>
                </div>
                <h3>Sacred Information</h3>
            </div>
            <div class="service-card-body">
                <p>Complete guides to sacred places with historical context and visiting information for all faiths.</p>
                
                <div class="service-features-compact">
                    <span><i class="fa-solid fa-check"></i> Site Guides</span>
                    <span><i class="fa-solid fa-check"></i> Timings</span>
                    <span><i class="fa-solid fa-check"></i> Virtual Tours</span>
                </div>
                
                <div class="read-more-content" style="display: none;">
                    <div class="extra-info">
                        <h4>Detailed Features:</h4>
                        <ul>
                            <li>Temple timings and ritual schedules</li>
                            <li>Historical and cultural information</li>
                            <li>Virtual tours of sacred sites</li>
                            <li>Festival calendars and crowd predictions</li>
                            <li>Cultural etiquette guidance</li>
                        </ul>
                        <div class="pricing-info">
                            <strong>Free access</strong>
                            <span>To all information</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="service-card-footer">
                <a href="#" class="service-button-compact">Explore Info</a>
                <button class="read-more-btn" onclick="toggleReadMore(this)">Read More <i class="fa-solid fa-chevron-down"></i></button>
            </div>
        </div>
        
    </div>
</section>

<!-- QUICK ACCESS SECTION - REGISTRATION & LOGIN -->
<section class="container" style="margin: 80px auto; padding: 60px 0; background: linear-gradient(135deg, rgba(212, 175, 55, 0.1), rgba(139, 69, 19, 0.05)); border-radius: 30px; box-shadow: 0 15px 40px rgba(0, 0, 0, 0.08);">
    <h2 class="section-title">Quick <span>Access</span></h2>
    <p class="section-subtitle">Register or login to access our services</p>
    
    <div class="services-grid-compact" style="max-width: 1000px; margin: 0 auto;">
        <!-- Accommodation Access Card -->
        <div class="service-card-compact">
            <div class="service-card-header">
                <div class="service-icon-compact" style="background: linear-gradient(135deg, #667eea, #764ba2);">
                    <i class="fa-solid fa-building"></i>
                </div>
                <h3>Accommodation</h3>
            </div>
            <div class="service-card-body">
                <p>Book accommodation near pilgrimage sites or register as a property owner.</p>
                
                <div class="service-features-compact">
                    <span><i class="fa-solid fa-check"></i> Book Properties</span>
                    <span><i class="fa-solid fa-check"></i> List Your Property</span>
                    <span><i class="fa-solid fa-check"></i> Manage Bookings</span>
                </div>
            </div>
            <div class="service-card-footer" style="flex-direction: column; gap: 10px;">
                <div style="display: flex; gap: 10px; width: 100%;">
                    <a href="<%=request.getContextPath()%>/accommodation/signup" class="service-button-compact" style="flex: 1; text-align: center;">
                        <i class="fa-solid fa-user-plus"></i> Register
                    </a>
                    <a href="<%=request.getContextPath()%>/accommodation/signin" class="read-more-btn" style="flex: 1; text-align: center; text-decoration: none;">
                        <i class="fa-solid fa-sign-in-alt"></i> Login
                    </a>
                </div>
                <a href="<%=request.getContextPath()%>/accommodation/user/search" style="width: 100%; text-align: center; color: #667eea; text-decoration: none; font-weight: 500; padding: 8px;">
                    <i class="fa-solid fa-search"></i> Browse Properties
                </a>
            </div>
        </div>
        
        <!-- Pooja Items Access Card -->
        <div class="service-card-compact">
            <div class="service-card-header">
                <div class="service-icon-compact" style="background: linear-gradient(135deg, #f093fb, #f5576c);">
                    <i class="fa-solid fa-hands-praying"></i>
                </div>
                <h3>Pooja Items</h3>
            </div>
            <div class="service-card-body">
                <p>Shop for authentic pooja items or register as a vendor to sell your products.</p>
                
                <div class="service-features-compact">
                    <span><i class="fa-solid fa-check"></i> Shop Items</span>
                    <span><i class="fa-solid fa-check"></i> Become Vendor</span>
                    <span><i class="fa-solid fa-check"></i> Manage Store</span>
                </div>
            </div>
            <div class="service-card-footer" style="flex-direction: column; gap: 10px;">
                <div style="display: flex; gap: 10px; width: 100%;">
                    <a href="<%=request.getContextPath()%>/register" class="service-button-compact" style="flex: 1; text-align: center;">
                        <i class="fa-solid fa-user-plus"></i> Customer Register
                    </a>
                    <a href="<%=request.getContextPath()%>/login" class="read-more-btn" style="flex: 1; text-align: center; text-decoration: none;">
                        <i class="fa-solid fa-sign-in-alt"></i> Customer Login
                    </a>
                </div>
                <div style="display: flex; gap: 10px; width: 100%;">
                    <a href="<%=request.getContextPath()%>/pooja/vendor/register" class="service-button-compact" style="flex: 1; text-align: center; background: linear-gradient(135deg, #f093fb, #f5576c);">
                        <i class="fa-solid fa-store"></i> Vendor Register
                    </a>
                    <a href="<%=request.getContextPath()%>/pooja/vendor/login" class="read-more-btn" style="flex: 1; text-align: center; text-decoration: none;">
                        <i class="fa-solid fa-sign-in-alt"></i> Vendor Login
                    </a>
                </div>
                <a href="<%=request.getContextPath()%>/pooja/customer/items" style="width: 100%; text-align: center; color: #f5576c; text-decoration: none; font-weight: 500; padding: 8px;">
                    <i class="fa-solid fa-shopping-cart"></i> Shop Now
                </a>
            </div>
        </div>
        
        <!-- Travel Access Card -->
        <div class="service-card-compact">
            <div class="service-card-header">
                <div class="service-icon-compact" style="background: linear-gradient(135deg, #0ea5e9, #0284c7);">
                    <i class="fa-solid fa-plane"></i>
                </div>
                <h3>Travel & Pilgrimage</h3>
            </div>
            <div class="service-card-body">
                <p>Book travel packages for pilgrimage sites or register as a travel agency to offer your services.</p>
                
                <div class="service-features-compact">
                    <span><i class="fa-solid fa-check"></i> Book Packages</span>
                    <span><i class="fa-solid fa-check"></i> Become Agency</span>
                    <span><i class="fa-solid fa-check"></i> Manage Tours</span>
                </div>
            </div>
            <div class="service-card-footer" style="flex-direction: column; gap: 10px;">
                <div style="display: flex; gap: 10px; width: 100%;">
                    <a href="<%=request.getContextPath()%>/pilgrim/travel/agency/register" class="service-button-compact" style="flex: 1; text-align: center; background: linear-gradient(135deg, #0ea5e9, #0284c7);">
                        <i class="fa-solid fa-user-plus"></i> Agency Register
                    </a>
                    <a href="<%=request.getContextPath()%>/pilgrim/travel/agency/login" class="read-more-btn" style="flex: 1; text-align: center; text-decoration: none;">
                        <i class="fa-solid fa-sign-in-alt"></i> Agency Login
                    </a>
                </div>
                <a href="<%=request.getContextPath()%>/pilgrim/travel" style="width: 100%; text-align: center; color: #0284c7; text-decoration: none; font-weight: 500; padding: 8px;">
                    <i class="fa-solid fa-suitcase"></i> Browse Packages
                </a>
            </div>
        </div>
        
        <!-- Temple Access Card -->
        <div class="service-card-compact">
            <div class="service-card-header">
                <div class="service-icon-compact" style="background: linear-gradient(135deg, #8b4513, #a0522d);">
                    <i class="fa-solid fa-church"></i>
                </div>
                <h3>Temple Services</h3>
            </div>
            <div class="service-card-body">
                <p>Manage your temple services, bookings, and offerings or browse temples to book darshan, pooja, and more.</p>
                
                <div class="service-features-compact">
                    <span><i class="fa-solid fa-check"></i> Book Darshan</span>
                    <span><i class="fa-solid fa-check"></i> Book Pooja</span>
                    <span><i class="fa-solid fa-check"></i> Order Prasadham</span>
                    <span><i class="fa-solid fa-check"></i> Book Tour Guide</span>
                    <span><i class="fa-solid fa-check"></i> Make Donation</span>
                </div>
            </div>
            <div class="service-card-footer" style="flex-direction: column; gap: 10px;">
                <div style="display: flex; gap: 10px; width: 100%;">
                    <a href="<%=request.getContextPath()%>/pilgrim/temple/admin/temple/add" class="service-button-compact" style="flex: 1; text-align: center; background: linear-gradient(135deg, #8b4513, #a0522d);">
                        <i class="fa-solid fa-user-plus"></i> Temple Register
                    </a>
                    <a href="<%=request.getContextPath()%>/pilgrim/temple/admin/dashboard" class="read-more-btn" style="flex: 1; text-align: center; text-decoration: none;">
                        <i class="fa-solid fa-sign-in-alt"></i> Temple Admin
                    </a>
                </div>
                <a href="<%=request.getContextPath()%>/pilgrim/temple" style="width: 100%; text-align: center; color: #8b4513; text-decoration: none; font-weight: 500; padding: 8px;">
                    <i class="fa-solid fa-landmark"></i> Browse Temples
                </a>
            </div>
        </div>
    </div>
</section>

<!-- RELIGION SPECIFIC SERVICES - UPDATED -->
<section class="religion-services" id="religion-specific">
    <div class="container">
        <h2 class="section-title">Tailored for Every <span>Faith Tradition</span></h2>
        
        <div class="religion-tabs">
            <div class="religion-tab" onclick="switchReligion('hindu', this)">
                <i class="fa-solid fa-om"></i> Hindu
            </div>
            <div class="religion-tab" onclick="switchReligion('christian', this)">
                <i class="fa-solid fa-church"></i> Christian
            </div>
            <div class="religion-tab" onclick="switchReligion('islam', this)">
                <i class="fa-solid fa-mosque"></i> Islam
            </div>
            <div class="religion-tab" onclick="switchReligion('sikh', this)">
                <i class="fa-solid fa-gopuram"></i> Sikh
            </div>
            <div class="religion-tab" onclick="switchReligion('buddhist', this)">
                <i class="fa-solid fa-yin-yang"></i> Buddhist
            </div>
            <div class="religion-tab" onclick="switchReligion('jewish', this)">
                <i class="fa-solid fa-star-of-david"></i> Jewish
            </div>
        </div>
        
        <div class="religion-content">
            <div class="religion-item active" id="hindu">
                <h3><i class="fa-solid fa-om"></i> Hindu Pilgrimage Services</h3>
                <p>Comprehensive support for Char Dham, Jyotirlingas, and important Hindu pilgrimage sites with respect for all traditions.</p>
                
                <div class="religion-features">
                    <div class="feature">
                        <i class="fa-solid fa-water"></i>
                        <div>
                            <h4>Sacred Bath Arrangements</h4>
                            <p>Guidance and support for holy dips in sacred rivers and water bodies.</p>
                        </div>
                    </div>
                    <div class="feature">
                        <i class="fa-solid fa-moon"></i>
                        <div>
                            <h4>Special Ceremonies</h4>
                            <p>Coordination of pujas and rituals at temples and sacred sites.</p>
                        </div>
                    </div>
                    <div class="feature">
                        <i class="fa-solid fa-mountain"></i>
                        <div>
                            <h4>Difficult Pilgrimages</h4>
                            <p>Support for challenging yatras with proper guidance and facilities.</p>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="religion-item" id="christian">
                <h3><i class="fa-solid fa-church"></i> Christian Pilgrimage Services</h3>
                <p>Meaningful journeys to churches, cathedrals, and holy sites with appropriate spiritual support.</p>
                
                <div class="religion-features">
                    <div class="feature">
                        <i class="fa-solid fa-cross"></i>
                        <div>
                            <h4>Church & Cathedral Visits</h4>
                            <p>Guided visits to significant Christian holy sites.</p>
                        </div>
                    </div>
                    <div class="feature">
                        <i class="fa-solid fa-book-bible"></i>
                        <div>
                            <h4>Mass & Prayer Services</h4>
                            <p>Arrangements for participation in religious services.</p>
                        </div>
                    </div>
                    <div class="feature">
                        <i class="fa-solid fa-route"></i>
                        <div>
                            <h4>Holy Land Journeys</h4>
                            <p>Complete packages for meaningful Christian pilgrimages.</p>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="religion-item" id="islam">
                <h3><i class="fa-solid fa-mosque"></i> Islamic Pilgrimage Services</h3>
                <p>Respectful services for mosque visits and spiritual journeys following Islamic traditions.</p>
                
                <div class="religion-features">
                    <div class="feature">
                        <i class="fa-solid fa-kaaba"></i>
                        <div>
                            <h4>Mosque & Dargah Visits</h4>
                            <p>Guidance for visiting important Islamic sites.</p>
                        </div>
                    </div>
                    <div class="feature">
                        <i class="fa-solid fa-person-praying"></i>
                        <div>
                            <h4>Prayer Guidance</h4>
                            <p>Support for maintaining prayer schedules during travel.</p>
                        </div>
                    </div>
                    <div class="feature">
                        <i class="fa-solid fa-moon"></i>
                        <div>
                            <h4>Festival Support</h4>
                            <p>Special arrangements during Ramadan and Eid celebrations.</p>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="religion-item" id="sikh">
                <h3><i class="fa-solid fa-gopuram"></i> Sikh Pilgrimage Services</h3>
                <p>Services for Gurudwara visits and spiritual journeys honoring Sikh traditions.</p>
                
                <div class="religion-features">
                    <div class="feature">
                        <i class="fa-solid fa-landmark"></i>
                        <div>
                            <h4>Gurudwara Darshan</h4>
                            <p>Visits to significant Sikh holy sites with proper guidance.</p>
                        </div>
                    </div>
                    <div class="feature">
                        <i class="fa-solid fa-bowl-food"></i>
                        <div>
                            <h4>Langar Participation</h4>
                            <p>Guidance for participating in community services.</p>
                        </div>
                    </div>
                    <div class="feature">
                        <i class="fa-solid fa-book"></i>
                        <div>
                            <h4>Spiritual Learning</h4>
                            <p>Opportunities for learning and reflection.</p>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="religion-item" id="buddhist">
                <h3><i class="fa-solid fa-yin-yang"></i> Buddhist Pilgrimage Services</h3>
                <p>Peaceful journeys to monasteries and enlightenment sites with mindfulness support.</p>
                
                <div class="religion-features">
                    <div class="feature">
                        <i class="fa-solid fa-leaf"></i>
                        <div>
                            <h4>Meditation Retreats</h4>
                            <p>Monastery stays and meditation guidance.</p>
                        </div>
                    </div>
                    <div class="feature">
                        <i class="fa-solid fa-mountain"></i>
                        <div>
                            <h4>Sacred Site Visits</h4>
                            <p>Journeys to important Buddhist pilgrimage sites.</p>
                        </div>
                    </div>
                    <div class="feature">
                        <i class="fa-solid fa-person-praying"></i>
                        <div>
                            <h4>Teaching Sessions</h4>
                            <p>Opportunities for learning Buddhist teachings.</p>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="religion-item" id="jewish">
                <h3><i class="fa-solid fa-star-of-david"></i> Jewish Pilgrimage Services</h3>
                <p>Meaningful visits to synagogues and holy sites with respect for Jewish traditions.</p>
                
                <div class="religion-features">
                    <div class="feature">
                        <i class="fa-solid fa-synagogue"></i>
                        <div>
                            <h4>Synagogue Visits</h4>
                            <p>Guidance for visiting significant Jewish sites.</p>
                        </div>
                    </div>
                    <div class="feature">
                        <i class="fa-solid fa-torah"></i>
                        <div>
                            <h4>Religious Observance</h4>
                            <p>Support for maintaining religious practices during travel.</p>
                        </div>
                    </div>
                    <div class="feature">
                        <i class="fa-solid fa-candle"></i>
                        <div>
                            <h4>Festival Support</h4>
                            <p>Special arrangements during Jewish holidays.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- HOW IT WORKS -->
<section class="how-it-works" id="how-it-works">
    <div class="container">
        <h2 class="section-title">How It <span>Works</span></h2>
        
        <div class="steps">
            <div class="step">
                <div class="step-number">1</div>
                <h3>Choose Your Pilgrimage</h3>
                <p>Select your destination from our comprehensive list of sacred sites across all religions.</p>
            </div>
            
            <div class="step">
                <div class="step-number">2</div>
                <h3>Customize Services</h3>
                <p>Select from our range of services - travel, rituals, and sacred items.</p>
            </div>
            
            <div class="step">
                <div class="step-number">3</div>
                <h3>Book & Confirm</h3>
                <p>Make your booking with our secure payment system and receive instant confirmation.</p>
            </div>
            
            <div class="step">
                <div class="step-number">4</div>
                <h3>Begin Your Journey</h3>
                <p>Start your sacred journey with all arrangements taken care of by our experts.</p>
            </div>
        </div>
    </div>
</section>

<!-- CTA SECTION -->
<section class="cta-section">
    <div class="cta-content">
        <h2>Begin Your Sacred Journey Today</h2>
        <p>Let us handle the logistics while you focus on the spiritual experience. Our team of experts is ready to make your pilgrimage memorable and meaningful.</p>
        <a href="<%=request.getContextPath()%>/contactus" class="cta-button">Start Planning Now</a>
    </div>
</section>

<!-- FOOTER -->
<footer>
    <div class="footer-wrap">
        <div>
            <h4>Pilgrim Project</h4>
            <p>Making pilgrimage accessible, meaningful, and complete for people of all faiths.</p>
        </div>
        
        <div>
            <h4>Our Services</h4>
            <a href="#sacred-journey">Sacred Journey Planning</a>
            <a href="#spiritual-guidance">Spiritual Guidance</a>
            <a href="#spiritual-resources">Spiritual Resources</a>
            <a href="#blessed-offerings">Blessed Offerings</a>
            <a href="#sacred-information">Sacred Information</a>
        </div>
        
        <div>
            <h4>Quick Links</h4>
            <a href="/views/index.jsp">Home</a>
            <a href="/views/aboutus.jsp">About Us</a>
            <a href="/views/services.jsp">Services</a>
            <a href="/views/contactus.jsp">Contact Us</a>
        </div>
        
        <div>
            <h4>Legal</h4>
            <a href="<%=request.getContextPath()%>/privacy">Privacy Policy</a>
            <a href="<%=request.getContextPath()%>/terms">Terms & Conditions</a>
            <a href="#">Refund Policy</a>
            <a href="#">Service Guarantee</a>
        </div>
    </div>
    
    <div class="footer-bottom">
        © <%= java.time.Year.now() %> Pilgrim Project. All Rights Reserved. | Serving pilgrims across all faiths
    </div>
</footer>

</body>
</html>