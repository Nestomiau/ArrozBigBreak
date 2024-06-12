live_auto_call

if(global.dressing) { // Dressing HUD

	draw_sprite_stretched(spr_gameframe_caption,1,0,0,SCREEN_WIDTH,SCREEN_HEIGHT)

	pSwap_set(sPalette,curentPalette,1)
	draw_sprite_ext(sprite_index,image_index,SCREEN_WIDTH/2,SCREEN_HEIGHT/2,5,5,0,c_white,1)
	scr_shaders_reset()
	draw_set_font(global.fnt_smallfont)
	draw_set_halign(fa_center)
	draw_text(SCREEN_WIDTH/2,SCREEN_HEIGHT/2+230,string_upper(palList[cPalfList][0]))
	draw_set_halign(fa_right)
}