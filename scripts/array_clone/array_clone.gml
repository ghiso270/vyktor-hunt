/// @func	array_clone(array)
/// @desc	returns a clone of the input array
/// @arg	{Array}	_array	the array to clone
/// @return	{Array}
function array_clone(_array){
	var _len = array_length(_array);
	
	// creates an empty array of the same size as the input one
	var _output_array = array_create(_len);
	
	// copies every value, starting from index 0
	array_copy(_output_array, 0, _array, 0, _len);
	
	return _output_array;
}