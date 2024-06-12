live_auto_call

if(state==states.dresser||state==states.dead ||state==states.actor)
	exit

var dir = point_direction(other.x, other.y, x, y)
state = states.bounce
sprite_index = spr_player_bounce
grounded = false

hsp = lengthdir_x(other.force, dir)
vsp = lengthdir_y(other.force, dir)
if (hsp != 0)
	xscale = sign(hsp)
movespeed = abs(hsp)

