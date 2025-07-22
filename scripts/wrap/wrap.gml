/// @func wrap(value, min, max)
/// @desc Returns the value wrapped, values over or under will be wrapped around (pac-man effect)
/// @arg {Real} _value value
/// @arg {Real} _min minimum value
/// @arg {Real} _max maximum value
function wrap(_value, _min, _max){
 
	if (_value mod 1 == 0)
	{
	    while (_value > _max || _value < _min)
	    {
	        if (_value > _max)
	            _value += _min - _max - 1;
	        else if (_value < _min)
	            _value += _max - _min + 1;
	    }
	    return(_value);
	}
	else
	{
	    var _v_old = _value + 1;
	    while (_value != _v_old)
	    {
	        _v_old = _value;
	        if (_value < _min)
	            _value = _max - (_min - _value);
	        else if (_value > _max)
	            _value = _min + (_value - _max);
	    }
	    return(_value);
	}
}