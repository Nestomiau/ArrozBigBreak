live_auto_call

if(state == states.dead || state == states.dresser)
	exit

if(other.send) {
	mask_index=spr_player_mask
	movespeed=0
	vsp=0
	hsp=0
	var _s=other.force
	switch(other.dir){
	case vk_up : vsp=-_s break
	case vk_down : vsp=_s break
	case vk_left : hsp=-_s break
	case vk_right : hsp=_s break
	}
	if(other.type-1) {
		collide=1
		fall=1
		state=states.normal
		sprite_index=spr_mach2fall
		movespeed=abs(hsp)
		if(movespeed)
			xscale=sign(hsp)
	}
}else if(state==states.actor||!other.type) {
	x=lerp(x,other.x,0.3)
	y=lerp(y,other.y,0.3)
	hsp=0
	vsp=0
	if(!other.cooldown){
		collide=0
		fall=0
		other.cooldown=other.maxcooldown
		other.plr=self
		sprite_index=spr_fall
		state=states.actor
	}
}