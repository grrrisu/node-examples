"use strict";

const retry = require('retry');

exports.connect = function(server){

  const io = require('socket.io')(server);
  const unix_socket = require('./unix_socket');

  io.on("connection", function(client){
    console.log("browser connected");
    let serverConnection = null;

    client.on("join", function(player_id, player_token){
      console.log(player_id + " : " + player_token + " joined");
      let operation = retry.operation();
      operation.attempt(function(currentAttempt){
        unix_socket.connect('../server/player.sock', (err, socket) => {
          if(operation.retry(err)){
            return;
          } else {
            serverConnection = socket;
            serverConnection.browserConnection = client;
          }
        });

      });
    });

    client.on("action", function(data){
      console.log("message received ", data);
      if(serverConnection) {
        serverConnection.write(JSON.stringify(data)+"\r\n");
      } else {
        console.log("action dropped as we don't have any server connection");
      }
    });

    client.on("disconnect", function(data){
      console.log("client disconnected");
      if(serverConnection) {
        serverConnection.end();
      }
    })
  });

}
