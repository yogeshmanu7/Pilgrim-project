<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<c:set var="pageTitle" value="Dashboard" scope="request"/>
<c:set var="currentPage" value="dashboard" scope="request"/>
<%@ include file="common/header.jsp" %>

<!-- Welcome Banner -->
<div class="card mb-4" style="background: linear-gradient(135deg, var(--celestial-blue) 0%, var(--bg-dark) 100%); border: none; overflow: hidden; position: relative;">
    <div class="card-body py-4">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h2 class="text-white mb-2" style="font-family: 'Cormorant Garamond', serif; font-size: 2rem;">
                    <i class="fas fa-globe-americas me-2" style="color: var(--primary-teal);"></i>
                    Welcome to Global Pilgrim
                </h2>
                <p class="text-secondary mb-0">Connecting pilgrims with sacred places across all faiths and traditions worldwide.</p>
            </div>
            <div class="col-md-4 text-end">
                <div class="d-flex gap-2 justify-content-end flex-wrap">
                    <span class="religion-badge religion-all"><i class="fas fa-infinity"></i> All Faiths</span>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Dashboard Stats - Row 1: Scholar Module -->
<div class="row g-4 mb-4">
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon purple">
                <i class="fas fa-user-graduate"></i>
            </div>
            <div class="stat-value">${stats.totalScholars != null ? stats.totalScholars : 0}</div>
            <div class="stat-label">Scholars/Astrologers</div>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon rose">
                <i class="fas fa-users"></i>
            </div>
            <div class="stat-value">${stats.totalUsers != null ? stats.totalUsers : 0}</div>
            <div class="stat-label">Total Users</div>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon gold">
                <i class="fas fa-store"></i>
            </div>
            <div class="stat-value">${stats.totalVendors != null ? stats.totalVendors : 0}</div>
            <div class="stat-label">Pooja Vendors</div>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon teal">
                <i class="fas fa-hands-praying"></i>
            </div>
            <div class="stat-value">${stats.totalPoojaItems != null ? stats.totalPoojaItems : 0}</div>
            <div class="stat-label">Pooja Items</div>
        </div>
    </div>
</div>

<!-- Dashboard Stats - Row 2: Accommodation Module -->
<div class="row g-4 mb-4">
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon blue">
                <i class="fas fa-building"></i>
            </div>
            <div class="stat-value">${stats.totalProperties != null ? stats.totalProperties : 0}</div>
            <div class="stat-label">Properties</div>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon teal">
                <i class="fas fa-user-tie"></i>
            </div>
            <div class="stat-value">${stats.totalAccommodationUsers != null ? stats.totalAccommodationUsers : 0}</div>
            <div class="stat-label">Accommodation Users</div>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon purple">
                <i class="fas fa-calendar-check"></i>
            </div>
            <div class="stat-value">${stats.totalAccommodationBookings != null ? stats.totalAccommodationBookings : 0}</div>
            <div class="stat-label">Accommodation Bookings</div>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon gold">
                <i class="fas fa-shopping-cart"></i>
            </div>
            <div class="stat-value">${stats.totalPoojaOrders != null ? stats.totalPoojaOrders : 0}</div>
            <div class="stat-label">Pooja Orders</div>
        </div>
    </div>
</div>

<!-- Dashboard Stats - Row 3: Travel Module -->
<div class="row g-4 mb-4">
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon blue">
                <i class="fas fa-plane"></i>
            </div>
            <div class="stat-value">${stats.totalTravelAgencies != null ? stats.totalTravelAgencies : 0}</div>
            <div class="stat-label">Travel Agencies</div>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon teal">
                <i class="fas fa-suitcase"></i>
            </div>
            <div class="stat-value">${stats.totalTravelPackages != null ? stats.totalTravelPackages : 0}</div>
            <div class="stat-label">Travel Packages</div>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon purple">
                <i class="fas fa-calendar-check"></i>
            </div>
            <div class="stat-value">${stats.totalTravelBookings != null ? stats.totalTravelBookings : 0}</div>
            <div class="stat-label">Travel Bookings</div>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon gold">
                <i class="fas fa-user-tie"></i>
            </div>
            <div class="stat-value">${stats.totalGuides != null ? stats.totalGuides : 0}</div>
            <div class="stat-label">Guides</div>
        </div>
    </div>
