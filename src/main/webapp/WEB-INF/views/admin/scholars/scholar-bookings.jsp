<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<c:set var="pageTitle" value="Scholar Bookings" scope="request"/>
<c:set var="currentPage" value="scholars" scope="request"/>
<%@ include file="../common/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="mb-0">
        <i class="fas fa-calendar-check me-2 text-teal"></i>
        Bookings for ${scholar.user.name}
    </h2>
    <div>
        <a href="${pageContext.request.contextPath}/admin/scholars/view/${scholar.id}" class="btn btn-secondary me-2">
            <i class="fas fa-arrow-left me-1"></i>Back to Scholar
        </a>
        <a href="${pageContext.request.contextPath}/admin/scholars" class="btn btn-outline-secondary">
            <i class="fas fa-list me-1"></i>All Scholars
        </a>
    </div>
</div>

<div class="card mb-3">
    <div class="card-body">
        <div class="row">
            <div class="col-md-3">
                <strong>Type:</strong> 
                <span class="badge ${scholar.type == 'ASTROLOGER' ? 'bg-info' : 'bg-purple'}">
                    ${scholar.type == 'ASTROLOGER' ? 'Astrologer' : 'Spiritual Scholar'}
                </span>
            </div>
            <div class="col-md-3">
                <strong>Email:</strong> ${scholar.user.email}
            </div>
            <div class="col-md-3">
                <strong>Phone:</strong> ${scholar.user.phone}
            </div>
            <div class="col-md-3">
                <strong>Total Bookings:</strong> ${bookings.size()}
            </div>
        </div>
    </div>
</div>

<div class="card">
    <div class="card-header">
        <h5 class="card-title mb-0">Booking History</h5>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Customer</th>
                        <th>Service Type</th>
                        <th>Service Date</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Booking Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${bookings}" var="booking">
                        <tr>
                            <td>#${booking.id}</td>
                            <td>
                                <strong>${booking.customer.name}</strong><br>
                                <small class="text-muted">${booking.customer.email}</small>
                            </td>
                            <td>
                                <span class="badge bg-info">${booking.serviceType}</span>
                            </td>
                            <td>${booking.serviceDate != null ? booking.serviceDate.toString().replace('T', ' ').substring(0, 16) : 'N/A'}</td>
                            <td><strong>₹<fmt:formatNumber value="${booking.totalAmount != null ? booking.totalAmount : 0}" pattern="#,##,##0.00"/></strong></td>
                            <td>
                                <span class="badge bg-${booking.status == 'CONFIRMED' ? 'success' : booking.status == 'REJECTED' ? 'danger' : booking.status == 'COMPLETED' ? 'info' : 'warning'}">
                                    ${booking.status}
                                </span>
                            </td>
                            <td>${booking.bookingDate != null ? booking.bookingDate.toString().replace('T', ' ').substring(0, 16) : 'N/A'}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/scholars/bookings/view/${booking.id}" 
                                   class="btn btn-sm btn-info" title="View Details">
                                    <i class="fas fa-eye"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty bookings}">
                        <tr>
                            <td colspan="8" class="text-center py-4">
                                <p class="mb-0">No bookings found for this scholar</p>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>

