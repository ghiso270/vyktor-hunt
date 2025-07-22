/// @func	choose_random(matches)
/// @desc	returns a random value based on an array of weighted options. if using % values the weights should add up to 100
/// @arg	{Array<Any>}	_matches	array of couples like this: [[weight, value], [weight, value], ...]
/// @returns {Any}
function choose_random(_matches){
	var _len  = array_length(_matches);
	var _tot = 0; for(var _i=0; _i<_len; _i++) _tot += _matches[_i][0];
	var _rand = random(_tot);
	
	for(var _i=0; _i<_len; _i++){
		if(_rand <= _matches[_i][0]) return _matches[_i][1];
		_rand -= _matches[_i][0];
	}
	return _matches[_len-1][1];
}