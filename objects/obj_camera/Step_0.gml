live_auto_call

if (instance_exists(plr)) {	
	x=plr.x-CAMW/2
	y=plr.y-CAMH/2
	if (plr.object_index=obj_player) {
		chargecam = Approach(chargecam,plr.movespeed*plr.xscale*4,2);
		if (plr.state==states.jump&&plr.mach2>=plr.mach2_time&&plr.vsp<0)
			flycam=Approach(flycam,100,2)
		else
			flycam=Approach(flycam,-50,plr.vsp>0?4:2)
		
		x+=chargecam
		y+=flycam
	}
	
	x=clamp(x,0,room_width-CAMW)
	y=clamp(y,0,room_height-CAMH)

	camera_set_view_pos(view_camera[0],x,y)
	
	plr.ofScreen=(plr.y>room_height)
}

if(global.collect<global.collectHigh-20)
	global.collectHigh-=20

audio_falloff_set_model(audio_falloff_exponent_distance)
audio_listener_position(-(CAMX+CAMW/2),CAMY+CAMH/2,0)