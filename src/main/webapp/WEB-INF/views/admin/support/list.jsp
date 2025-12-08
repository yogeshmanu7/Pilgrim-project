<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="pageTitle" value="Support Tickets" scope="request"/>
<c:set var="currentPage" value="support" scope="request"/>
<%@ include file="../common/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <div class="d-flex gap-2">
        <select class="form-select" onchange="window.location.href='?status=' + this.value" style="width: 200px;">
            <option value="">All Status</option>
            <c:forEach items="${statuses}" var="status">
                <option value="${status}" ${selectedStatus == status ? 'selected' : ''}>${status}</option>
            </c:forEach>
        </select>
        <c:if test="${unresolvedCount > 0}">
            <span class="badge bg-warning align-self-center">${unresolvedCount} Unresolved</span>
        </c:if>
    </div>
</div>

<div class="card">
    <div class="card-header d-flex justify-content-between align-items-center">
        <h5 class="card-title mb-0"><i class="fas fa-headset me-2 text-teal"></i>Support Tickets</h5>
        <span class="religion-badge religion-all"><i class="fas fa-globe-americas me-1"></i> Pilgrim Support</span>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Ticket #</th>
                        <th>Subject</th>
                        <th>Pilgrim</th>
                        <th>Category</th>
                        <th>Priority</th>
                        <th>Status</th>
                        <th>Created</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${tickets.content}" var="ticket">
                        <tr>
                            <td><strong class="text-teal">${ticket.ticketNumber}</strong></td>
                            <td>${ticket.subject}</td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <div style="width: 30px; height: 30px; border-radius: 50%; margin-right: 8px; background: linear-gradient(135deg, var(--primary-teal), var(--accent-purple)); display: flex; align-items: center; justify-content: center; color: white; font-size: 0.7rem; font-weight: 600;">
                                        ${ticket.user != null ? ticket.user.name.charAt(0) : '?'}
                                    </div>
                                    ${ticket.user != null ? ticket.user.name : 'N/A'}
                                </div>
                            </td>
                            <td><span class="badge bg-secondary">${ticket.category}</span></td>
                            <td>
                                <span class="badge ${ticket.priority == 'URGENT' ? 'bg-danger' : ticket.priority == 'HIGH' ? 'bg-warning' : 'bg-info'}">
                                    ${ticket.priority}
                                </span>
                            </td>
                            <td>
                                <span class="badge badge-${ticket.status == 'RESOLVED' || ticket.status == 'CLOSED' ? 'approved' : 'pending'}">
                                    ${ticket.status}
                                </span>
                            </td>
                            <td>${ticket.createdAt.toLocalDate()}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/support/ticket/${ticket.id}" class="btn btn-sm btn-primary">
                                    <i class="fas fa-reply"></i> View
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty tickets.content}">
                        <tr>
                            <td colspan="8" class="text-center py-5 text-secondary">
                                <i class="fas fa-headset fa-3x mb-3 d-block" style="opacity: 0.5;"></i>
                                <p class="mb-0">No tickets found</p>
                                <small>Support tickets from pilgrims will appear here</small>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
        
        <c:if test="${tickets.totalPages > 1}">
            <nav class="mt-4">
                <ul class="pagination justify-content-center">
                    <c:forEach begin="0" end="${tickets.totalPages - 1}" var="i">
                        <li class="page-item ${tickets.number == i ? 'active' : ''}">
                            <a class="page-link" href="?page=${i}&status=${selectedStatus}">${i + 1}</a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
        </c:if>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
