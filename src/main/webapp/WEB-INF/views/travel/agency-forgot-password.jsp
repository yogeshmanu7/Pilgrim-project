<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../includes/header.jsp"/>
<h2>Forgot Password</h2>
<c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
</c:if>
<form action="${pageContext.request.contextPath}/pilgrim/travel/agency/forgot-password/send-otp" method="post">
    <div class="mb-3">
        <label>Email *</label>
        <input type="email" name="email" class="form-control" required/>
    </div>
    <button type="submit" class="btn btn-primary">Send OTP</button>
</form>
<jsp:include page="../includes/footer.jsp"/>

