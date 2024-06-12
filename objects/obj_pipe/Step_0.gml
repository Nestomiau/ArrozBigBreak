cooldown--
if(cooldown <= 0 && plr != noone) {
	send = 1
	if(!instance_place(x,y,plr)){
		send = 0
		plr = noone
	}
}

image_index=type

