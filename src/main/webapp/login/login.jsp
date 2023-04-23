<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, sk.webky.helper.user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <style>
        <%@include file="../styles.css" %>
    </style>
    <title>Login</title>
</head>
<body>

<div class="container-fluid">
    <div class="row justify-content-center">
        <div class="col-md-7">
            <h1 class="text-center mt-5 mb-4">Welcome to the Room Reservation System</h1>
            <div class="card mx-auto mt-5">
                <div class="card-body">
                    <h5 class="card-title text-center">Login</h5>
                    <form id="loginForm" action="userlogin" method="post">
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email">
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password">
                        </div>
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">Login</button>
                            <a href="../register/register.jsp" class="btn btn-outline-secondary">Don't have an account?
                                Register</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $("#loginForm").validate({
        rules: {
            email: {
                required: true,
                maxlength: 30
            },
            password: {
                required: true,
                minlength: 5
            },
        }
    });
</script>
</body>
</html>