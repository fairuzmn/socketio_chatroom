<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat</title>
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/socket.io-3.0.1.min.js"></script>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="chat.css">
</head>

<body>
    <div id="listMessages"></div>
    <div id="mengetik" style="display:none">
        <div class="container">
            <img src="img/profile.png" alt="Avatar" style="width:100%;">
            <p>Sedang Mengetik . . </p>
        </div>
    </div>
    <input type="hidden" value="<?= $_GET['sender'] ?>" name="sender" id="sender">
    <input type="hidden" value="<?= $_GET['receiver'] ?>" name="receiver" id="receiver">

    <form action="" onsubmit="return kirimPesan()">
        <div class="input-group mb-3">
            <input type="text" class="form-control" placeholder="Masukkan Pesan" aria-label="Masukkan Pesan" aria-describedby="basic-addon2" id="message" required autocomplete="off" onkeydown="startNgetik()">
            <div class="input-group-append">
                <button class="input-group-text" id="basic-addon2">Kirim</button>
            </div>
        </div>
    </form>

    <script src="assets/js/popper.min.js">
    </script>
    <script src="assets/js/bootstrap.min.js">
    </script>

</body>
<script>
    /*

    .emit adalah mengirim
    .on adalah lisenting

    berlaku pada cleint dan server

    source https://www.youtube.com/watch?v=Ozrm_xftcjQ

    */

    const sender = $('#sender').val();
    const receiver = $('#receiver').val();
    let id_room;

    var io = io('http://localhost:3000', {
        transports: ['websocket', 'polling', 'flashsocket']
    });

    $.post('http://localhost:3000/find_room', {
        sender: sender,
        receiver: receiver,
    }).done((data) => {
        id_room = data
        getAllChat();
    })

    const getAllChat = () => {
        $.post('http://localhost:3000/get_all_chat', {
            id_room: id_room
        }).done((result) => {
            result = JSON.parse(result)
            if (result.length > 0) {
                result.map(item => {
                    if (item.id_user_chat == $('#sender').val()) {
                        chat = `<div class="container myChat">
                        <img src="img/profile.png" alt="Avatar" class="right" style="width:100%;">
                                        <p>${item.chat}</p>
                                        <span class="time-left">${item.tgl}</span>
                                        </div>`
                    } else {
                        chat = ` <div class="container">
                                    <img src="img/profile.png" alt="Avatar" style="width:100%;">
                                    <p>${item.chat}</p>
                                        <span class="time-right">${item.tgl}</span>
                                    </div>`
                    }

                    document.getElementById('listMessages').innerHTML += chat
                })
                scrollDown();
            }
        })
    }

    io.on('pesan_baru', (data) => {
        scrollDown();
        // console.log(data)
        const result = JSON.parse(data)
        let chat = ''
        result.map(item => {
            if (item.id_room == id_room) {

                if (item.id_user_chat == $('#sender').val()) {
                    chat = `<div class="container myChat">
                    <img src="img/profile.png" alt="Avatar" class="right" style="width:100%;">
                    <p>${item.chat}</p>
                    <span class="time-left">${item.tgl}</span>
                    </div>`
                } else {
                    chat = ` <div class="container">
                    <img src="img/profile.png" alt="Avatar" style="width:100%;">
                    <p>${item.chat}</p>
                    <span class="time-right">${item.tgl}</span>
                    </div>`
                }

                document.getElementById('listMessages').innerHTML += chat
            }
        })
        $('#mengetik').hide();
    })

    io.on('sedangNgetik', (data) => {
        const result = JSON.parse(data)
        if (result.id_room == id_room) {
            if (result.sender != $('#sender').val()) {
                if ($("#mengetik").is(":hidden")) {
                    $('#mengetik').show();
                    setTimeout(() => {
                        $('#mengetik').hide();
                    }, 1500)
                    scrollDown();
                }
            }
        }
    })

    const kirimPesan = () => {
        const message = document.getElementById('message').value
        document.getElementById('message').value = ''

        io.emit('kirim_pesan', {
            receiver: receiver,
            sender: sender,
            chat: message,
            id_room: id_room
        })

        return false
    }

    const startNgetik = () => {
        io.emit('startNgetik', {
            id_room: id_room,
            sender: sender
        })
    }

    const scrollDown = () => {
        const n = $(document).height();
        $('html, body').animate({
            scrollTop: n
        }, 50);
    }
</script>

</html>