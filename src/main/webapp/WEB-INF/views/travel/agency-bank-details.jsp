<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../includes/header.jsp"/>

<h2>Step 2 of 5: Bank Details</h2>
<form action="${pageContext.request.contextPath}/pilgrim/travel/agency/bank-details" method="post" class="mt-3">
    <input type="hidden" name="agencyId" value="${agencyId}"/>

    <div class="mb-3">
        <label>Bank Name *</label>
        <input type="text" name="bankName" class="form-control" required/>
    </div>

    <div class="mb-3">
        <label>Account Number *</label>
        <input type="text" name="accountNumber" class="form-control" required/>
    </div>

    <div class="mb-3">
        <label>Beneficiary Name *</label>
        <input type="text" name="beneficiaryName" class="form-control" required/>
    </div>

    <div class="mb-3">
        <label>Account Type *</label>
        <select name="accountType" class="form-control" required>
            <c:forEach var="type" items="${accountTypes}">
                <option value="${type}">${type}</option>
            </c:forEach>
        </select>
    </div>

    <div class="mb-3">
        <label>IFSC Code *</label>
        <input type="text" name="ifsc" class="form-control" required/>
    </div>

    <div class="d-flex justify-content-between mt-4">
        <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/personal-details" class="btn btn-secondary">← Back</a>
        <button type="submit" class="btn btn-primary">Next → GST Details</button>
    </div>
</form>

<jsp:include page="../includes/footer.jsp"/>