</div>

<!-- Dashboard Stats - Row 4: Travel Transport -->
<div class="row g-4 mb-4">
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon blue">
                <i class="fas fa-bus"></i>
            </div>
            <div class="stat-value">${stats.totalTransport != null ? stats.totalTransport : 0}</div>
            <div class="stat-label">Transport Options</div>
        </div>
    </div>
</div>

<!-- Dashboard Stats - Row 5: Temple Module -->
<div class="row g-4 mb-4">
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon gold">
                <i class="fas fa-place-of-worship"></i>
            </div>
            <div class="stat-value">${stats.totalTemples != null ? stats.totalTemples : 0}</div>
            <div class="stat-label">Temples</div>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon teal">
                <i class="fas fa-eye"></i>
            </div>
            <div class="stat-value">${stats.totalDarshanBookings != null ? stats.totalDarshanBookings : 0}</div>
            <div class="stat-label">Darshan Bookings</div>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon purple">
                <i class="fas fa-hands-praying"></i>
            </div>
            <div class="stat-value">${stats.totalPoojaBookings != null ? stats.totalPoojaBookings : 0}</div>
            <div class="stat-label">Pooja Bookings</div>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon rose">
                <i class="fas fa-gift"></i>
            </div>
            <div class="stat-value">${stats.totalPrasadhamOrders != null ? stats.totalPrasadhamOrders : 0}</div>
            <div class="stat-label">Prasadham Orders</div>
        </div>
    </div>
</div>

<!-- Dashboard Stats - Row 6: Temple Module (continued) -->
<div class="row g-4 mb-4">
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon blue">
                <i class="fas fa-route"></i>
            </div>
            <div class="stat-value">${stats.totalTourBookings != null ? stats.totalTourBookings : 0}</div>
            <div class="stat-label">Tour Bookings</div>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6">
        <div class="stat-card">
            <div class="stat-icon teal">
                <i class="fas fa-heart"></i>
            </div>
            <div class="stat-value">${stats.totalDonations != null ? stats.totalDonations : 0}</div>
            <div class="stat-label">Donations</div>
        </div>
    </div>
</div>

<!-- Revenue Summary Cards -->
<div class="row g-4 mb-4">
    <div class="col-xl-3 col-md-6">
        <div class="card h-100" style="background: linear-gradient(135deg, var(--primary-teal) 0%, var(--primary-teal-dark) 100%); border: none;">
            <div class="card-body text-center">
                <i class="fas fa-calendar-day fa-2x mb-3 text-white opacity-75"></i>
                <h3 class="text-white mb-1">₹<fmt:formatNumber value="${stats.todayRevenue != null ? stats.todayRevenue : 0}" pattern="#,##,##0.00"/></h3>
                <p class="text-white mb-0 fw-bold opacity-75">Today's Revenue</p>
            </div>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6">
        <div class="card h-100" style="background: linear-gradient(135deg, var(--accent-purple) 0%, #7C3AED 100%); border: none;">
            <div class="card-body text-center">
                <i class="fas fa-calendar-week fa-2x mb-3 text-white opacity-75"></i>
                <h3 class="text-white mb-1">₹<fmt:formatNumber value="${stats.weeklyRevenue != null ? stats.weeklyRevenue : 0}" pattern="#,##,##0.00"/></h3>
                <p class="text-white mb-0 fw-bold opacity-75">Last 7 Days</p>
            </div>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6">
        <div class="card h-100" style="background: linear-gradient(135deg, #22c55e 0%, #16a34a 100%); border: none;">
            <div class="card-body text-center">
                <i class="fas fa-calendar-alt fa-2x mb-3 text-white opacity-75"></i>
                <h3 class="text-white mb-1">₹<fmt:formatNumber value="${stats.monthlyRevenue != null ? stats.monthlyRevenue : 0}" pattern="#,##,##0.00"/></h3>
                <p class="text-white mb-0 fw-bold opacity-75">This Month</p>
            </div>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6">
        <div class="card h-100" style="background: linear-gradient(135deg, var(--sacred-gold) 0%, var(--warm-amber) 100%); border: none;">
            <div class="card-body text-center">
                <i class="fas fa-chart-line fa-2x mb-3 text-white opacity-75"></i>
                <h3 class="text-white mb-1">₹<fmt:formatNumber value="${stats.totalRevenue != null ? stats.totalRevenue : 0}" pattern="#,##,##0.00"/></h3>
                <p class="text-white mb-0 fw-bold opacity-75">Total Revenue</p>
            </div>
        </div>
    </div>
