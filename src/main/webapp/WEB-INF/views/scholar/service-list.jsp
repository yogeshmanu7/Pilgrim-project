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
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&family=Merriweather:wght@300;400;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --dutch-white: #EFDFBB;
            --wine: #722F37;
            --wine-dark: #5A242B;
            --wine-light: rgba(114, 47, 55, 0.8);
            --wine-transparent: rgba(114, 47, 55, 0.1);
            --text-wine: #722F37;
            --text-cream: #EFDFBB;
            --border-wine: #722F37;
            --shadow-wine: 0 10px 30px rgba(114, 47, 55, 0.2);
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: var(--dutch-white);
            padding: 20px 0;
            position: relative;
        }
        
        /* Background Pattern */
        .bg-pattern {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 10% 20%, rgba(114, 47, 55, 0.05) 0%, transparent 50%),
                radial-gradient(circle at 90% 80%, rgba(114, 47, 55, 0.05) 0%, transparent 50%),
                repeating-linear-gradient(45deg, 
                    transparent, 
                    transparent 20px, 
                    rgba(114, 47, 55, 0.02) 20px, 
                    rgba(114, 47, 55, 0.02) 40px);
            z-index: 0;
        }
        
        .container {
            position: relative;
            z-index: 1;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: var(--shadow-wine);
            border: 2px solid var(--border-wine);
        }
        
        h1, h2, h3, h4, h5, h6 {
            font-family: 'Merriweather', serif;
            color: var(--text-wine);
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--wine) 0%, var(--wine-dark) 100%);
            border: none;
            color: var(--text-cream);
            font-weight: 600;
            border-radius: 8px;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, var(--wine-dark) 0%, var(--wine) 100%);
            color: var(--text-cream);
            transform: translateY(-2px);
            box-shadow: var(--shadow-wine);
        }
        
        .btn-secondary {
            background: var(--wine);
            border: none;
            color: var(--text-cream);
            border-radius: 8px;
        }
        
        .btn-secondary:hover {
            background: var(--wine-dark);
            color: var(--text-cream);
        }
        
        .btn-warning {
            background: #ffc107;
            border: none;
            color: #212529;
            border-radius: 8px;
        }
        
        .btn-success {
            background: #198754;
            border: none;
            color: white;
            border-radius: 8px;
        }
        
        .btn-danger {
            background: #dc3545;
            border: none;
            color: white;
            border-radius: 8px;
        }
        
        .alert {
            border: 2px solid;
            border-radius: 8px;
        }
        
        .alert-success {
            background: rgba(25, 135, 84, 0.1);
            border-color: #198754;
            color: #0f5132;
        }
        
        .alert-danger {
            background: rgba(220, 53, 69, 0.1);
            border-color: #dc3545;
            color: #721c24;
        }
        
        .alert-info {
            background: rgba(13, 202, 240, 0.1);
            border-color: #0dcaf0;
            color: #055160;
        }
        
        .alert-info a {
            color: var(--text-wine);
            font-weight: 600;
            text-decoration: none;
        }
        
        .alert-info a:hover {
            text-decoration: underline;
        }
        
        .table-dark {
            background: linear-gradient(135deg, var(--wine) 0%, var(--wine-dark) 100%) !important;
            color: var(--text-cream) !important;
        }
        
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(114, 47, 55, 0.05);
        }
        
        .table-hover tbody tr:hover {
            background-color: rgba(114, 47, 55, 0.1);
        }
        
        .table {
            border: 2px solid var(--border-wine);
            border-radius: 8px;
            overflow: hidden;
        }
        
        .badge.bg-success {
            background: #198754 !important;
        }
        
        .badge.bg-secondary {
            background: #6c757d !important;
        }
        
        .btn-close {
            background: transparent url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16' fill='%23722F37'%3e%3cpath d='M.293.293a1 1 0 0 1 1.414 0L8 6.586 14.293.293a1 1 0 1 1 1.414 1.414L9.414 8l6.293 6.293a1 1 0 0 1-1.414 1.414L8 9.414l-6.293 6.293a1 1 0 0 1-1.414-1.414L6.586 8 .293 1.707a1 1 0 0 1 0-1.414z'/%3e%3c/svg%3e") center/1em auto no-repeat;
        }
    </style>
</head>
<body>
    <!-- Background Pattern -->
    <div class="bg-pattern"></div>
    
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