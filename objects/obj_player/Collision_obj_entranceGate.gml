live_auto_call

if(key_up2&&grounded&&state!=states.slide&&state!=states.dresser&&state!=states.actor&&state!=states.dead&&state!=states.hurt){
	targetRoom=other.targetRoom
	targetDoor="A"
	vsp=0
	hsp=0
	state=states.actor
	movespeed=0
	sprite_index=spr_entergate
	image_index=0
	x=lerp(x,other.x,0.3)
}
