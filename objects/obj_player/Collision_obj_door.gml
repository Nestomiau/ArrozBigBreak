live_auto_call

if(key_up2&&grounded&&state!=states.slide&&state!=states.dresser&&state!=states.actor&&!other.image_index&&state!=states.dead&&state!=states.hurt){
	targetRoom=other.targetRoom
	targetDoor=other.targetDoor
	vsp=0
	hsp=0
	state=states.actor
	movespeed=0
	sprite_index=spr_enterdoor
	image_index=0
	x=lerp(x,other.x+16,0.5)
	if(!instance_exists(obj_fadeout))
		instance_create(0,0,obj_fadeout)
}
