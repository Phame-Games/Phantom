/// @description Initialize variables

//created for each player on the network

connect_id = -1 //order in which client connected to server, not an index to any list!

//create map unit
Unit = instance_create_layer(room_width/2, room_height/2, "Instances", obj_unit);
Unit.Player = self;

//to - target direction to move
to = -1

//Post-initialization setup
alarm[0] = 1