</div>

<!-- Categorized Revenue Section -->
<div class="row g-4 mb-4">
    <!-- Today's Revenue by Category -->
    <div class="col-xl-6">
        <div class="card h-100">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="card-title mb-0"><i class="fas fa-chart-pie me-2 text-teal"></i>Today's Revenue by Category</h5>
                <span class="badge bg-teal">₹<fmt:formatNumber value="${stats.todayRevenue != null ? stats.todayRevenue : 0}" pattern="#,##,##0.00"/></span>
            </div>
            <div class="card-body">
                <c:forEach var="entry" items="${stats.todayRevenueByCategory}">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div class="d-flex align-items-center">
                            <c:choose>
                                <c:when test="${entry.key == 'Pooja Items'}">
                                    <span class="badge bg-warning me-2"><i class="fas fa-hands-praying"></i></span>
                                    <span class="text-white">Ritual Items</span>
                                </c:when>
                                <c:when test="${entry.key == 'Darshana Tickets'}">
                                    <span class="badge bg-primary me-2"><i class="fas fa-ticket-alt"></i></span>
                                    <span class="text-white">Sacred Visits</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary me-2"><i class="fas fa-circle"></i></span>
                                    <span class="text-white">${entry.key}</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <span class="text-teal fw-bold">₹<fmt:formatNumber value="${entry.value}" pattern="#,##,##0.00"/></span>
                    </div>
                    <div class="progress mb-3" style="height: 6px; background: rgba(255,255,255,0.1); border-radius: 3px;">
                        <c:set var="percentage" value="${stats.todayRevenue > 0 ? (entry.value / stats.todayRevenue) * 100 : 0}"/>
                        <div class="progress-bar" role="progressbar" style="width: ${percentage}%; background: var(--primary-teal); border-radius: 3px;"></div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    
    <!-- This Month's Revenue by Category -->
    <div class="col-xl-6">
        <div class="card h-100">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="card-title mb-0"><i class="fas fa-chart-bar me-2 text-teal"></i>Monthly Revenue by Category</h5>
                <span class="badge bg-success">₹<fmt:formatNumber value="${stats.monthlyRevenue != null ? stats.monthlyRevenue : 0}" pattern="#,##,##0.00"/></span>
            </div>
            <div class="card-body">
                <c:forEach var="entry" items="${stats.monthlyRevenueByCategory}">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div class="d-flex align-items-center">
                            <c:choose>
                                <c:when test="${entry.key == 'Pooja Items'}">
                                    <span class="badge bg-warning me-2"><i class="fas fa-hands-praying"></i></span>
                                    <span class="text-white">Ritual Items</span>
                                </c:when>
                                <c:when test="${entry.key == 'Darshana Tickets'}">
                                    <span class="badge bg-primary me-2"><i class="fas fa-ticket-alt"></i></span>
                                    <span class="text-white">Sacred Visits</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary me-2"><i class="fas fa-circle"></i></span>
                                    <span class="text-white">${entry.key}</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <span class="text-success fw-bold">₹<fmt:formatNumber value="${entry.value}" pattern="#,##,##0.00"/></span>
                    </div>
                    <div class="progress mb-3" style="height: 6px; background: rgba(255,255,255,0.1); border-radius: 3px;">
                        <c:set var="percentage" value="${stats.monthlyRevenue > 0 ? (entry.value / stats.monthlyRevenue) * 100 : 0}"/>
                        <div class="progress-bar bg-success" role="progressbar" style="width: ${percentage}%; border-radius: 3px;"></div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<!-- Total Revenue by Category -->
