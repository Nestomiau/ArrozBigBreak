surface_free(sPalette)
sPalette=surface_create(sprite_get_width(spr_palette),sprite_get_height(spr_palette))
surface_set_target(sPalette)
draw_sprite(spr_palette,0,0,0)
surface_reset_target()