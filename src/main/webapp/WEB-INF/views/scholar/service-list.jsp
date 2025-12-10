<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Services - GlobalPiligrim</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-list me-2"></i>My Services</h2>
            <a href="${pageContext.request.contextPath}/scholar/service/add" class="btn btn-primary">
                <i class="fas fa-plus me-2"></i>Add New Service
            </a>
        </div>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:choose>
            <c:when test="${empty services || services.size() == 0}">
                <div class="alert alert-info">
                    <i class="fas fa-info-circle me-2"></i>No services added yet. 
                    <a href="${pageContext.request.contextPath}/scholar/service/add">Add your first service</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>Service Name</th>
                                <th>Description</th>
                                <th>Price With Items</th>
                                <th>Price Without Items</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="service" items="${services}">
                                <tr>
                                    <td><strong>${service.name}</strong></td>
                                    <td>${service.description != null ? (service.description.length() > 50 ? fn:substring(service.description, 0, 50) : service.description) : '-'}</td>
                                    <td>₹<fmt:formatNumber value="${service.priceWithItems}" pattern="#,##0.00"/></td>
                                    <td>₹<fmt:formatNumber value="${service.priceWithoutItems}" pattern="#,##0.00"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${service.isActive}">
                                                <span class="badge bg-success">Active</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">Inactive</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/scholar/service/edit?id=${service.id}" 
                                           class="btn btn-sm btn-primary me-1" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <form method="post" action="${pageContext.request.contextPath}/scholar/service/toggle" 
                                              style="display: inline;" onsubmit="return confirm('Are you sure?');">
                                            <input type="hidden" name="id" value="${service.id}">
                                            <button type="submit" class="btn btn-sm ${service.isActive ? 'btn-warning' : 'btn-success'}" 
                                                    title="${service.isActive ? 'Deactivate' : 'Activate'}">
                                                <i class="fas fa-${service.isActive ? 'eye-slash' : 'eye'}"></i>
                                            </button>
                                        </form>
                                        <form method="post" action="${pageContext.request.contextPath}/scholar/service/delete" 
                                              style="display: inline;" onsubmit="return confirm('Are you sure you want to delete this service?');">
                                            <input type="hidden" name="id" value="${service.id}">
                                            <button type="submit" class="btn btn-sm btn-danger" title="Delete">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
        
        <div class="mt-3">
            <a href="${pageContext.request.contextPath}/scholar/dashboard" class="btn btn-secondary">
                <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
            </a>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

