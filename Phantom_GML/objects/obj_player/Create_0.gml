/// @description Initialize variables

//created for each player on the network

connect_id = -1 //order in which client connected to server, not an index to any list!

//create map unit
Unit = instance_create_layer(room_width/2, room_height/2, "Instances", obj_unit);
Unit.Player = self;

//to - target direction to move
to = -1

#region Input
controls = 0; //input index in controls array

// inputs - array holding the current state of each input
inputs_length = array_length_2d(global.controls, controls)
inputs = array_create(inputs_length);

// mouse input
mouseX = 0;
mouseY = 0;
//gamepad aiming
gamepad_aimx = 0//value -1 to 1, right joystick
gamepad_aimy = 0//value -1 to 1, right joystick
 
input_buffer = 0; //small buffer to slow down gamepad input
input_buffer_max = 4;
#endregion

//Post-initialization setup
alarm[0] = 1