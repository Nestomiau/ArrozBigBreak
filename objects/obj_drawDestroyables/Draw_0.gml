var _O = []
var _drawL = []
var _i = 0
with(obj_destroyable){array_push(_O,id)}
while(array_length(_O)!=array_length(_drawL)){
	var _val = [99999999,-1]
	var __i = 0
	repeat(array_length(_O)){
		if((-_O[__i].x+_O[__i].y < _val[0]) && array_get_index(_drawL,__i) < 0) {
			_val[0] = -_O[__i].x+_O[__i].y
			_val[1] = __i
		}
		__i++
	}
	_drawL[_i] = _val[1]
	_i++
}
_i = 0
repeat(array_length(_O)){
	with(_O[_drawL[_i]]){
		draw_self()
	}
	_i++
}