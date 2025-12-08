<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<c:set var="pageTitle" value="Scholar Bookings" scope="request"/>
<c:set var="currentPage" value="scholar_bookings" scope="request"/>
<%@ include file="../common/header.jsp" %>

<div class="container-fluid mt-4">
    <div class="card shadow-sm">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h5 class="card-title mb-0"><i class="fas fa-calendar-check me-2 text-purple"></i>All Scholar Bookings</h5>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover table-striped align-middle">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Customer</th>
                            <th>Scholar</th>
                            <th>Service Date</th>
                            <th>Service Type</th>
                            <th>Amount</th>
                            <th>Status</th>
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
                                    <strong>${booking.scholar.user.name}</strong><br>
                                    <small class="text-muted">${booking.scholar.type}</small>
                                </td>
                                <td>${booking.serviceDate != null ? booking.serviceDate.toString().replace('T', ' ').substring(0, 16) : 'N/A'}</td>
                                <td><span class="badge bg-info">${booking.serviceType}</span></td>
                                <td>₹<fmt:formatNumber value="${booking.totalAmount}" pattern="#,##,##0.00"/></td>
                                <td>
                                    <span class="badge bg-${booking.status == 'CONFIRMED' ? 'success' : booking.status == 'REJECTED' ? 'danger' : booking.status == 'COMPLETED' ? 'primary' : 'warning'}">
                                        ${booking.status}
                                    </span>
                                </td>
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
                                <td colspan="8" class="text-center">No bookings found.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>

