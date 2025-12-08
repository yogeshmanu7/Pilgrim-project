<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ include file="includes/header.jsp" %>

<h2>User Register</h2>

<% if (session.getAttribute("error") != null) { %>
    <p style="color:red;"><%= session.getAttribute("error") %></p>
<% session.removeAttribute("error"); } %>

<form:form modelAttribute="user" action="<%=request.getContextPath()%>/save-user" method="post">
    Name: <form:input path="name"/><br><br>
    Email: <form:input path="email"/><br><br>
    Password: <form:password path="password"/><br><br>

    Role:
    <form:select path="role">
        <form:option value="PERSONAL" label="Personal User"/>
        <form:option value="ORGANIZATION" label="Organization User"/>
    </form:select><br><br>

    <button type="submit">Register</button>
</form:form>

<p>Already a member? <a href="<%=request.getContextPath()%>/login">User Login</a></p>

<%@ include file="includes/footer.jsp" %>
