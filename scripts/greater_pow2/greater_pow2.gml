/// @func	greater_pow2(value, [greater_or_equal])
/// @desc	returns the minimum power of 2 that is greater than (or equal to) the input value.
///			if the number is 0 or less it returns -1
/// @arg	{Real}	_value				the reference value
/// @arg	{Bool}	_greater_or_equal	if set to false (default), it will the only return a power of 2 that is strictly greater, otherwise it might return a power of 2 that is equal to the given value
function greater_pow2(_value, _greater_or_equal = false)
{
	if(_value <= 0) return -1;
	if(_value == 1) return (2 - _greater_or_equal); // compact way of writing if(_greater_or_equal) return 1; else return 2;
	
	var _pow2 = 1;
	if(_value > 1)
	{
		if(!_greater_or_equal)
		{
			while(_pow2 <= _value)
				_pow2 *= 2;
			return _pow2;
		}
		
		while(_pow2 < _value)
			_pow2 *= 2;
		return _pow2;
	}
	// "else" is unnecessary, because of the "return" in the "if"
	if(!_greater_or_equal)
	{
		while(_pow2 > _value)
			_pow2 /= 2;
		return 2*_pow2;
	}
	
	while(_pow2 >= _value)
		_pow2 /= 2;
	return 2*_pow2;
}