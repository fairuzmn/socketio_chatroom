// initiate express
const express = require('express')
const app = express();

// create http instance
const http = require('http').createServer(app)

// initiate body parser for POST Request
const bodyParser = require('body-parser')

// enable URL encoded for POST Request
app.use(bodyParser.urlencoded())

// initiate mysql 
const mysql = require('mysql')

// initiate connection to mysql
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'socketio_chat',
    dateStrings: true
})

// connect db
connection.connect((error) => {
    if (error) {
        console.log(error)
    }
})

// enable headers required for POST request
app.use((request, result, next) => {
    result.setHeader('Access-Control-Allow-Origin', '*')
    next()
})

// API : 

app.post('/login', (req, res) => {
    const {
        username,
        password
    } = req.body
    connection.query(`SELECT * FROM user WHERE username = '${username}' AND password = '${password}'`, (error, message) => {
        res.end(JSON.stringify(message))
    })
})

app.post('/get_users', (req, res) => {
    const {
        id
    } = req.body
    connection.query(`SELECT * FROM user WHERE id != ${id}`, (error, message) => {
        // console.log(message)
        res.end(JSON.stringify(message))
    })
})

app.post('/find_room', (req, res) => {
    const {
        sender,
        receiver
    } = req.body
    connection.query(`SELECT * FROM r_chat_room WHERE (id_user1 = ${sender} AND id_user2 = ${receiver}) OR (id_user1 = ${receiver} AND id_user2 = ${sender}) LIMIT 1`, (error, message) => {
        if (message.length > 0) {
            const {
                id_room
            } = message[0]
            res.end(JSON.stringify(id_room))
        } else {
            connection.query(`INSERT INTO r_chat_room(id_user1,id_user2) VALUES(${sender},${receiver})`, (error, message) => {
                if (message) {
                    connection.query(`SELECT * FROM r_chat_room WHERE (id_user1 = ${sender} AND id_user2 = ${receiver}) OR (id_user1 = ${receiver} AND id_user2 = ${sender})`, (error, message) => {
                        const {
                            id_room
                        } = message[0]
                        res.end(JSON.stringify(id_room))
                    })
                }
            })
        }
    })
})

app.post('/get_all_chat', (req, res) => {
    const {
        id_room
    } = req.body
    connection.query(`SELECT * FROM r_chat_room_dtl a JOIN user b ON a.id_user_chat = b.id WHERE a.id_room = ${id_room}`, (error, message) => {
        res.end(JSON.stringify(message))
    })
})


// END API

// array of username connected
let users = []
let user_online = []

// initiate socket io 
const io = require('socket.io')(http)
io.on('connection', function (socket) {
    console.log(`User Connected ${socket.id}`)

    // simpan user online kedalam array

    // attach incoming listener for new user
    socket.on('user_connected', (username) => {
        // save in array username
        users[username] = socket.id

        // notify all connected clients
        io.emit('user_connected', username)
    })

    socket.on('kirim_pesan', (data) => {
        connection.query(`INSERT INTO r_chat_room_dtl (id_room,id_user_chat,id_user_chat_to,chat) VALUES (${data.id_room}, ${data.sender}, ${data.receiver},'${data.chat}')`, (error, result) => {
            if (error) {
                console.log(error)
            }
            connection.query(`SELECT * FROM r_chat_room_dtl a JOIN user b ON a.id_user_chat = b.id WHERE a.id_room = ${data.id_room} ORDER BY id_dtl DESC LIMIT 1 `, (error, message) => {
                io.emit('pesan_baru', JSON.stringify(message))
            })

        })
    })

    socket.on('startNgetik',(data) => {
        io.emit('sedangNgetik',JSON.stringify(data))
    })

})
// start the server
http.listen(3000, () => {
    console.log(`server running on port 3000`)
})