live_auto_call

pSwap_set(sPalette,curentPalette,1)
draw_sprite_ext(sprite_index,-1,x,y,image_xscale*xscale,image_yscale*yscale,angle,image_blend,image_alpha)
scr_shaders_reset()
if(global.isDebug&&global.debugConfig.plrshowHitbox)
	draw_sprite(mask_index,0,x,y)
