var app = require('express')();
var server = require('http').createServer(app);
var io = require('socket.io')(server);
var redis = require('redis').createClient();

io.on("connection", function(client){
  console.log("Client connected");

  client.on("join", function(username){
    console.log(username + " joined");
    client.username = username;
    client.emit("message", {message: 'welcome ' + username});
  });

  client.on("message", function(data){
    console.log("message received " + data.message)
    var message = client.username + ": " + data.message;
    client.broadcast.emit("message", {message: message}); // broadcast to all others
    client.emit("message", {message: message}); // send back to the caller
  });

  client.on("disconnect", function(data){
    console.log("client disconnected");
  })
});

app.get('/', function(req, res){
  res.sendFile(__dirname + '/chat.html');
});
server.listen(8080);
