<jsp:include page="../includes/header.jsp"/>

<h2>Agency Login</h2>
<form action="${pageContext.request.contextPath}/pilgrim/travel/agency/login" method="post" class="mt-3">
    <div class="mb-3">
        <label>Email or Mobile *</label>
        <input type="text" name="emailOrMobile" class="form-control" required/>
    </div>
    <div class="mb-3">
        <label>Password *</label>
        <input type="password" name="password" class="form-control" required/>
    </div>
    <button type="submit" class="btn btn-primary">Login</button>
</form>

<p class="text-danger">${error}</p>

<div class="mt-3">
    <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/forgot-password">Forgot Password?</a>
</div>

<hr/>

<div class="mt-3">
    <p>Not a member yet?</p>
    <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/register" class="btn btn-success">Register First</a>
</div>

<jsp:include page="../includes/footer.jsp"/>

