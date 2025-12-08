<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../../includes/header.jsp"/>

<div class="container mt-4">

    <h2>Travel Agency Details</h2>

    <c:if test="${not empty agency}">
        <h4>${agency.travelsName}</h4>
        <p><b>Email:</b> ${agency.email}</p>
        <p><b>Mobile:</b> ${agency.mobile}</p>
        <p><b>Status:</b> ${agency.approvalStatus}</p>

        <c:if test="${not empty personal}">
            <p><b>Owner:</b> ${personal.ownerName}</p>
            <p><b>Address:</b> ${personal.address}</p>
            <p><b>PAN:</b> ${personal.pan}</p>
        </c:if>

        <c:if test="${not empty bank}">
            <p><b>Bank:</b> ${bank.bankName} (${bank.accountNumber})</p>
        </c:if>

        <c:if test="${not empty gst}">
            <p><b>GSTIN:</b> ${gst.gstin}</p>
        </c:if>

        <h5>Uploaded Documents</h5>
        <ul>
            <c:if test="${not empty documents.cancelledCheque}">
                <li>
                    Cancelled Cheque:
                    <a href="${pageContext.request.contextPath}${documents.cancelledCheque}" target="_blank">View</a>
                </li>
            </c:if>
            <c:if test="${not empty documents.panCard}">
                <li>
                    PAN Card:
                    <a href="${pageContext.request.contextPath}${documents.panCard}" target="_blank">View</a>
                </li>
            </c:if>
            <c:if test="${not empty documents.gstCertificate}">
                <li>
                    GST Certificate:
                    <a href="${pageContext.request.contextPath}${documents.gstCertificate}" target="_blank">View</a>
                </li>
            </c:if>
            <c:if test="${not empty documents.idProof}">
                <li>
                    ID Proof:
                    <a href="${pageContext.request.contextPath}${documents.idProof}" target="_blank">View</a>
                </li>
            </c:if>
            <c:if test="${not empty documents.coiDoc}">
                <li>
                    COI Document:
                    <a href="${pageContext.request.contextPath}${documents.coiDoc}" target="_blank">View</a>
                </li>
            </c:if>
        </ul>

        <form action="${pageContext.request.contextPath}/admin/travel/agencies/approve/${agency.id}" method="post" style="display:inline;">
            <button type="submit" class="btn btn-success">Approve</button>
        </form>

        <form action="${pageContext.request.contextPath}/admin/travel/agencies/reject/${agency.id}" method="post" style="display:inline;">
            <button type="submit" class="btn btn-danger">Reject</button>
        </form>
    </c:if>

    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary mt-3">← Back to Dashboard</a>
</div>

<jsp:include page="../../includes/footer.jsp"/>

