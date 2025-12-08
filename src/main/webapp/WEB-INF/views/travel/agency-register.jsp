<jsp:include page="../includes/header.jsp"/>

<h2>Agency Registration</h2>
<form action="${pageContext.request.contextPath}/pilgrim/travel/agency/register" method="post" class="mt-3">
    <div class="mb-3">
        <label>Email *</label>
        <input type="email" name="email" class="form-control" required/>
    </div>
    <div class="mb-3">
        <label>Mobile *</label>
        <input type="text" name="mobile" class="form-control" required/>
    </div>
    <div class="mb-3">
        <label>Password *</label>
        <input type="password" name="password" class="form-control" required/>
    </div>
    <button type="submit" class="btn btn-primary">Register</button>
</form>

<jsp:include page="../includes/footer.jsp"/>

