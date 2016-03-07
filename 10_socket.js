'use strict';

const net = require('net');

const client = net.connect({port: 1234}, function(){
  console.log("connected to server");
});

client.on("data", function(data){
  console.log(data.toString());
})

client.on("end", function(){
  console.log("server disconnected");
});

client.on("error", function(err){
  console.log(err);
});
