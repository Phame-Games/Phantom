/// @description Break tiles

xx = irandom(room_width/32)*32
yy = irandom(room_height/32)*32

if instance_position(xx,yy,obj_track) {
	if not instance_position(xx,yy,obj_cracks){
		instance_create_layer(xx+16,yy+16,"Instances",obj_cracks)	
	}
}

//Reset buffers
alarm[0] = irandom_range(break_buffer_min, break_buffer_max)