var redis = require('redis').createClient();

// key value
redis.set('name', 'grrrisu');
redis.get('name', function(error, data){
  console.log(data);
})

// lists
// set
client.lpush('questions', 'the meaning of life', function(error, value){
  console.log(value); // current lenght
});
// get from 0 to end
client.lrange('questions', 0, -1, function(error, data){
  console.log(data);
});
// cut the list to 20 items
client.ltrim("questions", 0, 19);
