<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Customer Login" />
<%@ include file="../common/header.jsp" %>

<div class="card" style="max-width: 400px; margin: 2rem auto;">
    <h2>Customer Login</h2>
    
    <c:if test="${not empty error}">
        <div class="alert alert-error">${error}</div>
    </c:if>
    
    <div style="text-align: center; padding: 2rem;">
        <p>Please use the main login page to access pooja services.</p>
        <a href="${pageContext.request.contextPath}/login" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">Go to Login</a>
        <a href="${pageContext.request.contextPath}/register" class="btn" style="width: 100%; text-align: center; display: block; margin-top: 1rem;">New Customer? Register</a>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>


