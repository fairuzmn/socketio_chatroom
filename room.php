<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">

    <title>Hello, world!</title>
    <script src="assets/js/socket.io-3.0.1.min.js"></script>
    <style>
        .liUser:hover {
            cursor: pointer;
        }
    </style>
</head>

<body>
    <div class="d-flex flex-row justify-content-center align-items-center" style="height: 100px;margin-top:100px">
        <div class="card" style="width: 18rem;">
            <div class="card-header">
                List User
            </div>
            <ul class="list-group list-group-flush" id="users"></ul>
        </div>
    </div>
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="assets/js/jquery.min.js">
    </script>
    <script src="assets/js/popper.min.js">
    </script>
    <script src="assets/js/bootstrap.min.js">
    </script>
</body>
<script>
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    const id = urlParams.get('id')

    $.post('http://localhost:3000/get_users', {
        id: id
    }).done((data) => {
        data = JSON.parse(data)
        data.map(item => {
            $('#users').append(`<li class="list-group-item liUser" id="${item.id}" onclick="pilihUser(this.id)">${item.name}</li>`)
        })
    })

    const pilihUser = (idReceiver) => {
        window.location = `chat.php?sender=${id}&receiver=${idReceiver}`
    }
</script>

</html>