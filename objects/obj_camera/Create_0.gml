live_auto_call

#macro CAMX camera_get_view_x(view_camera[0])
#macro CAMY camera_get_view_y(view_camera[0])
#macro CAMW camera_get_view_width(view_camera[0])
#macro CAMH camera_get_view_height(view_camera[0])
#macro DEBUG (GM_build_type == "run")

chargecam=0
flycam=0
plr=obj_player.id

global.saveroom=ds_list_create()
global.instancelist=ds_list_create()
global.collect=0
global.collectHigh=20
global.fnt_smallfont = font_add_sprite_ext(spr_smallfont1,"ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890:.!?-",0,0)
global.fnt_counter = font_add_sprite_ext(spr_counter,"9876543210: LAP",0,-40)
global.dressing = 0
global.drawTV = 1

pSwap_init_system(shd_pal_swapper)
