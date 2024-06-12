repeat (particle.amount){instance_create(x, y, obj_debris,particle.dStruct)}
if(contain != []) {
	var _i = 0
	var _a
	repeat(array_length(contain)){
		_a = contain[_i]
		instance_create(x+_a[1],y+_a[2],_a[0],_a[3])
		_i++
	}
}
var _xy = (instance_place(x,y,obj_player))?[obj_player.x,obj_player.y]:[x,y]
if(playSfx!=noone){sound_play_3d(playSfx[random(array_length(playSfx)-1)],_xy[0],_xy[1])}

ds_list_add(global.saveroom, id)
