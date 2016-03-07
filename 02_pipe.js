var http = require('http');
var fs = require('fs');

http.createServer(function(request, response){
  response.writeHead(200, {'Content-Type': 'text/html'});
  var html = fs.createReadStream('index.html');
  html.pipe(response);
}).listen(8080);
