live_auto_call

if(state==states.dresser||state==states.dead ||state==states.actor||other.state)
	exit

x=other.x
y=other.y-14
xscale=other.image_xscale
state=states.normal
other.plr=self
if(movespeed>=other.minspeed)
	movespeed+=other.force
else
	movespeed=other.minspeed
other.state=1
audio_play_sound(sfx_dash,0,0)