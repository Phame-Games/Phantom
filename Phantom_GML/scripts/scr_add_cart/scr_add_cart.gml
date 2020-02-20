var xx = argument0
var yy = argument1
var to = argument2
var from = argument3

if from == 0{
	xx += 32	
}

if from == 1{
	yy -= 32	
}

if from == 2{
	xx -= 32	
}

if from == 3{
	yy += 32
}

var cart = instance_create_layer(xx,yy,"Instances",obj_cart)

cart.to = scr_find_to(from)

var tile = instance_position(xx,yy,obj_track)

if tile != noone {
	for (var i = 0; i < 4; i ++){
		if i != cart.to{
			if tile.path[i]{
				cart.from = i
			}
		}
	}
}

with(cart) event_user(0)

return cart