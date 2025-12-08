<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../includes/header.jsp"/>
<h2>Reset Password</h2>
<c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
</c:if>
<form action="${pageContext.request.contextPath}/pilgrim/travel/agency/forgot-password/verify" method="post">
    <input type="hidden" name="email" value="${email}"/>
    <div class="mb-3">
        <label>OTP *</label>
        <input type="text" name="otp" class="form-control" required/>
    </div>
    <div class="mb-3">
        <label>New Password *</label>
        <input type="password" name="newPassword" class="form-control" required/>
    </div>
    <button type="submit" class="btn btn-success">Update Password</button>
</form>
<jsp:include page="../includes/footer.jsp"/>

