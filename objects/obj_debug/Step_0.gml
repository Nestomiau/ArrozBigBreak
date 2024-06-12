if(keyboard_check_pressed(vk_f4))
	global.isDebug=(!global.isDebug)

if(!global.isDebug)
	exit

if(mouse_check_button_pressed(mb_left)&&global.debugConfig.plrgotoMouse){
	with(obj_player){
		x=mouse_x
		y=mouse_y
	}
}