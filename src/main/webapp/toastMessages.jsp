<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style>
        .toast {
            position: fixed;
            bottom: 10px;
            right: 10px;
            width: 400px;
        }
    </style>
<body>
<%
    String error = (String) request.getSession().getAttribute("error");
    if (error != null) {
        request.getSession().removeAttribute("error");%>
<script>
    $(document).ready(function () {
        $('#error').toast('show');
    });
</script>
<%
    }
    String success = (String) request.getSession().getAttribute("success");
    if (success != null) {
        request.getSession().removeAttribute("success");%>
<script>
    $(document).ready(function () {
        $('#success').toast('show');
    });
</script>

<% } %>

<div id="error" class="toast bg-danger text-white" role="alert">
    <div class="toast-body d-flex justify-content-center" style="padding: 1.5rem; font-size: 1.2rem;">
        <%=error%>
    </div>
</div>

<div id="success" class="toast bg-primary text-white" role="alert">
    <div class="toast-body d-flex justify-content-center" style="padding: 1.5rem; font-size: 1.2rem;">
        <%=success%>
    </div>
</div>

</body>
</html>