
<%@ include file="includes/header.jsp" %>

<h2>User Login</h2>

<% if (session.getAttribute("message") != null) { %>
    <p style="color:green;"><%= session.getAttribute("message") %></p>
<% session.removeAttribute("message"); } %>

<% if (session.getAttribute("error") != null) { %>
    <p style="color:red;"><%= session.getAttribute("error") %></p>
<% session.removeAttribute("error"); } %>

<form action="<%=request.getContextPath()%>/login-user" method="post">
    Email: <input type="text" name="email" required><br><br>
    Password: <input type="password" name="password" required><br><br>

    <button type="submit">Login</button>
</form>

<p>Not a member? <a href="<%=request.getContextPath()%>/register">User Register</a></p>

<%@ include file="includes/footer.jsp" %>
