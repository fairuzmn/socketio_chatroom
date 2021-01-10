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
    database: 'socketio_chat'
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

// create API for get all message
app.post('/get_messages', (request, result) => {
    const {
        sender,
        receiver
    } = request.body
    // console.log(`SELECT * FROM messages WHERE (sender = '${sender}' AND receiver = '${receiver}') OR (receiver = '${receiver}' AND sender = '${sender}')`);
    connection.query(`SELECT * FROM messages WHERE (sender = '${sender}' AND receiver = '${receiver}') OR (receiver = '${receiver}' AND sender = '${sender}')`, (error, message) => {
        result.end(JSON.stringify(message))
    })
})

// array of username connected
let users = []

// initiate socket io 
const io = require('socket.io')(http)
io.on('connection', function (socket) {
    console.log(`User Connected ${socket.id}`)

    // attach incoming listener for new user
    socket.on('user_connected', (username) => {
        // save in array username
        users[username] = socket.id

        // notify all connected clients
        io.emit('user_connected', username)
    })

    // listen send_message
    socket.on('send_message', (data) => {
        // console.log(data)
        const socketId = users[data.receiver]

        // send to specific user
        io.to(socketId).emit('new_message', data)

        // save to db
        connection.query(`INSERT INTO messages (sender,receiver,message) VALUES ('${data.sender}', '${data.receiver}', '${data.message}')`, (error, result) => {
            if (error) {
                console.log(error)
            }
        })
    })

})

// start the server
http.listen(3000, () => {
    console.log(`server running on port 3000`)
})