<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>

<body>
<jsp:include page="inclue_header.html"></jsp:include>
<%
    Boolean registrationSuccessful = (Boolean) request.getSession().getAttribute("registered");
    if (registrationSuccessful != null) {
        request.getSession().removeAttribute("registered");
        String toastId = registrationSuccessful ? "regOk" : "regFail";%>
        <script>
            $(document).ready(function () {
                $('#<%=toastId%>').toast('show');
            });
        </script>
<% } %>


<div id="regOk" class="toast bg-primary text-white" role="alert" data-bs-delay="10000"
     style="position: fixed; bottom: 10px; right: 10px; width: 400px;">
    <div class="toast-body d-flex justify-content-between" style="padding: 1.5rem; font-size: 1.2rem;">
        User successfully registered.
        <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
</div>

<div id="regFail" class="toast bg-danger text-white" role="alert" data-bs-delay="10000"
     style="position: fixed; bottom: 10px; right: 10px; width: 400px;">
    <div class="toast-body d-flex justify-content-between" style="padding: 1.5rem; font-size: 1.2rem;">
        Email already registered.
        <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
</div>


</body>
</html>