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
</head>
<body>

<div id="error" class="toast bg-danger text-white" role="alert">
  <div class="toast-body d-flex justify-content-center" style="padding: 1.5rem; font-size: 1.2rem;"></div>
</div>

<div id="success" class="toast bg-primary text-white" role="alert">
  <div class="toast-body d-flex justify-content-center" style="padding: 1.5rem; font-size: 1.2rem;"></div>
</div>

<script>
  function showModal(type, message) {
    let modal = type === "success" ? $("#success") : $("#error");
    modal.find(".toast-body").text(message);
    modal.toast('show');
  }
</script>

</body>
</html>
