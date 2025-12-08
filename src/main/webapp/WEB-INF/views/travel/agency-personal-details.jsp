<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../includes/header.jsp"/>

<h2>Step 1 of 5: Personal Details</h2>
<form action="${pageContext.request.contextPath}/pilgrim/travel/agency/personal-details" method="post" class="mt-3">
    <input type="hidden" name="agencyId" value="${agencyId}"/>

    <div class="mb-3"><label>Travels Name *</label><input type="text" name="travelsName" class="form-control" required/></div>
    <div class="mb-3"><label>Owner Name *</label><input type="text" name="ownerName" class="form-control" required/></div>

    <div class="mb-3"><label>Business Background *</label>
        <select name="businessBackground" class="form-control" required>
            <c:forEach var="option" items="${businessOptions}">
                <option value="${option}">${option}</option>
            </c:forEach>
        </select>
    </div>

    <div class="mb-3"><label>Business Background (Other)</label><input type="text" name="businessBackgroundOther" class="form-control"/></div>

    <div class="mb-3"><label>Pincode *</label><input type="text" name="pincode" class="form-control" required/></div>
    <div class="mb-3"><label>Country *</label><input type="text" name="country" value="India" class="form-control" required/></div>
    <div class="mb-3"><label>State *</label><input type="text" name="state" class="form-control" required/></div>
    <div class="mb-3"><label>District *</label><input type="text" name="district" class="form-control" required/></div>
    <div class="mb-3"><label>City *</label><input type="text" name="city" class="form-control" required/></div>
    <div class="mb-3"><label>Address *</label><textarea name="address" class="form-control" required></textarea></div>

    <div class="mb-3"><label>Mobile *</label><input type="text" name="mobile" class="form-control" required/></div>
    <div class="mb-3"><label>Phone</label><input type="text" name="phone" class="form-control"/></div>
    <div class="mb-3"><label>Email Id *</label><input type="email" name="email" class="form-control" required/></div>
    <div class="mb-3"><label>Alternate Email Id</label><input type="email" name="alternateEmail" class="form-control"/></div>

    <div class="mb-3"><label>PAN *</label><input type="text" name="pan" class="form-control" required/></div>

    <div class="mb-3"><label>MSME? *</label>
        <select name="msmeStatus" class="form-control" required>
            <c:forEach var="status" items="${msmeOptions}">
                <option value="${status}">${status}</option>
            </c:forEach>
        </select>
    </div>

    <div class="mb-3"><label>MSME Number</label><input type="text" name="msmeNumber" class="form-control"/></div>
    <div class="mb-3"><label>CIN *</label><input type="text" name="cin" class="form-control" required/></div>

    <div class="d-flex justify-content-end mt-4">
        <button type="submit" class="btn btn-primary">Next → Bank Details</button>
    </div>
</form>

<jsp:include page="../includes/footer.jsp"/>

