<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book ${scholar.user.name} - Services</title>

    <!-- Bootstrap CSS & JS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script defer src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Razorpay Checkout -->
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>

    <!-- Custom CSS -->
    <style>
        body {
            background: #f7f9fc;
            font-family: 'Segoe UI', sans-serif;
        }

        .step-container {
            display: none;
        }

        .step-container.active {
            display: block;
        }

        .breadcrumb {
            background: transparent;
            padding: 15px 0;
        }

        .breadcrumb-item a {
            color: #666;
            text-decoration: none;
        }

        .breadcrumb-item.active {
            color: #333;
        }

        /* Step 1: Package Selection Styles */
        .package-hero {
            background: #fff;
            border-radius: 12px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        .package-image {
            width: 100%;
            max-width: 400px;
            border-radius: 8px;
            object-fit: cover;
        }

        .price-range {
            color: #ff7f27;
            font-size: 24px;
            font-weight: 600;
            margin: 15px 0;
        }

        .package-title {
            font-size: 32px;
            font-weight: 700;
            color: #333;
            margin-bottom: 15px;
        }

        .package-description {
            color: #555;
            line-height: 1.6;
            margin-bottom: 20px;
        }

        .btn-select-package {
            background: #ff7f27;
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s;
        }

        .btn-select-package:hover {
            background: #e86e20;
        }

        .spiritual-benefits {
            background: #fff;
            border-radius: 12px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        .spiritual-benefits h3 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 20px;
            color: #333;
        }

        .package-card {
            background: #fff;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            border: 2px solid transparent;
            transition: all 0.3s;
        }

        .package-card:hover {
            border-color: #ff7f27;
            transform: translateY(-4px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
        }

        .package-card-title {
            font-size: 22px;
            font-weight: 600;
            color: #333;
            margin-bottom: 15px;
        }

        .package-procedure {
            list-style: none;
            padding: 0;
            margin: 15px 0;
        }

        .package-procedure li {
            padding: 8px 0;
            padding-left: 25px;
            position: relative;
            color: #555;
        }

        .package-procedure li:before {
            content: "•";
            position: absolute;
            left: 0;
            color: #ff7f27;
            font-weight: bold;
            font-size: 20px;
        }

        .package-price {
            font-size: 28px;
            font-weight: 700;
            color: #333;
            margin: 15px 0;
        }

        .package-price .strikethrough {
            font-size: 18px;
            color: #999;
            text-decoration: line-through;
            margin-left: 10px;
        }

        .btn-select {
            background: #ff7f27;
            color: white;
            border: none;
            padding: 10px 25px;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            float: right;
            margin-top: -50px;
        }

        .btn-select:hover {
            background: #e86e20;
        }

        /* Step 2: Addons Styles */
        .addons-container {
            display: flex;
            gap: 30px;
            margin-top: 20px;
        }

        .addons-section {
            flex: 1;
            background: #fff;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        .addons-section h3 {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 20px;
            color: #333;
        }

        .addon-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            margin-bottom: 15px;
            background: #fafafa;
        }

        .addon-item.included {
            background: #f0f9ff;
        }

        .addon-name {
            font-weight: 600;
            color: #333;
        }

        .addon-status {
            color: #28a745;
            font-weight: 600;
            font-size: 14px;
        }

        .addon-price {
            font-weight: 600;
            color: #333;
            margin-right: 15px;
        }

        .btn-add {
            background: white;
            color: #ff7f27;
            border: 2px solid #ff7f27;
            padding: 6px 15px;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-add:hover {
            background: #ff7f27;
            color: white;
        }

        .btn-added {
            background: #28a745;
            color: white;
            border: 2px solid #28a745;
            padding: 6px 15px;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
        }

        .order-summary {
            flex: 0 0 350px;
            background: #fff;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            height: fit-content;
            position: sticky;
            top: 20px;
        }

        .order-summary h3 {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 20px;
            color: #333;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #e0e0e0;
        }

        .summary-item:last-child {
            border-bottom: none;
        }

        .summary-label {
            color: #666;
        }

        .summary-value {
            font-weight: 600;
            color: #333;
        }

        .summary-total {
            margin-top: 15px;
            padding-top: 15px;
            border-top: 2px solid #333;
        }

        .summary-total .summary-value {
            font-size: 24px;
            color: #ff7f27;
        }

        .btn-proceed {
            background: #ff7f27;
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            width: 100%;
            margin-top: 20px;
            cursor: pointer;
        }

        .btn-proceed:hover {
            background: #e86e20;
        }

        /* Step 3: Payment Styles */
        .payment-container {
            max-width: 600px;
            margin: 0 auto;
            background: #fff;
            border-radius: 12px;
            padding: 40px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        .payment-container h3 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 30px;
            text-align: center;
            color: #333;
        }

        .payment-summary {
            background: #f7f9fc;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 30px;
        }

        .payment-summary-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
        }

        .payment-summary-total {
            border-top: 2px solid #333;
            margin-top: 15px;
            padding-top: 15px;
            font-size: 20px;
            font-weight: 700;
            color: #ff7f27;
        }

        .btn-pay-now {
            background: #ff7f27;
            color: white;
            border: none;
            padding: 15px 40px;
            border-radius: 6px;
            font-size: 18px;
            font-weight: 600;
            width: 100%;
            cursor: pointer;
            margin-top: 20px;
        }

        .btn-pay-now:hover {
            background: #e86e20;
        }

        .step-indicator {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
            gap: 20px;
        }

        .step {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #e0e0e0;
            color: #666;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            position: relative;
        }

        .step.active {
            background: #ff7f27;
            color: white;
        }

        .step.completed {
            background: #28a745;
            color: white;
        }

        .step-label {
            position: absolute;
            top: 50px;
            left: 50%;
            transform: translateX(-50%);
            white-space: nowrap;
            font-size: 12px;
            color: #666;
        }

        .step.active .step-label {
            color: #ff7f27;
            font-weight: 600;
        }

        .btn-back {
            background: #6c757d;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            margin-right: 10px;
            cursor: pointer;
        }

        .btn-back:hover {
            background: #5a6268;
        }
    </style>
</head>

<body>

<div class="container mt-4">
    
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Home</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/customer/scholar/dashboard">Scholars</a></li>
            <li class="breadcrumb-item active">${scholar.user.name} - Services</li>
        </ol>
    </nav>

    <!-- Step Indicator -->
    <div class="step-indicator">
        <div class="step active" id="step1-indicator">
            <span>1</span>
            <span class="step-label">Select Package</span>
        </div>
        <div class="step" id="step2-indicator">
            <span>2</span>
            <span class="step-label">Addons</span>
        </div>
        <div class="step" id="step3-indicator">
            <span>3</span>
            <span class="step-label">Payment</span>
        </div>
    </div>

    <!-- Booking Details Summary (if coming from booking form) -->
    <c:if test="${not empty pendingServiceType or not empty pendingServiceDate}">
        <div class="card mb-4" style="background: #fff; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.08);">
            <div class="card-header" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
                <h5 class="mb-0"><i class="fas fa-info-circle me-2"></i>Booking Details</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <c:if test="${not empty pendingServiceType}">
                        <div class="col-md-6 mb-3">
                            <strong>Service Type:</strong> ${pendingServiceType}
                        </div>
                    </c:if>
                    <c:if test="${not empty pendingServiceDate}">
                        <div class="col-md-6 mb-3">
                            <strong>Service Date & Time:</strong> 
                            ${pendingServiceDate.toString().replace('T', ' ').substring(0, 16)}
                        </div>
                    </c:if>
                    <c:if test="${not empty pendingServiceLocation}">
                        <div class="col-md-6 mb-3">
                            <strong>Service Location:</strong> ${pendingServiceLocation}
                        </div>
                    </c:if>
                    <c:if test="${not empty pendingServiceDescription}">
                        <div class="col-12 mb-3">
                            <strong>Service Description:</strong> ${pendingServiceDescription}
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </c:if>

    <!-- STEP 1: Package Selection -->
    <div class="step-container active" id="step1">
        <div class="package-hero">
            <div class="row">
                <div class="col-md-4">
                    <c:choose>
                        <c:when test="${not empty services}">
                            <c:set var="poojaTypeForImage" value=""/>
                            <c:forEach var="svc" items="${services}">
                                <c:if test="${empty poojaTypeForImage && not empty svc.serviceType}">
                                    <c:set var="poojaTypeForImage" value="${svc.serviceType.label}"/>
                                </c:if>
                            </c:forEach>
                            <c:choose>
                                <c:when test="${not empty poojaTypeForImage}">
                                    <!-- Show pooja/service type image from ServiceType enum -->
                                    <!-- Image path: src/main/webapp/WEB-INF/views/images/[service-type-name].jpg -->
                                    <!-- Example: For "Satyanarayana Pooja", use: satyanarayana-pooja.jpg -->
                                    <c:set var="serviceTypeLower" value="${fn:toLowerCase(fn:replace(poojaTypeForImage, ' ', '-'))}"/>
                                    <c:set var="serviceTypeImage" value="${pageContext.request.contextPath}/images/${serviceTypeLower}.jpg"/>
                                    <img src="${serviceTypeImage}" 
                                         onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/pooja.jpg';" 
                                         class="package-image" alt="${poojaTypeForImage}">
                                </c:when>
                                <c:when test="${not empty scholar.profilePhotoPath}">
                                    <img src="${pageContext.request.contextPath}${scholar.profilePhotoPath}" 
                                         onerror="this.onerror=null; this.src='data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'200\' height=\'200\'%3E%3Crect width=\'200\' height=\'200\' fill=\'%23f0f0f0\'/%3E%3Ctext x=\'50%25\' y=\'50%25\' text-anchor=\'middle\' dy=\'.3em\' fill=\'%23999\' font-family=\'Arial\' font-size=\'14\'%3ENo Image%3C/text%3E%3C/svg%3E';" 
                                         class="package-image" alt="Scholar Image">
                                </c:when>
                                <c:otherwise>
                                    <div class="package-image" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); display: flex; align-items: center; justify-content: center; color: white; font-size: 48px; font-weight: bold; min-height: 300px; border-radius: 8px;">
                                        ${fn:substring(scholar.user.name, 0, 1)}
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:when test="${not empty scholar.profilePhotoPath}">
                            <img src="${pageContext.request.contextPath}${scholar.profilePhotoPath}" 
                                 onerror="this.onerror=null; this.src='data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'200\' height=\'200\'%3E%3Crect width=\'200\' height=\'200\' fill=\'%23f0f0f0\'/%3E%3Ctext x=\'50%25\' y=\'50%25\' text-anchor=\'middle\' dy=\'.3em\' fill=\'%23999\' font-family=\'Arial\' font-size=\'14\'%3ENo Image%3C/text%3E%3C/svg%3E';" 
                                 class="package-image" alt="Scholar Image">
                        </c:when>
                        <c:otherwise>
                            <div class="package-image" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); display: flex; align-items: center; justify-content: center; color: white; font-size: 48px; font-weight: bold; min-height: 300px; border-radius: 8px;">
                                ${fn:substring(scholar.user.name, 0, 1)}
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="col-md-8">
                    <c:choose>
                        <c:when test="${not empty services}">
                            <c:choose>
                                <c:when test="${services[0].priceWithItems == services[0].priceWithoutItems}">
                                    <div class="price-range">₹<fmt:formatNumber value="${services[0].priceWithItems}" pattern="#,##0.00"/></div>
                                </c:when>
                                <c:otherwise>
                                    <div class="price-range">₹<fmt:formatNumber value="${services[0].priceWithoutItems}" pattern="#,##0.00"/> - ₹<fmt:formatNumber value="${services[0].priceWithItems}" pattern="#,##0.00"/></div>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <div class="price-range">Price on request</div>
                        </c:otherwise>
                    </c:choose>
                    <h1 class="package-title">
                        <c:choose>
                            <c:when test="${not empty services}">
                                <c:set var="foundServiceType" value=""/>
                                <c:forEach var="svc" items="${services}">
                                    <c:if test="${empty foundServiceType && not empty svc.serviceType}">
                                        <c:set var="foundServiceType" value="${svc.serviceType.label}"/>
                                    </c:if>
                                </c:forEach>
                                <c:choose>
                                    <c:when test="${not empty foundServiceType}">
                                        ${foundServiceType} Services
                                    </c:when>
                                    <c:otherwise>
                                        ${scholar.user.name}'s Services
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                ${scholar.user.name}'s Services
                            </c:otherwise>
                        </c:choose>
                    </h1>
                    <p class="package-description">
                        Experience divine blessings with our expert scholar services. Our experienced scholars perform rituals 
                        as per Vedic traditions to bring peace, prosperity, and spiritual fulfillment to your life.
                    </p>
                    <button class="btn-select-package" onclick="showPackages()">View Packages</button>
                </div>
            </div>
        </div>

        <div class="spiritual-benefits">
            <h3>Spiritual Benefits</h3>
            <p>
                Our scholar services are performed with utmost devotion and adherence to Vedic rituals. 
                These ceremonies help remove obstacles, bring peace and prosperity, and invoke divine blessings. 
                Each ritual is conducted by experienced scholars who ensure proper procedures and mantras are followed, 
                bringing spiritual fulfillment and positive energy to your life.
            </p>
        </div>

        <h3 style="font-size: 28px; font-weight: 700; margin-bottom: 20px; color: #333;">Packages</h3>

        <c:choose>
            <c:when test="${empty services}">
                <div class="alert alert-info" style="padding: 20px; border-radius: 8px; background: #e7f3ff; border: 1px solid #b3d9ff;">
                    <h4 style="margin-bottom: 10px;">No Packages Available</h4>
                    <p style="margin: 0;">This scholar has not added any service packages yet. Please check back later or contact the scholar directly.</p>
                </div>
            </c:when>
            <c:otherwise>
        <c:forEach var="service" items="${services}">
            <div class="package-card" 
                 data-service-id="${service.id}"
                 data-service-name="${fn:escapeXml(service.name)}"
                 data-price-with="${service.priceWithItems}"
                 data-price-without="${service.priceWithoutItems}">
                <h4 class="package-card-title">
                    <c:choose>
                        <c:when test="${not empty service.serviceType}">
                            ${service.serviceType.label}
                        </c:when>
                        <c:otherwise>
                            ${service.name}
                        </c:otherwise>
                    </c:choose>
                </h4>
                <p style="color: #666; margin-bottom: 15px;">${service.description}</p>
                
                <!-- Display Service Locations -->
                <c:if test="${not empty service.locations && service.locations.size() > 0}">
                    <div style="margin-bottom: 15px;">
                        <strong style="color: #333; font-size: 14px;">📍 Available Locations:</strong>
                        <div style="display: flex; flex-wrap: wrap; gap: 5px; margin-top: 5px;">
                            <c:forEach var="location" items="${service.locations}">
                                <span style="background: #e3f2fd; color: #1976d2; padding: 4px 10px; border-radius: 12px; font-size: 12px; font-weight: 500;">
                                    ${location}
                                </span>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
                
                <ul class="package-procedure">
                    <li>Swasti Vachanam</li>
                    <li>Mahasankalp</li>
                    <li>Ganpati Puja</li>
                    <li>Kalash Sthapan, Punyah Vachanam</li>
                    <li>Main Puja & Hawan</li>
                    <li>Aarti & Prasad Distribution</li>
                </ul>

                <p style="color: #666; margin: 15px 0; font-size: 14px;">
                    <strong>Note:</strong> We will bring the Puja Samagri such as Haldi, Abir, Gulal, Mango leaves, 
                    Tulsi, Darba, Kalash, Betel leaves, Betel nuts, Hawan sticks, Samidha, Hawan Kund, Dravya, 
                    Cloth, Ghee, etc. Yajman has to arrange basic household items like utensils, oil lamps, mats, 
                    bowls, chowki, plates, Prasad, photos, etc.
                </p>

                <div class="package-price">
                    <c:choose>
                        <c:when test="${service.priceWithItems == service.priceWithoutItems}">
                            ₹<span id="price-${service.id}"><fmt:formatNumber value="${service.priceWithItems}" pattern="#,##0.00"/></span>
                        </c:when>
                        <c:otherwise>
                            ₹<span id="price-${service.id}"><fmt:formatNumber value="${service.priceWithItems}" pattern="#,##0.00"/></span>
                            <span class="strikethrough">₹<fmt:formatNumber value="${service.priceWithoutItems}" pattern="#,##0.00"/></span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <button class="btn-select" onclick="selectPackageFromCard(this)">
                    Select
                </button>
                <div style="clear: both;"></div>
            </div>
        </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- STEP 2: Addons Selection -->
    <div class="step-container" id="step2">
        <div class="addons-container">
            <div class="addons-section">
                <h3>Addons</h3>
                
                <div class="addon-item included">
                    <span class="addon-name">Dakshina</span>
                    <span class="addon-status">Included</span>
                </div>

                <div class="addon-item included">
                    <span class="addon-name">All Puja Samagries</span>
                    <span class="addon-status">Included</span>
                </div>

                <div class="addon-item">
                    <span class="addon-name">Flowers & Fruits</span>
                    <div>
                        <span class="addon-price">₹1200</span>
                        <button class="btn-add" onclick="toggleAddon('flowers', 1200, this)">Add</button>
                    </div>
                </div>

                <div class="addon-item">
                    <span class="addon-name">Havan</span>
                    <div>
                        <span class="addon-price">₹1000</span>
                        <button class="btn-add" onclick="toggleAddon('havan', 1000, this)">Add</button>
                    </div>
                </div>
            </div>

            <div class="order-summary">
                <h3>Order Summary</h3>
                <div class="summary-item">
                    <span class="summary-label">Service</span>
                    <span class="summary-value" id="summary-pooja-name">-</span>
                </div>
                <div class="summary-item">
                    <span class="summary-label">Service Price</span>
                    <span class="summary-value" id="summary-pooja-price">Rs 0</span>
                </div>
                <div class="summary-item" id="addon-flowers" style="display: none;">
                    <span class="summary-label">Flowers & Fruits</span>
                    <span class="summary-value">Rs 1200</span>
                </div>
                <div class="summary-item" id="addon-havan" style="display: none;">
                    <span class="summary-label">Havan</span>
                    <span class="summary-value">Rs 1000</span>
                </div>
                <div class="summary-item summary-total">
                    <span class="summary-label">Total</span>
                    <span class="summary-value" id="summary-total">Rs 0</span>
                </div>
                <button class="btn-proceed" onclick="proceedToPayment()">Proceed To Checkout</button>
                <button class="btn-back" onclick="goToStep(1)">Back</button>
            </div>
        </div>
    </div>

    <!-- STEP 3: Payment -->
    <div class="step-container" id="step3">
        <div class="payment-container">
            <h3>Complete Your Payment</h3>
            
            <div class="payment-summary">
                <div class="payment-summary-item">
                    <span>Service:</span>
                    <span id="payment-pooja-name">-</span>
                </div>
                <div class="payment-summary-item">
                    <span>Base Price:</span>
                    <span id="payment-base-price">₹0</span>
                </div>
                <div class="payment-summary-item" id="payment-flowers" style="display: none;">
                    <span>Flowers & Fruits:</span>
                    <span>₹1200</span>
                </div>
                <div class="payment-summary-item" id="payment-havan" style="display: none;">
                    <span>Havan:</span>
                    <span>₹1000</span>
                </div>
                <div class="payment-summary-item payment-summary-total">
                    <span>Total Amount:</span>
                    <span id="payment-total">₹0</span>
                </div>
            </div>

            <button class="btn-pay-now" onclick="initiatePayment()">Pay Now</button>
            <button class="btn-back" onclick="goToStep(2)" style="width: 100%; margin-top: 10px;">Back</button>
        </div>
    </div>

