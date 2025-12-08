<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Registration Success</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body class="bg-light">

    <jsp:include page="../includes/header.jsp" />

    <main class="container bg-white p-5 rounded shadow-sm mt-4 text-center">
        <h3 class="text-success mb-3">🎉 Registration Completed Successfully!</h3>
        <p class="lead">Your documents have been uploaded and saved.  
           Please wait for admin approval before you can log in.</p>

        <div class="mt-4">
            <a href="${pageContext.request.contextPath}/pilgrim/travel/agency/login" class="btn btn-primary">Go to Login</a>
        </div>
    </main>

    <jsp:include page="../includes/footer.jsp" />

</body>
</html>

