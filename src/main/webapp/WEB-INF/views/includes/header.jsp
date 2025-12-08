<nav style="background:#003366;padding:10px;color:white;
display:flex;justify-content:space-between;align-items:center;">
    <div>
        <h2>Pilgrim Portal</h2>
    </div>

    <div>
        <%
        Object obj = session.getAttribute("user");
                    if (obj != null) {
                        com.pilgrim.entity.User u = (com.pilgrim.entity.User) obj;
        %>
            Welcome, <b><%= u.getName() %></b> |
            <a href="/logout" style="color:white;">Logout</a>
        <% } else { %>
            <a href="/login" style="color:white;margin-right:10px;">User Login</a>
            <a href="/register" style="color:white;">User Register</a>
        <% } %>
    </div>
</nav>
<hr/>

