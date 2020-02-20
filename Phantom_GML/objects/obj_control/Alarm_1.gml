/// @description Generate coins

var s = 32
var w = room_width
var h = room_height

var xx = irandom (w/s) * s + s/2 + 32
var yy = irandom( h/s) * s  + s/2 + 32

//Ensure coins do not overlap
if instance_position(xx,yy,obj_track) {
	if !(place_meeting(xx, yy, obj_score)){
		with (instance_create_layer(xx, yy, "Instances_1", obj_score)) {
		}
	}
}

//Reset buffers
alarm[1] = irandom_range(coin_buffer_min, coin_buffer_max)