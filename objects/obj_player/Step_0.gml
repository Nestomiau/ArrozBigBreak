live_auto_call

if(!keyboard_check(vk_control)&&keyboard_check_pressed(ord("R"))) {
	ds_list_clear(global.saveroom)
	event_perform(ev_create,0)
	targetDoor=""
	audio_stop_all()
	room_restart()
}

getInput()

if(key_jump)
	input_buffer_jump=10
if(input_buffer_jump>0)
	input_buffer_jump--


switch (state) {
	case states.normal: state_normal() break
	case states.jump: case states.bounce : state_jump() break
	case states.wallslide: state_wallslide() break
	case states.slide: state_slide() break
	case states.hurt: state_hurt() break
	case states.dresser: scr_noise_dresser() break
	case states.dead: scr_noise_dead() break
}

var _mch=noone
if(grounded&&!state) {
	if (sprite_index==spr_mach1)
		_mch=sfx_mach1
	if (sprite_index==spr_mach2)
		_mch=sfx_mach2
	if(movespeed>11)
		_mch=sfx_mach3
}
set_machsnd(_mch)

if (state!=states.jump&&state!=states.normal)
	mach2=0

grav=(state == states.wallslide||(state==states.jump&&mach2>=mach2_time&&vsp<0))?0.25:0.5

// collide destructibles
if(state==states.bounce) {
	with(instance_place(x,y+vsp+1,obj_destroyable)) {
		other.vsp=-14
		other.grounded=false
		if(!isMetal)
			instance_destroy()
	}
}

with (instance_place(x+hsp,y,obj_destroyable))
	if(other.movespeed > destroyspeed || (other.state == states.slide && (!isMetal || other.movespeed > destroyspeed)))
		instance_destroy()
with (instance_place(x,y+vsp+1,obj_destroyable))
	if(other.movespeed > destroyspeed || (other.state == states.slide && (!isMetal || other.movespeed > destroyspeed)))
		instance_destroy()

if(collide){scr_collide_player()}
else {if (vsp < 20 && fall){vsp += grav}x += hsp;y += vsp;}

if (inv > 0) {
	image_alpha=1-(floor(inv / 3) % 2)
	inv--
}
else {
	image_alpha=1
	inv=0
}

// spikes
var _dir=[[0,-1],[1,0],[0,1],[-1,0],[0,0]]
var _i=0
repeat(5){
	if(instance_place(x+_dir[_i][0],y+_dir[_i][1],obj_spike)) {
		if (state == states.bounce) {
			vsp=-14 
			grounded=false
		}else {scr_hurtplayer()}
		break
	}_i++
}
if(check_slope_at(x,y+1)) {
	var _inst = instance_place(x,y+1,obj_slope)
	if(sprite_index==spr_rolldh){
		if(_inst){angle=45*sign(_inst.image_xscale)}
		else{angle=0}
	}
	else if(_inst.object_index==obj_slideSlope&&state!=states.wallslide&&state!=states.actor&&state!=states.dead) {
		vsp=0
		state=states.slide 
		sprite_index =spr_rolldh
	}
}
if(sprite_index!=spr_rolldh||!instance_place(x,y-1,obj_slope)){angle=0}
if(sprite_index != spr_rolldh) {
	if(state==states.slide&&sprite_index!=spr_dive){mask_index=spr_player_maskdown}
	else{mask_index=spr_player_mask}
}else {mask_index=(key_down)?spr_player_maskdown: spr_player_mask}

var _baddie = instance_place(x+(image_xscale*25)+hsp,y,obj_baddie)
if(_baddie){
	if(movespeed>_baddie.scaredSpd||state==states.slide){
		global.collect+=_baddie.dieValue
		if (global.collect>=global.collectHigh) {
			if(hp<5) {
				hp++
				getLife=180
				global.collectHigh+=20
			}
		}
		instance_destroy(_baddie)
	}
}
getLife--