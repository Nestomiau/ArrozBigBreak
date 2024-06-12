function scr_noise_normal(){
		hsp = xscale * movespeed;
		
		if (place_meeting(x + sign(hsp), y, obj_solid) or scr_solid_slope(x + sign(hsp), y))&& (!place_meeting(x + hsp, y, obj_destroyable) or movespeed <= 12) {
			if place_meeting(x, y + 1, obj_slope) {
				vsp = -movespeed;
				sound_play_3d(sfx_wallslide, x, y);
			
				state = states.wallslide;
				sprite_index = spr_wallslide;
				grounded = false;
				movespeed = 0;
				
				exit;
			}
			movespeed = 0;
		}
		
		if sprite_index == spr_stop
		{
			if image_index >= image_number - 1
			{
				image_index = 0;
				sprite_index = spr_idle;
			}
		}
		else if sprite_index == spr_turn
		{
			if image_index >= image_number - 1
				sprite_index = spr_mach2;
		}
		else if (movespeed == 0)
			sprite_index = spr_idle;
		
		if movespeed < 12
			mach2 = 0;
		
		if move != xscale && movespeed > 0
		{
			if sprite_index != spr_stopping
			{
				create_particle(x, y, spr_dashcloud, xscale);
				if mach2 >= mach2_time
				{
					audio_stop_sound(sfx_stop);
					sound_play_3d(sfx_stop, x, y);
				}
				sprite_index = spr_stopping;
			}
			mach2 = 0;
			
			movespeed = Approach(movespeed, 0, 0.7);
			if movespeed == 0 && move != 0
			{
				xscale = move;
				image_index = 0;
				sprite_index = spr_turn;
			}
			else if movespeed == 0
			{
				image_index = 0;
				sprite_index = spr_stop;
			}
		}
		else if move != 0 && !place_meeting(x + move, y, obj_solid)
		{
			if ++part_time >= 16
			{
				part_time = 0;
				create_particle(x, y, spr_dashcloud, xscale);
			}
			
			xscale = move;
			if sprite_index != spr_mach1 && sprite_index != spr_mach2 && sprite_index != spr_mach3 && sprite_index != spr_runland && sprite_index != spr_turn
			{
				image_index = 0;
				sprite_index = spr_mach1;
			}
			if image_index >= image_number - 1 && (sprite_index == spr_mach1 || sprite_index == spr_runland || sprite_index == spr_turn)
				sprite_index = spr_mach2;
			
			if mach2 < mach2_time && movespeed <= 12
			{
				if movespeed < 12
					movespeed += 0.4;
				else
					mach2++;
			}
			else
			{
				mach2 = mach2_time;
				
				sprite_index = spr_mach3;
				if movespeed < 16
					movespeed = Approach(movespeed, 16, 0.4);
				else if movespeed < 19
					movespeed = Approach(movespeed, 19, 0.01);
			}
			scr_player_addslopemomentum(0.08, 0.04);
		}
		
		if input_buffer_jump
		{
			input_buffer_jump = 0;
			create_particle(x, y, spr_highjumpcloud2);
			
			jumpstop = false;
			state = states.jump;
			
			if xscale != move && move != 0
			{
				sound_play_3d(sfx_jump, x, y);
				sprite_index = spr_backflip;
				vsp = -16;
				xscale = move;
				movespeed = 2;
				
				jumpclouds = 10;
			}
			else if mach2 >= mach2_time
			{
				sound_play_3d(sfx_highjump, x, y);
				sprite_index = spr_glidejumpstart;
				vsp = -16;
				jumpclouds = 16;
			}
			else
			{
				sound_play_3d(sfx_jump, x, y);
				vsp = -14;
				
				if movespeed >= 12
				{
					sprite_index = spr_mach2jump;
					jumpclouds = 10;
				}
				else
					sprite_index = spr_jump;
			}
		}
		
		if !grounded
		{
			state = states.jump;
			sprite_index = spr_fall;
		}
		else if key_down
		{
			sound_play_3d(sfx_slide, x, y);
			movespeed = max(movespeed, 10);
			
			state = states.slide;
			image_index = 0;
			sprite_index = spr_forkstart;
		}
}

