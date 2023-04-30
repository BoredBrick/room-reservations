$(document).ready(function() {
    $('.admin-toggle').on('click', function() {
        let userId = $(this).data('userid');
        let button = $(this);
        $.ajax({
            url: "/userUpdateAdminStatus",
            type: "POST",
            data: { userId: userId },
            success: function() {
                button.toggleClass("btn-success btn-secondary");
                let currentText = button.text().trim();
                let newText = currentText === "Yes" ? "No" : "Yes";
                button.text(newText);
                showModal("success","User admin status updated.");
            },
            error: function() {
                showModal("error","Couldn't update user admin status.");
            }
        });
    });
});