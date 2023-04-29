<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Profile</title>
    <style>
        <%@include file="../styles.css" %>
    </style>
    <jsp:include page="../inclue_header.html"></jsp:include>
    <jsp:include page="../toastMessages.jsp"></jsp:include>
    <jsp:include page="navbar.jsp"></jsp:include>
    <script src="userProfile.js"></script>
    <%
        String loggedInUsername = (String) session.getAttribute("loggedInUsername");
        if (loggedInUsername == null) {
            response.sendRedirect("../index.jsp");
        }
        String loggedInEmail = (String) session.getAttribute("loggedInEmail");
    %>
    %>

</head>
<body>
<div class="container-fluid">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <h1 class="text-center mt-5 mb-4">Profile</h1>
            <div class="card mx-auto mt-5">
                <div class="card-body">
                    <form id="profileForm">
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input value="<%=loggedInEmail%>" type="email" class="form-control" id="email" name="email"
                                   readonly data-bs-toggle="tooltip" data-bs-placement="right"
                                   title="Email can't be changed">
                        </div>
                        <div class="mb-3">
                            <label for="username" class="form-label">Username</label>
                            <input value="<%=loggedInUsername%>" type="text" class="form-control" id="username"
                                   name="username">
                        </div>
                        <div class="d-grid gap-2">
                            <button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal"
                                    data-bs-target="#changePasswordModal">Change Password
                            </button>
                            <button id="save-username" class="btn btn-primary">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="changePasswordModal" tabindex="-1" aria-labelledby="changePasswordModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="changePasswordModalLabel">Change Password</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="changePasswordForm" action="" method="post">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="passwordCurrent" class="form-label">Current password</label>
                        <input type="password" class="form-control" id="passwordCurrent" name="passwordCurrent">
                    </div>
                    <div class="mb-3">
                        <label for="passwordNew" class="form-label">New Password</label>
                        <input type="password" class="form-control" id="passwordNew" name="passwordNew">
                    </div>
                    <div class="mb-3">
                        <label for="confirmPassword" class="form-label">Confirm Password</label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button id="save-password" class="btn btn-primary">Change Password</button>
                </div>
            </form>
        </div>
    </div>
</div>


<script>
    $("#profileForm").validate({
        rules: {
            username: {
                required: true,
                maxlength: 30
            }
        }
    });

    $("#changePasswordForm").validate({
        rules: {
            passwordNew: {
                required: true,
                minlength: 5,
                maxlength: 30
            },
            confirmPassword: {
                required: true,
                equalTo: "#passwordNew"
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