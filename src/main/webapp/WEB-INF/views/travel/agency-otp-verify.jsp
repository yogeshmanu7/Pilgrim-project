<jsp:include page="../includes/header.jsp"/>

<h2>Verify OTP</h2>
<form action="${pageContext.request.contextPath}/pilgrim/travel/agency/verify-otp" method="post" class="mt-3">
    <input type="hidden" name="email" value="${email}"/>
    <div class="mb-3">
        <label>Enter OTP *</label>
        <input type="text" name="otp" class="form-control" required/>
    </div>
    <button type="submit" class="btn btn-success">Verify</button>
</form>
<p class="text-danger">${error}</p>

<jsp:include page="../includes/footer.jsp"/>

