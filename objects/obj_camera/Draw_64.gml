live_auto_call

if(!global.drawTV||global.dressing||!instance_exists(plr))
	exit
	
if(plr.inv>0||plr.state==states.hurt)
	sprite_index=plr.spr_tvHurt
else if(plr.getLife>0)
	sprite_index=plr.spr_tvLaugh
else if(plr.movespeed>16&&plr.state!=states.slide)
	sprite_index=plr.spr_tvMach3
else
	sprite_index=plr.spr_tvIdle

pSwap_set(plr.sPalette,plr.curentPalette,1)// Draw TV
draw_sprite(sprite_index,image_index,1250,20)
scr_shaders_reset()
draw_sprite(spr_expr_frontTV,0,1250,20) // Draw TV Front

for(var i=0;i<max(plr.hp,4);i++)
	draw_sprite_ext(spr_healthHUD,0,32+78*i,16,1,1,0,i>=plr.hp?c_black: c_white,1);
draw_healthbar(32,112,288,128,(plr.movespeed/19)*100,c_black,c_blue,c_red,0,true,true);
draw_set_font(global.fnt_counter)
draw_text(96,158,global.collect)