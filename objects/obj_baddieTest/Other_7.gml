if(sprite_index==spr_activate){
	state=states.mach
	sprite_index=spr_run
}
if(sprite_index==spr_slowdown){
	sprite_index=spr_idle
}