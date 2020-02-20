/// @description Set string
switch (action){
	case "text":
		keyboard_string = text;
		break;
}

// deselect all other boxes
with (obj_input) selected = false;

// select current box
selected = true;
