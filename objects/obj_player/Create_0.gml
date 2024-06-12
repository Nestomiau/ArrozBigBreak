live_auto_call

enum states {
	normal,
	mach,
	jump,
	slide,
	hurt,
	wallslide,
	bounce,
	actor,
	hitstun,
	dresser,
	dead,
}

mach2_time = 30
depth = -6
hp = 4
image_speed = 0.35
hsp = 0
vsp = 0
grounded = false
grav = 0.5
state = states.normal
hsp_carry = 0
vsp_carry = 0
platformid = noone
xscale = 1
yscale = 1
movespeed = 0
mach2 = 0
jumpstop = false
inv = 0
getLife = 0
dresserMenu = 0
customizing = 0
deadCooldown = 240
ofScreen=0
plrPal = 0
fall=1
angle=0
collide=1
sPalette=surface_create(1,1)

input_buffer_jump = 0

verticalpos = 0
verticalspd = 0

targetRoom = 0
targetDoor = "A"

scr_player_addslopemomentum = function(_acc, _dec,_mispd = 12,_maspd = 19) {
	with (instance_place(x, y + 1, obj_slope)) {
		if (sign(image_xscale) == -sign(other.xscale) && other.movespeed < _maspd)
			other.movespeed += _acc
		else if (other.movespeed > _mispd)
			other.movespeed -= _dec
	}
}
scr_hurtplayer = function() {
	if (state == states.hurt || state == states.dead || inv > 0)
		exit
	
	hp--
	sound_play_3d(sfx_hurt, x, y)
	if (hp <= 0) {
		state = states.dead
		vsp = -18
		hsp = 0
		deadCooldown = 120
		collide = 0
	}else {
		grounded = false
		movespeed = 0
		hsp = xscale * -6
		vsp = -10
		global.collect = clamp(global.collect-5,0,global.collect)
		state = states.hurt
		sprite_index = spr_hurt
	}
}

// effects
machsnd = noone
machsnd_play = noone
part_time = 0
jumpclouds = 0

set_machsnd = function(sound) {
	if (machsnd == sound)
		exit
	
	if (machsnd != noone)
		audio_stop_sound(machsnd_play)
	
	if (sound != noone) {
		machsnd = sound
		machsnd_play = audio_play_sound(sound, 0, true)
	}else
		machsnd = noone
}

charSPR = function(_char) {
	switch(_char){
		case "N" :
			//Default Sprites
			spr_wallslide=spr_player_wallslide
			spr_wallslidedown=spr_player_wallslidedown
			spr_stop=spr_player_stop
			spr_idle=spr_player_idle
			spr_turn=spr_player_turn
			spr_mach1=spr_player_mach1
			spr_mach2=spr_player_mach2
			spr_mach2jump=spr_player_mach2jump
			spr_mach2fall=spr_player_mach2fall
			spr_mach3=spr_player_mach3
			spr_runland=spr_player_runland
			spr_stopping=spr_player_stopping
			spr_glidejumpstart=spr_player_glidejumpstart
			spr_jump=spr_player_jump
			spr_fall=spr_player_fall
			spr_forkstart=spr_player_forkstart
			spr_backflip=spr_player_backflip
			spr_backflipfall=spr_player_backflipfall
			spr_glidejump=spr_player_glidejump
			spr_glidefallstart=spr_player_glidefallstart
			spr_glidefall=spr_player_glidefall
			spr_bounce=spr_player_bounce
			spr_dive=spr_player_dive
			spr_crouchslip=spr_player_crouchslip
			spr_longjump=spr_player_mach2jump
			spr_longjumpend=spr_player_longjumpend
			spr_hurt=spr_player_hurt
			spr_enterdoor=spr_player_enterdoor
			spr_dies=spr_player_dies
			spr_exitdoor=spr_player_exitdoor
			spr_rolldh=spr_player_rolldh
			spr_entergate=spr_player_entergate
			
			//TV Sprites
			spr_tvMach3=spr_expr_mach3
			spr_tvHurt=spr_expr_hurt
			spr_tvIdle=spr_expr_idle
			spr_tvLaugh=spr_expr_laugh
			
			// Draw Relacted
			spr_palette=spr_player_palette
			palList=[
				["UnNoiseletted",0],
				["The Noise",4],
				["The Doise",5],
				["Mr. Orange",6],
				["El Chico",7],
				["Hardoween Classic",8],
				["Mr Moise",9],
				["Gronch",10],
				["Silent",11],
				["Black Clothes",12],
				["Shitty Noises",13],
				["Oddly Sweet",14],
				["Back into the 30s",16],
				["Frostbiten",17],
				["esioN ehT",18],
				["Triple Doble",19],
				["Actually Black",20],
				["MY EYES",21],
				["Gunose",22],
				["Loise",23],
				["Foise",24],
				["The Noise 2023",25],
				["Almost Naked",26],
				["",27],
				["Pissed Off",28],
				["Palennoise",29],
				["Fiore",30],
				["The Real Doise",31],
			]
			cPalfList=1
			curentPalette=palList[cPalfList][1]
			
			//STATES
			var _funcName="noise"
			var _i=0
			var _name=["normal","jump","wallslide","slide","hurt"]
			repeat(array_length(_name)) {
				variable_instance_set(id,$"state_{_name[_i]}",asset_get_index($"scr_{_funcName}_{_name[_i]}"))
				_i++
			}
		break
	}
}

getInput=function(){
	key_left=-keyboard_check(vk_left)
	key_left2=-keyboard_check_pressed(vk_left)
	key_right=keyboard_check(vk_right)
	key_right2=keyboard_check_pressed(vk_right)
	key_up=keyboard_check(vk_up)
	key_up2=keyboard_check_pressed(vk_up)
	key_down=keyboard_check(vk_down)
	key_down2=keyboard_check_pressed(vk_down)
	key_jump=keyboard_check_pressed(ord("Z"))
	key_jump2=keyboard_check(ord("Z"))
	key_grab=keyboard_check_pressed(ord("X"))
	key_grab2=keyboard_check(ord("X"))
	key_taunt=keyboard_check_pressed(ord("C"))
	key_taunt2=keyboard_check(ord("C"))
	move=key_left+key_right
	upmove=key_up-key_down
}

//Set Behavior
charSPR("N")
getInput()
