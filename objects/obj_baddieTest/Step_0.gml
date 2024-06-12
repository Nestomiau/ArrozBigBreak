event_inherited()
switch (state){
	case states.normal :
		hsp=Approach(hsp,0,accel)
		if(distance_to_object(obj_player)<noticePlayerDist&&sprite_index!=spr_activate){
			sprite_index=spr_activate
			image_index=0
		}
	break
	case states.mach :
		hsp=Approach(hsp,(obj_player.x>x)?spd:-spd,machAccel)
		if(hsp!=0)
			image_xscale=sign(hsp)
		mask_index=spr_player_maskdown
		if(instance_place(x+hsp+(image_xscale*10),y-8,obj_player))
			with(obj_player)
				scr_hurtplayer()
		mask_index=spr_player_mask
		if(distance_to_object(obj_player)>losePlayerDist&&sprite_index!=spr_slowdown){
			sprite_index=spr_slowdown
			image_index=0
			state=states.normal
		}
	break
}

vsp+=grav

scr_collide()