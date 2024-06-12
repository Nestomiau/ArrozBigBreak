if (!scr_solid(x, y + 1) && !place_meeting(x, y + 1, obj_player))
	grounded = false;
else if (!grounded && !fallDestroy)
	instance_destroy();

if (!grounded) {
	vsp += 0.25;
	y += vsp;
	if(scr_solid(x, y + 1) && fallDestroy) {
		grounded = 1
		while(scr_solid(x, y))
			y--
		if(landSfx != noone)
			sound_play_3d(landSfx[random(array_length(landSfx)-1)],x,y)
	}
}
