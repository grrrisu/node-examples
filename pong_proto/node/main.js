"use strict";

const app = require('express')();
const server = require('http').createServer(app);
const io = require('socket.io')(server);

const unix_socket = require('./unix_socket');

io.on("connection", function(client){
  console.log("browser connected");

  let serverConnection = unix_socket.connect('../server/player.sock');

  client.on("join", function(player_id, player_token){
    console.log(player_id + " : " + player_token + " joined");
    serverConnection = serverConnection;
    serverConnection.browserConnection = client;
  });

  client.on("action", function(data){
    console.log("message received ", data);
    serverConnection.write(JSON.stringify(data)+"\r\n");
  });

  client.on("disconnect", function(data){
    console.log("client disconnected");
    serverConnection.end();
  })
});

app.get('/', function(req, res){
  res.sendFile(__dirname + '/public/chat.html');
});
server.listen(8080);
