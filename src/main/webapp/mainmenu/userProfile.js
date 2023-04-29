$(document).ready(() => {
    $("#profileForm").on("submit", (event) => {
        event.preventDefault();
        const username = $("#username").val();
        $.ajax({
            url: "/userUpdateUsername",
            type: "POST",
            data: {username: username}
        })
            .done(() => {
                location.reload()
            })

    });

    $("#changePasswordForm").on("submit", (event) => {
        event.preventDefault();
        const passwordCurrent = $("#passwordCurrent").val();
        const passwordNew = $("#passwordNew").val();

        $.ajax({
            url: "/userUpdatePassword",
            type: "POST",
            data: {
                passwordCurrent: passwordCurrent,
                passwordNew: passwordNew
            }
        })
            .done(() => {
                location.reload()
            })

    });
});