/// @function scr_array_sum(array, length)
/// @description Sums numerical value array
/// @param array real | array to refernce
/// @param length real | length of the array
/// @return sum real

var array = argument0
var length = argument1
var sum = 0

for (var i = 0; i < length; i ++;)
	sum += real(array[i])

return sum