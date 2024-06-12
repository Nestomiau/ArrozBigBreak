live_auto_call

global.musics=ds_list_create()
global.rmTrigger=ds_list_create()

scr_music_addSong(mu_ntest2_start,harroz_1,"nTest2Loop",[mu_ntest2_start,mu_ntest2_loop])
scr_music_addSong(mu_ntest2_loop,"nTest2Loop","nTest2Loop",[mu_ntest2_loop,mu_ntest2_start])
scr_music_addSong(mu_sundogFunk_start,junkbeach_1,"sundogLoop",[mu_sundogFunk_start,mu_sundogFunk_loop])
scr_music_addSong(mu_sundogFunk_loop,"sundogLoop","sundogLoop",[mu_sundogFunk_start,mu_sundogFunk_loop])


endTrigger=-4
playSong=-4