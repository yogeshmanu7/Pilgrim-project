<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../includes/header.jsp"/>

<h2>Step 3 of 5: GST Details</h2>
<form action="${pageContext.request.contextPath}/pilgrim/travel/agency/gst-details" method="post" class="mt-3">
    <input type="hidden" name="agencyId" value="${agencyId}"/>

    <div class="mb-3">
        <label>State Name *</label>
        <input type="text" name="stateName" class="form-control" required/>
    </div>

    <div class="mb-3">
        <label>State Code *</label>
        <input type="text" name="stateCode" class="form-control" required/>
    </div>

    <div class="mb-3">
        <label>GSTIN *</label>
        <input type="text" name="gstin" class="form-control" required/>
    </div>

    <div class="mb-3">
        <label>Is Head Office? *</label>
        <select name="headOffice" class="form-control" required>
            <c:forEach var="option" items="${headOfficeOptions}">
                <option value="${option}">${option}</option>
            </c:forEach>
        </select>
    </div>

    <div class="mb-3">
        <label>GST Status *</label>
        <select name="gstStatus" class="form-control" required>
            <c:forEach var="status" items="${gstStatuses}">
                <option value="${status}">${status}</option>
            </c:forEach>
        </select>
    </div>

    <div class="d-flex justify-content-between mt-4">
        <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/bank-details" class="btn btn-secondary">← Back</a>
        <button type="submit" class="btn btn-primary">Next → Documents</button>
    </div>
</form>

<jsp:include page="../includes/footer.jsp"/>