<div class="row g-4 mb-4">
    <div class="col-12">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="card-title mb-0"><i class="fas fa-coins me-2 text-gold"></i>Total Revenue by Category (All Time)</h5>
                <span class="badge bg-gold fs-6">₹<fmt:formatNumber value="${stats.totalRevenue != null ? stats.totalRevenue : 0}" pattern="#,##,##0.00"/></span>
            </div>
            <div class="card-body">
                <div class="row g-4">
                    <c:forEach var="entry" items="${stats.totalRevenueByCategory}">
                        <div class="col-xl col-md-4 col-6">
                            <div class="text-center p-3 rounded" style="background: rgba(255,255,255,0.03); border: 1px solid var(--border-color);">
                                <c:choose>
                                    <c:when test="${entry.key == 'Pooja Items'}">
                                        <div class="rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" 
                                             style="width: 56px; height: 56px; background: linear-gradient(135deg, var(--sacred-gold), var(--warm-amber));">
                                            <i class="fas fa-hands-praying fa-lg text-white"></i>
                                        </div>
                                        <h4 class="text-teal mb-1">₹<fmt:formatNumber value="${entry.value}" pattern="#,##,##0"/></h4>
                                        <p class="text-secondary mb-0 small">Ritual Items</p>
                                    </c:when>
                                    <c:when test="${entry.key == 'Darshana Tickets'}">
                                        <div class="rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" 
                                             style="width: 56px; height: 56px; background: linear-gradient(135deg, var(--primary-teal), var(--primary-teal-dark));">
                                            <i class="fas fa-ticket-alt fa-lg text-white"></i>
                                        </div>
                                        <h4 class="text-teal mb-1">₹<fmt:formatNumber value="${entry.value}" pattern="#,##,##0"/></h4>
                                        <p class="text-secondary mb-0 small">Sacred Visits</p>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center" 
                                             style="width: 56px; height: 56px; background: linear-gradient(135deg, #64748b, #475569);">
                                            <i class="fas fa-circle fa-lg text-white"></i>
                                        </div>
                                        <h4 class="text-teal mb-1">₹<fmt:formatNumber value="${entry.value}" pattern="#,##,##0"/></h4>
                                        <p class="text-secondary mb-0 small">${entry.key}</p>
                                    </c:otherwise>
                                </c:choose>
                                <c:set var="percentage" value="${stats.totalRevenue > 0 ? (entry.value / stats.totalRevenue) * 100 : 0}"/>
                                <span class="badge bg-secondary mt-2"><fmt:formatNumber value="${percentage}" pattern="0.0"/>%</span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Alerts & Pending Actions -->
<div class="row g-4 mb-4">
    <div class="col-xl-3 col-md-6">
        <div class="card h-100">
            <div class="card-body text-center">
                <div class="stat-icon gold mx-auto mb-3">
                    <i class="fas fa-clock"></i>
                </div>
                <h3 class="text-white mb-1">${stats.pendingVerifications != null ? stats.pendingVerifications : 0}</h3>
                <p class="text-secondary mb-3">Pending Verifications</p>
                <div class="d-flex justify-content-around text-secondary small flex-wrap gap-2">
                    <span><i class="fas fa-store me-1"></i> ${stats.pendingVendors != null ? stats.pendingVendors : 0} Vendors</span>
                    <span><i class="fas fa-user-graduate me-1"></i> ${stats.pendingScholars != null ? stats.pendingScholars : 0} Scholars</span>
                    <span><i class="fas fa-building me-1"></i> ${stats.pendingProperties != null ? stats.pendingProperties : 0} Properties</span>
                    <span><i class="fas fa-plane me-1"></i> ${stats.pendingTravelAgencies != null ? stats.pendingTravelAgencies : 0} Travel Agencies</span>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6">
        <div class="card h-100">
            <div class="card-body text-center">
                <div class="stat-icon blue mx-auto mb-3">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <h3 class="text-white mb-1">${stats.pendingComplaints != null ? stats.pendingComplaints : 0}</h3>
                <p class="text-secondary mb-3">Pending Complaints</p>
                <a href="${pageContext.request.contextPath}/admin/accommodation/complaints" class="btn btn-sm btn-outline-primary mt-2">View</a>
            </div>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6">
        <div class="card h-100">
            <div class="card-body text-center">
                <div class="stat-icon teal mx-auto mb-3">
                    <i class="fas fa-money-bill-wave"></i>
                </div>
                <h3 class="text-white mb-1">${stats.pendingRefunds != null ? stats.pendingRefunds : 0}</h3>
                <p class="text-secondary mb-3">Pending Refunds</p>
                <a href="${pageContext.request.contextPath}/admin/accommodation/refunds" class="btn btn-sm btn-outline-primary mt-2">View</a>
            </div>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6">
        <div class="card h-100">
            <div class="card-body text-center">
                <div class="stat-icon purple mx-auto mb-3">
                    <i class="fas fa-hand-holding-usd"></i>
                </div>
                <h3 class="text-white mb-1">${stats.pendingPayouts != null ? stats.pendingPayouts : 0}</h3>
                <p class="text-secondary mb-3">Pending Payouts</p>
                <a href="${pageContext.request.contextPath}/admin/accommodation/payouts" class="btn btn-sm btn-outline-primary mt-2">View</a>
            </div>
        </div>
    </div>
    
    <div class="col-xl-4 col-md-6">
        <div class="card h-100">
            <div class="card-body text-center">
                <div class="stat-icon rose mx-auto mb-3">
                    <i class="fas fa-headset"></i>
                </div>
                <h3 class="text-white mb-1">${stats.unresolvedTickets != null ? stats.unresolvedTickets : 0}</h3>
                <p class="text-secondary mb-3">Unresolved Tickets</p>
                <div class="d-flex justify-content-around text-secondary small">
                    <span><i class="fas fa-folder-open me-1"></i> ${stats.openTickets} Open</span>
                    <span><i class="fas fa-spinner me-1"></i> ${stats.inProgressTickets} In Progress</span>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-xl-4 col-md-6">
        <div class="card h-100">
            <div class="card-body text-center">
                <div class="stat-icon blue mx-auto mb-3">
                    <i class="fas fa-user-plus"></i>
                </div>
                <h3 class="text-white mb-1">${stats.newUsersToday != null ? stats.newUsersToday : 0}</h3>
                <p class="text-secondary mb-0">New Pilgrims Today</p>
            </div>
        </div>
    </div>
