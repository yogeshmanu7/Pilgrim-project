 <%@ include file="includes/header.jsp" %>

<h2>OTP Verification</h2>

<% if (session.getAttribute("message") != null) { %>
    <p style="color:green;"><%= session.getAttribute("message") %></p>
<% session.removeAttribute("message"); } %>

<% if (session.getAttribute("error") != null) { %>
    <p style="color:red;"><%= session.getAttribute("error") %></p>
<% session.removeAttribute("error"); } %>

<form action="/verify-otp" method="post">
    OTP: <input type="text" name="otp" required /><br><br>
    <button type="submit">Verify OTP</button>
</form>

<%@ include file="includes/footer.jsp" %>
