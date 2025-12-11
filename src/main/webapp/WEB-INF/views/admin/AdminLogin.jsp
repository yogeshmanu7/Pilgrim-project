<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Admin Login - GlobalPiligrim</title>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
   <style>
       body {
           background: linear-gradient(135deg, #eb3349 0%, #f45c43 100%);
           min-height: 100vh;
           display: flex;
           align-items: center;
           padding: 40px 0;
       }
       .login-card {
           box-shadow: 0 10px 30px rgba(0,0,0,0.3);
       }
   </style>
</head>
<body>
   <div class="container">
       <div class="card login-card mx-auto" style="max-width: 450px;">
           <div class="card-body p-5">
               <div class="text-center mb-4">
                   <i class="fas fa-user-shield fa-3x text-danger mb-3"></i>
                   <h2 class="text-danger mb-2">Admin Login</h2>
                   <p class="text-muted">GlobalPiligrim Admin Portal</p>
               </div>
              
               <c:if test="${not empty error}">
                   <div class="alert alert-danger alert-dismissible fade show" role="alert">
                       <i class="fas fa-exclamation-circle me-2"></i>${error}
                       <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                   </div>
               </c:if>
              
               <c:if test="${not empty success}">
                   <div class="alert alert-success alert-dismissible fade show" role="alert">
                       <i class="fas fa-check-circle me-2"></i>${success}
                       <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                   </div>
               </c:if>
              
               <form method="post" action="${pageContext.request.contextPath}/admin/login">
                   <div class="mb-3">
                       <label class="form-label">
                           <i class="fas fa-envelope me-2"></i>Email Address
                       </label>
                       <input type="email" name="email" class="form-control" required autofocus>
                   </div>
                  
                   <div class="mb-3">
                       <label class="form-label">
                           <i class="fas fa-lock me-2"></i>Password
                       </label>
                       <input type="password" name="password" class="form-control" required>
                   </div>
                  
                   <div class="d-grid mb-3">
                       <button type="submit" class="btn btn-danger btn-lg">
                           <i class="fas fa-sign-in-alt me-2"></i>Login
                       </button>
                   </div>
               </form>
              
               <div class="text-center">
                   <a href="${pageContext.request.contextPath}/admin/forgot-password" class="text-decoration-none">
                       <i class="fas fa-key me-1"></i>Forgot Password?
                   </a>
               </div>
              
               <hr class="my-4">
              
               <div class="text-center mb-3">
                   <p class="mb-2 text-muted">Don't have an admin account?</p>
                   <a href="${pageContext.request.contextPath}/admin/register/step1" class="btn btn-outline-danger btn-lg">
                       <i class="fas fa-user-plus me-2"></i>Register / Sign Up
                   </a>
               </div>
              
               <hr class="my-4">
              
               <div class="text-center">
                   <p class="mb-2 text-muted">Not an admin?</p>
                   <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-primary btn-sm me-2">
                       <i class="fas fa-user me-1"></i>Customer Login
                   </a>
                   <a href="${pageContext.request.contextPath}/scholar/login" class="btn btn-outline-secondary btn-sm">
                       <i class="fas fa-user-graduate me-1"></i>Scholar Login
                   </a>
               </div>
           </div>
       </div>
   </div>
  
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

