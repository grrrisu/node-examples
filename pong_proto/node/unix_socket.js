"use strict";

const net = require('net');

exports.connect = function(file) {

  let client = net.connect({path: file}, function(){
    console.log("connected to server");
  });

  client.on("error", function(err){
    console.log(err);
  });

  client.on("data", function(data){
    console.log("data from server: " + data.toString());
    client.browserConnection.emit("action", data.toString());
  })

  client.on("end", function(){
    console.log("server disconnected");
  });

  return client;

};
