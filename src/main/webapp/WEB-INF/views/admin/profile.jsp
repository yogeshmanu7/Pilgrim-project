<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="pageTitle" value="My Profile" scope="request"/>
<c:set var="currentPage" value="profile" scope="request"/>
<%@ include file="common/header.jsp" %>

<div class="row">
    <div class="col-lg-4">
        <div class="card mb-4">
            <div class="card-body text-center">
                <div class="position-relative d-inline-block mb-3">
                    <c:choose>
                        <c:when test="${not empty admin.profileImage}">
                            <img src="${pageContext.request.contextPath}/uploads/${admin.profileImage}" 
                                 alt="${admin.name}" 
                                 class="rounded-circle" 
                                 style="width: 120px; height: 120px; object-fit: cover; border: 4px solid var(--primary-teal);">
                        </c:when>
                        <c:otherwise>
                            <div class="rounded-circle d-flex align-items-center justify-content-center" 
                                 style="width: 120px; height: 120px; background: linear-gradient(135deg, var(--primary-teal), var(--accent-purple)); font-size: 3rem; color: white;">
                                ${admin.name.charAt(0)}
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <h4 class="text-white mb-1">${admin.name}</h4>
                <p class="text-secondary mb-1">${admin.email}</p>
                <p class="text-teal mb-3"><i class="fas fa-globe-americas me-1"></i> Global Pilgrim Admin</p>
                
                <form action="${pageContext.request.contextPath}/admin/profile/upload-image" method="post" enctype="multipart/form-data">
                    <div class="mb-2">
                        <input type="file" name="image" class="form-control form-control-sm" accept="image/*" required>
                    </div>
                    <button type="submit" class="btn btn-sm btn-outline-primary">
                        <i class="fas fa-camera me-1"></i> Update Photo
                    </button>
                </form>
            </div>
        </div>
    </div>
    
    <div class="col-lg-8">
        <div class="card mb-4">
            <div class="card-header">
                <h5 class="card-title mb-0"><i class="fas fa-user me-2 text-teal"></i>Profile Information</h5>
            </div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/admin/profile/update" method="post">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Full Name</label>
                                <input type="text" name="name" class="form-control" value="${admin.name}" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Email (Read-only)</label>
                                <input type="email" class="form-control" value="${admin.email}" readonly style="opacity: 0.7;">
                            </div>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Phone Number</label>
                        <input type="tel" name="phone" class="form-control" value="${admin.phone}" placeholder="+1 234 567 8900">
                    </div>
                    
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save me-2"></i> Update Profile
                    </button>
                </form>
            </div>
        </div>
        
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0"><i class="fas fa-key me-2 text-teal"></i>Change Password</h5>
            </div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/admin/profile/change-password" method="post">
                    <div class="mb-3">
                        <label class="form-label">Current Password</label>
                        <input type="password" name="currentPassword" class="form-control" required placeholder="Enter current password">
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">New Password</label>
                                <input type="password" name="newPassword" class="form-control" required minlength="6" placeholder="Enter new password">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">Confirm New Password</label>
                                <input type="password" name="confirmPassword" class="form-control" required minlength="6" placeholder="Confirm new password">
                            </div>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn btn-danger">
                        <i class="fas fa-key me-2"></i> Change Password
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="common/footer.jsp" %>