</div>

<!-- Quick Actions -->
<div class="row g-4">
    <div class="col-12">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0"><i class="fas fa-bolt me-2 text-gold"></i>Quick Actions</h5>
            </div>
            <div class="card-body">
                <div class="row g-3">
                    <!-- Scholar Module -->
                    <div class="col-md-4 col-lg-2">
                        <a href="${pageContext.request.contextPath}/admin/scholars" class="btn btn-outline-primary w-100 py-3">
                            <i class="fas fa-user-graduate d-block mb-2" style="font-size: 1.5rem;"></i>
                            Manage Scholars
                        </a>
                    </div>
                    
                    <!-- Accommodation Module -->
                    <div class="col-md-4 col-lg-2">
                        <a href="${pageContext.request.contextPath}/admin/accommodation/properties" class="btn btn-outline-primary w-100 py-3">
                            <i class="fas fa-building d-block mb-2" style="font-size: 1.5rem;"></i>
                            Manage Properties
                        </a>
                    </div>
                    <div class="col-md-4 col-lg-2">
                        <a href="${pageContext.request.contextPath}/admin/accommodation/bookings" class="btn btn-outline-primary w-100 py-3">
                            <i class="fas fa-calendar-check d-block mb-2" style="font-size: 1.5rem;"></i>
                            Accommodation Bookings
                        </a>
                    </div>
                    
                    <!-- Pooja Module -->
                    <div class="col-md-4 col-lg-2">
                        <a href="${pageContext.request.contextPath}/admin/pooja/vendors/pending" class="btn btn-outline-primary w-100 py-3">
                            <i class="fas fa-user-check d-block mb-2" style="font-size: 1.5rem;"></i>
                            Verify Vendors
                        </a>
                    </div>
                    <div class="col-md-4 col-lg-2">
                        <a href="${pageContext.request.contextPath}/admin/pooja/items" class="btn btn-outline-primary w-100 py-3">
                            <i class="fas fa-hands-praying d-block mb-2" style="font-size: 1.5rem;"></i>
                            Pooja Items
                        </a>
                    </div>
                    <div class="col-md-4 col-lg-2">
                        <a href="${pageContext.request.contextPath}/admin/pooja/orders" class="btn btn-outline-primary w-100 py-3">
                            <i class="fas fa-shopping-cart d-block mb-2" style="font-size: 1.5rem;"></i>
                            Pooja Orders
                        </a>
                    </div>
                    
                    <!-- Travel Module -->
                    <div class="col-md-4 col-lg-2">
                        <a href="${pageContext.request.contextPath}/admin/travel/agencies/pending" class="btn btn-outline-primary w-100 py-3">
                            <i class="fas fa-plane d-block mb-2" style="font-size: 1.5rem;"></i>
                            Travel Agencies
                        </a>
                    </div>
                    <div class="col-md-4 col-lg-2">
                        <a href="${pageContext.request.contextPath}/admin/travel/packages" class="btn btn-outline-primary w-100 py-3">
                            <i class="fas fa-suitcase d-block mb-2" style="font-size: 1.5rem;"></i>
                            Travel Packages
                        </a>
                    </div>
                    <div class="col-md-4 col-lg-2">
                        <a href="${pageContext.request.contextPath}/admin/travel/bookings" class="btn btn-outline-primary w-100 py-3">
                            <i class="fas fa-calendar-check d-block mb-2" style="font-size: 1.5rem;"></i>
                            Travel Bookings
                        </a>
                    </div>
                    <div class="col-md-4 col-lg-2">
                        <a href="${pageContext.request.contextPath}/admin/travel/guides" class="btn btn-outline-primary w-100 py-3">
                            <i class="fas fa-user-tie d-block mb-2" style="font-size: 1.5rem;"></i>
                            Guides
                        </a>
                    </div>
                    <div class="col-md-4 col-lg-2">
                        <a href="${pageContext.request.contextPath}/admin/travel/transport" class="btn btn-outline-primary w-100 py-3">
                            <i class="fas fa-bus d-block mb-2" style="font-size: 1.5rem;"></i>
                            Transport
                        </a>
                    </div>
                    
                    <!-- Temple Module -->
                    <div class="col-md-4 col-lg-2">
                        <a href="${pageContext.request.contextPath}/pilgrim/temple/admin/dashboard" class="btn btn-outline-primary w-100 py-3">
                            <i class="fas fa-place-of-worship d-block mb-2" style="font-size: 1.5rem;"></i>
                            Temples
                        </a>
                    </div>
                    <div class="col-md-4 col-lg-2">
                        <a href="${pageContext.request.contextPath}/pilgrim/temple/admin/dashboard" class="btn btn-outline-primary w-100 py-3">
                            <i class="fas fa-eye d-block mb-2" style="font-size: 1.5rem;"></i>
                            Darshan Bookings
                        </a>
                    </div>
                    <div class="col-md-4 col-lg-2">
                        <a href="${pageContext.request.contextPath}/pilgrim/temple/admin/dashboard" class="btn btn-outline-primary w-100 py-3">
                            <i class="fas fa-hands-praying d-block mb-2" style="font-size: 1.5rem;"></i>
                            Pooja Bookings
                        </a>
                    </div>
                    <div class="col-md-4 col-lg-2">
                        <a href="${pageContext.request.contextPath}/pilgrim/temple/admin/dashboard" class="btn btn-outline-primary w-100 py-3">
                            <i class="fas fa-gift d-block mb-2" style="font-size: 1.5rem;"></i>
                            Prasadham Orders
                        </a>
                    </div>
                    <div class="col-md-4 col-lg-2">
                        <a href="${pageContext.request.contextPath}/pilgrim/temple/admin/dashboard" class="btn btn-outline-primary w-100 py-3">
                            <i class="fas fa-heart d-block mb-2" style="font-size: 1.5rem;"></i>
                            Donations
                        </a>
                    </div>
                    
                    <!-- General -->
                    <div class="col-md-4 col-lg-2">
                        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline-primary w-100 py-3">
                            <i class="fas fa-users d-block mb-2" style="font-size: 1.5rem;"></i>
                            Manage Users
                        </a>
                    </div>
                    <div class="col-md-4 col-lg-2">
                        <a href="${pageContext.request.contextPath}/admin/notifications/form" class="btn btn-outline-primary w-100 py-3">
                            <i class="fas fa-bell d-block mb-2" style="font-size: 1.5rem;"></i>
                            Send Notification
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
.progress {
    background-color: rgba(255,255,255,0.1);
}
</style>

<%@ include file="common/footer.jsp" %>

