<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, sk.webky.helper.user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Register</title>
    <style>
        <%@include file="../styles.css" %>
    </style>
    <jsp:include page="../inclue_header.html"></jsp:include>
    <jsp:include page="../toastMessages.jsp"></jsp:include>

</head>
<body>

<div class="container-fluid container-padding">
    <div class="row justify-content-center">
        <div class="col-md-7">
            <h1 class="text-center mt-5 mb-4">Welcome to the Room Reservation System</h1>
            <div class="card mx-auto mt-5">
                <div class="card-body">
                    <h5 class="card-title text-center">Register</h5>
                    <form id="registerForm" action="../userRegister" method="post">
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email">
                        </div>
                        <div class="mb-3">
                            <label for="username" class="form-label">Username</label>
                            <input type="text" class="form-control" id="username" name="username">
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password">
                        </div>
                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label">Confirm Password</label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword">
                        </div>
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">Register</button>
                            <a href="../login/login.jsp" class="btn btn-outline-secondary">Already have an account?
                                Login</a>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $("#registerForm").validate({
        rules: {
            email: {
                required: true,
                email: true,
                maxlength: 50
            },
            username: {
                required: true,
                maxlength: 30
            },
            password: {
                required: true,
                minlength: 5,
                maxlength: 30
            },
            confirmPassword: {
                required: true,
                equalTo: "#password"
            }
        },
        messages: {
            password: {
                required: "Please enter a password",
                minlength: "Your password must be at least 8 characters long"
            },
            confirmPassword: {
                required: "Please confirm your password",
                equalTo: "Passwords do not match"
            }
        }
    });
</script>
</body>
</html>