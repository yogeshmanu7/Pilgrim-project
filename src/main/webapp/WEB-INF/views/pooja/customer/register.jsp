<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Customer Registration" />
<%@ include file="../common/header.jsp" %>

<div class="card">
    <h2>Customer Registration</h2>
    
    <c:if test="${not empty error}">
        <div class="alert alert-error">${error}</div>
    </c:if>
    
    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>
    
    <div style="text-align: center; padding: 2rem;">
        <p>Please use the main registration page to create an account.</p>
        <a href="${pageContext.request.contextPath}/register" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">Go to Registration</a>
        <a href="${pageContext.request.contextPath}/login" class="btn" style="width: 100%; text-align: center; display: block; margin-top: 1rem;">Already have an account? Login</a>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>


