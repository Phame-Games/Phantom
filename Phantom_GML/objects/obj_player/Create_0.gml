/// @description Initialize variables

//created for each player on the network

//Networking
connect_id = -1

//create map unit
Unit = instance_create_layer(room_width/2, room_height/2, "Instances", obj_unit);
Unit.Player = self;

//to - target direction to move
to = 0

//Post-initialization setup
alarm[0] = 1