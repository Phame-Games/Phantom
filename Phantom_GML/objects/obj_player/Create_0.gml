/// @description Initialize variables

//Networking
connect_id = -1

//create map unit
Unit = instance_create_layer(room_width/2, room_height/2, "Instances", obj_unit);
Unit.Player = self;

//Post-initialization setup
alarm[0] = 1