function scr_noise_jump(){
		hsp = xscale * movespeed;
		
		if --jumpclouds > 0 && vsp < 0
		{
			if ++part_time >= (16 - jumpclouds) / 3
			{
				part_time = 0;
				create_particle(x, y + 50, spr_cloudeffect);
			}
		}
		else if movespeed >= 16
		{
			if ++part_time >= 8
			{
				part_time = 0;
				create_particle(x, y, spr_cloudeffect);
			}
		}
		
		if !jumpstop && !key_jump2 && vsp < 0
		{
			jumpstop = true;
			vsp = 0;
		}
		
		if move != xscale
		{
			var spd = 0.4;
			if move == 0
				spd = 0.1;
			
			movespeed = Approach(movespeed, 0, move == 0 ? 0.1 : 0.4);
			if movespeed == 0 && move != 0 && sprite_index != spr_backflip && sprite_index != spr_backflipfall
				xscale = move;
		}
		else if movespeed < 10
		{
			var spd = 0.4;
			if sprite_index == spr_backflip
				spd = 0.2;
			movespeed = Approach(movespeed, 10, spd);
		}
		
		if sprite_index == spr_glidejump && vsp >= 0
		{
			image_index = 0;
			sprite_index = spr_glidefallstart;
		}
		
		if image_index >= image_number - 1
		{
			switch sprite_index
			{
				case spr_jump:
					sprite_index = spr_fall;
					break;
				case spr_glidejumpstart:
					sprite_index = spr_glidejump;
					break;
				case spr_glidefallstart:
					sprite_index = spr_glidefall;
					break;
				case spr_mach2jump:
					sprite_index = spr_mach2fall;
					break;
				case spr_backflip:
					sprite_index = spr_backflipfall;
					break;
			}
		}
		
		if grounded
		{
			create_particle(x, y, spr_landcloud);
			sound_play_3d(sfx_land, x, y);
			
			state = states.normal;
			image_index = 0;
			sprite_index = move != 0 ? spr_runland : spr_idle;
		}
		
		if place_meeting(x + sign(hsp), y, obj_solid)
		&& (!place_meeting(x + hsp, y, obj_destroyable) or movespeed <= 12)
		{
			if state == states.bounce
				movespeed = 0;
			else
			{
				sound_play_3d(sfx_wallslide, x, y);
			
				state = states.wallslide;
				sprite_index = spr_wallslide;
				vsp = min(vsp, 0);
			}
		}
		
		if movespeed > 2 && key_down2
		{
			sound_play_3d(sfx_groundpound, x, y);
			
			state = states.slide;
			sprite_index = spr_dive;
			vsp = 10;
		}
}

function scr_noise_wallslide() {
	movespeed = 0
	
	if (++part_time >= 8){
		part_time = 0
		create_particle(x + xscale * 10, y, spr_cloudeffect)
	}
	
	if (grounded) {
		sound_play_3d(sfx_land, x, y)
		create_particle(x, y, spr_landcloud)
		state = states.normal
	}
	vsp = min(vsp, 8)
	sprite_index = vsp > 0 ? spr_wallslidedown : spr_wallslide;
	if (!place_meeting(x + xscale, y, obj_solid) || move == -xscale) {
		sprite_index = spr_fall;
		image_index = 0;
		state = states.jump;
	}else if (input_buffer_jump){
		input_buffer_jump = 0
		sound_play_3d(sfx_jump, x, y)
		xscale *= -1
		movespeed = 10
		state = states.jump
		sprite_index = spr_bounce
		vsp = -14
	}
}

function scr_noise_slide(){
	hsp=xscale*movespeed
	if ((place_meeting(x + sign(hsp), y, obj_solid) || scr_solid_slope(x + sign(hsp), y)) && !place_meeting(x + hsp, y, obj_destroyable))
		movespeed = 0;
	
	if (sprite_index == spr_forkstart && image_index >= image_number - 1)
		sprite_index = spr_crouchslip
	if(sprite_index == spr_dive && movespeed < 19) {movespeed += (movespeed < 16)?.4:0.2}
	
	if (grounded){
		if (sprite_index == spr_dive) {
			sound_play_3d(sfx_land, x, y)
			
			state = states.normal
			sprite_index = spr_runland
			image_index = 0
		}else {
			if (++part_time >= 16) {
				part_time = 0
				create_particle(x, y, spr_dashcloud, xscale)
			}
			movespeed = Approach(movespeed, 0, 0.1)
		
			if (movespeed <= 0) {
				if(sprite_index == spr_rolldh && check_slope_at(x,y+1)) {
					xscale*=-1
					movespeed=0.2
				}else
					state = states.normal
			}
		
			if (input_buffer_jump) {
				input_buffer_jump = 0
				sound_play_3d(sfx_jump, x, y)
				create_particle(x, y, spr_highjumpcloud2)
			
				jumpstop = false
				sprite_index = spr_longjump
				image_index = 0
				state = states.jump
				vsp = -14
				jumpclouds = 12
			}
			var _a = (sprite_index == spr_rolldh)?[.6,-1,25]:[.2,12,19]
			scr_player_addslopemomentum(.4,_a[0],_a[1],_a[2])
		}
	}else if (place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + hsp, y, obj_destroyable)) {
		sound_play_3d(sfx_wallslide, x, y)
		state = states.wallslide
		sprite_index = spr_wallslide
	}
}

function scr_noise_hurt() {
	if (grounded&&vsp>=0) {
		state=states.normal
		movespeed=0
		inv=80
	}
}

function scr_noise_dresser() {
	if(abs(move)) { 
		if(-key_left2&&cPalfList>0){
			cPalfList--
		}
		if (key_right2&&cPalfList<array_length(palList)-1){
			cPalfList++
		}
		curentPalette=palList[cPalfList][1]
	}
	if(key_jump){
		state=states.normal
		global.dressing=0
	}
}

function scr_noise_dead() {
	sprite_index = spr_dies
	movespeed*=0.96
	if(ofScreen)
		deadCooldown--
	if(deadCooldown<=0)
		game_restart()
}