</div>

<script>
    // Prevent any automatic reloads
    if (window.history.replaceState) {
        window.history.replaceState(null, null, window.location.href);
    }
    
    // Context path for all URLs
    const contextPath = '${pageContext.request.contextPath}';
    const scholarId = ${scholar.id};
    
    // Global state
    let selectedPackage = null;
    let selectedPackageName = '';
    let basePrice = 0;
    let addons = {
        flowers: false,
        havan: false
    };
    let totalAmount = 0;
    
    // Helper function to safely get element
    function getElement(id) {
        const element = document.getElementById(id);
        if (!element) {
            console.warn('Element not found: ' + id);
        }
        return element;
    }

    function showPackages() {
        document.querySelectorAll('.package-card').forEach(card => {
            card.scrollIntoView({ behavior: 'smooth', block: 'start' });
        });
    }

    function selectPackageFromCard(button) {
        const card = button.closest('.package-card');
        const serviceId = parseInt(card.dataset.serviceId);
        const serviceName = card.dataset.serviceName;
        const priceWith = parseFloat(card.dataset.priceWith);
        const priceWithout = parseFloat(card.dataset.priceWithout);
        selectPackage(serviceId, serviceName, priceWith, priceWithout);
    }

    function selectPackage(serviceId, serviceName, priceWith, priceWithout) {
        selectedPackage = serviceId;
        selectedPackageName = serviceName;
        basePrice = priceWith; // Using price with items as base
        
        // Update summary
        const summaryPoojaName = getElement('summary-pooja-name');
        const summaryPoojaPrice = getElement('summary-pooja-price');
        
        if (summaryPoojaName) summaryPoojaName.textContent = serviceName;
        if (summaryPoojaPrice) summaryPoojaPrice.textContent = 'Rs ' + priceWith.toLocaleString('en-IN');
        
        updateTotal();
        
        // Go to step 2
        goToStep(2);
    }

    function toggleAddon(addonName, price, button) {
        addons[addonName] = !addons[addonName];
        
        const addonElement = getElement('addon-' + addonName);
        const paymentElement = getElement('payment-' + addonName);
        
        if (addons[addonName]) {
            button.textContent = 'Added';
            button.classList.remove('btn-add');
            button.classList.add('btn-added');
            if (addonElement) addonElement.style.display = 'flex';
            if (paymentElement) paymentElement.style.display = 'flex';
        } else {
            button.textContent = 'Add';
            button.classList.remove('btn-added');
            button.classList.add('btn-add');
            if (addonElement) addonElement.style.display = 'none';
            if (paymentElement) paymentElement.style.display = 'none';
        }
        
        updateTotal();
    }

    function updateTotal() {
        let total = basePrice;
        if (addons.flowers) total += 1200;
        if (addons.havan) total += 1000;
        
        totalAmount = total;
        
        const summaryTotal = getElement('summary-total');
        const paymentTotal = getElement('payment-total');
        const paymentBasePrice = getElement('payment-base-price');
        const paymentPoojaName = getElement('payment-pooja-name');
        
        if (summaryTotal) summaryTotal.textContent = 'Rs ' + total.toLocaleString('en-IN');
        if (paymentTotal) paymentTotal.textContent = '₹' + total.toLocaleString('en-IN');
        if (paymentBasePrice) paymentBasePrice.textContent = '₹' + basePrice.toLocaleString('en-IN');
        if (paymentPoojaName) paymentPoojaName.textContent = selectedPackageName;
    }

    function proceedToPayment() {
        if (!selectedPackage) {
            alert('Please select a package first');
            return;
        }
        goToStep(3);
    }

    function goToStep(step) {
        try {
            // Hide all steps
            document.querySelectorAll('.step-container').forEach(container => {
                container.classList.remove('active');
            });
            
            // Show selected step
            const stepElement = getElement('step' + step);
            if (stepElement) {
                stepElement.classList.add('active');
            }
            
            // Update step indicators
            document.querySelectorAll('.step').forEach((stepEl, index) => {
                stepEl.classList.remove('active', 'completed');
                if (index + 1 < step) {
                    stepEl.classList.add('completed');
                } else if (index + 1 === step) {
                    stepEl.classList.add('active');
                }
            });
        } catch (error) {
            console.error('Error in goToStep:', error);
        }
    }

    function initiatePayment() {
        if (totalAmount <= 0) {
            alert('Invalid amount. Please try again.');
            return;
        }

        // Create booking and redirect to payment
        fetch(contextPath + '/customer/scholar/create-booking', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                scholarId: scholarId,
                serviceId: selectedPackage,
                amount: totalAmount,
                addons: addons
            })
        })
        .then(response => response.json())
        .then(data => {
            if (data.error) {
                alert('Error: ' + data.error);
                return;
            }
            
            if (data.bookingId) {
                // Redirect to existing payment page
                window.location.href = contextPath + '/customer/scholar/payment/initiate?bookingId=' + data.bookingId;
            } else {
                alert('Error creating booking. Please try again.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Error initiating payment. Please try again.');
        });
    }
    
    // Prevent page reload on errors
    window.addEventListener('error', function(e) {
        e.preventDefault();
        console.error('JavaScript error prevented:', e.error);
        return true;
    });
    
    // Ensure page doesn't reload automatically
    window.addEventListener('beforeunload', function(e) {
        // Only prevent if there's unsaved data
        if (selectedPackage) {
            // Allow normal navigation
            return undefined;
        }
    });
</script>

</body>
</html>

