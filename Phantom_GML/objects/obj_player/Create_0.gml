/// @description Initialize variables

//Score
game_score = 0

//Repair queue
repair_list = ds_list_create()
local_repair_list = ds_list_create()

//Create objects
Train = instance_create_layer(x, y, "Instances", obj_train)
Train.player = self;
Repair = instance_create_layer(x, y, "Instances", obj_repairman)
Repair.player = self;

trains = 3
sound = snd_horn1

//Networking
connect_id = -1

//Lay the starting rails

for (var i = 0; i < 4; i ++) {
	var tile = instance_position(x + 32*i, y, obj_track)
	var rock = instance_position(x + 32*i, y, obj_rock)
	if instance_exists(tile){
		tile.image_index = 0
	}
	else if instance_exists(rock){
		instance_create_layer(x + 32*i, y, "Instances", obj_track)
		instance_destroy(rock)
	}
	else{
		instance_create_layer(x + 32*i, y, "Instances", obj_track)
	}
}
instance_create_layer(x, y, "Instances", obj_blank)

alarm[0] = 1