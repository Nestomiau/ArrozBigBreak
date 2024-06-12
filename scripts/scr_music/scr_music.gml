function scr_music_addSong(_song,_idx=1,_endTrigger=-4,workList=[]) {
	ds_list_add(global.musics,[_song,_endTrigger,workList])
	ds_list_add(global.rmTrigger,_idx)
}

function scr_music_playSong(_trigger) {
	var _idx=ds_list_find_index(global.rmTrigger,_trigger)
	if(_idx>-1) {
		var _val=ds_list_find_value(global.musics,_idx)
		if(array_get_index(_val[2],playSong)>-1)
			exit
		audio_stop_sound(playSong)
		audio_play_sound(_val[0],100,0)
		playSong=_val[0]
		endTrigger=_val[1]
	}
}