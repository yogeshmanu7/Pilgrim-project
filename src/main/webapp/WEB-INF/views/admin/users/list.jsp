<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="pageTitle" value="Pilgrims" scope="request"/>
<c:set var="currentPage" value="users" scope="request"/>
<%@ include file="../common/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <div class="d-flex gap-2">
        <form class="d-flex" action="${pageContext.request.contextPath}/admin/users" method="get">
            <input type="text" name="search" class="form-control me-2" placeholder="Search pilgrims..." value="${search}" style="width: 300px;">
            <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i></button>
        </form>
        <a href="?filter=blocked" class="btn ${filter == 'blocked' ? 'btn-danger' : 'btn-outline-primary'}">
            <i class="fas fa-ban me-1"></i> Blocked
        </a>
    </div>
</div>

<div class="card">
    <div class="card-header d-flex justify-content-between align-items-center">
        <h5 class="card-title mb-0"><i class="fas fa-users me-2 text-teal"></i>All Pilgrims</h5>
        <span class="religion-badge religion-all"><i class="fas fa-globe-americas me-1"></i> Global Community</span>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Status</th>
                        <th>Joined</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${users.content}" var="user">
                        <tr>
                            <td>#${user.id}</td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <div style="width: 40px; height: 40px; border-radius: 50%; margin-right: 12px; background: linear-gradient(135deg, var(--primary-teal), var(--accent-purple)); display: flex; align-items: center; justify-content: center; color: white; font-weight: 600;">
                                        ${user.name.charAt(0)}
                                    </div>
                                    <strong>${user.name}</strong>
                                </div>
                            </td>
                            <td>${user.email}</td>
                            <td>${user.phone}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${user.blocked}">
                                        <span class="badge badge-rejected">Blocked</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-active">Active</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${user.createdAt.toLocalDate()}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/users/view/${user.id}" class="btn btn-sm btn-outline-primary me-1">
                                    <i class="fas fa-eye"></i>
                                </a>
                                <c:choose>
                                    <c:when test="${user.blocked}">
                                        <form action="${pageContext.request.contextPath}/admin/users/unblock/${user.id}" method="post" style="display: inline;">
                                            <button type="submit" class="btn btn-sm btn-success" title="Unblock">
                                                <i class="fas fa-unlock"></i>
                                            </button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <button type="button" class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#blockModal${user.id}">
                                            <i class="fas fa-ban"></i>
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        
                        <!-- Block Modal -->
                        <div class="modal fade" id="blockModal${user.id}" tabindex="-1">
                            <div class="modal-dialog">
                                <div class="modal-content" style="background: var(--card-bg); border: 1px solid var(--border-color);">
                                    <div class="modal-header" style="border-color: var(--border-color);">
                                        <h5 class="modal-title text-teal">Block Pilgrim</h5>
                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                    </div>
                                    <form action="${pageContext.request.contextPath}/admin/users/block/${user.id}" method="post">
                                        <div class="modal-body">
                                            <p>Are you sure you want to block ${user.name}?</p>
                                            <div class="mb-3">
                                                <label class="form-label">Reason</label>
                                                <textarea name="reason" class="form-control" required placeholder="Please provide a reason for blocking"></textarea>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="border-color: var(--border-color);">
                                            <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">Cancel</button>
                                            <button type="submit" class="btn btn-danger">Block Pilgrim</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty users.content}">
                        <tr>
                            <td colspan="7" class="text-center py-5 text-secondary">
                                <i class="fas fa-users fa-3x mb-3 d-block" style="opacity: 0.5;"></i>
                                <p class="mb-0">No pilgrims found</p>
                                <small>Pilgrims will appear here once they register</small>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
        
        <c:if test="${users.totalPages > 1}">
            <nav class="mt-4">
                <ul class="pagination justify-content-center">
                    <c:forEach begin="0" end="${users.totalPages - 1}" var="i">
                        <li class="page-item ${users.number == i ? 'active' : ''}">
                            <a class="page-link" href="?page=${i}&search=${search}&filter=${filter}">${i + 1}</a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
        </c:if>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
