live_auto_call

if(state==states.dresser||state==states.dead)
	exit

targetRoom=other.targetRoom
targetDoor=other.targetDoor
x=lerp(other.bbox_left,other.bbox_right,0.5)

if(!instance_exists(obj_fadeout))
	instance_create(0,0,obj_fadeout)