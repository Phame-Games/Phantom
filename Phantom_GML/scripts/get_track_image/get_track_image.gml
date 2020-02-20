/// @function scr_find_to(from)
/// @description Finds the to value
// Returns to

var index = argument0
var type = argument1
if (argument1){
	//Change type
	if index < 2{
		index = 3
	}
	else{
		index = 0
	}
}
else{
	index --
	if index < 0 {
		index = 1
	}
	else if index = 1 {
		index = 5
	}
}
return index