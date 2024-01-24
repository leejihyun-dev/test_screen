const express = require('express');
const http = require('http');
const { Server } = require('socket.io');

const app = express();
const server = http.createServer(app);
const io = new Server(server);

app.get('/', (req, res) => {
  res.send('<h1>Hello World</h1>');
});

io.on('connection', (socket) => {
  console.log('a user connected');
  
  // 클라이언트로부터 메시지를 받으면 모든 클라이언트에게 브로드캐스트
  socket.on('chat message', (data) => {
    console.log('user message', data.user, data.message);
    io.emit('chat message', data);
  });

  socket.on('disconnect', () => {
    console.log('user disconnected');
  });
});

server.listen(3000, () => {
  console.log('listening on *:3000');
});
