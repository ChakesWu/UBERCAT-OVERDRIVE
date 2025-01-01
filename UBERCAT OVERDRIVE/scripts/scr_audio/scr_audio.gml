

global.mastergain = 1;
global.music = -1;

global.gain_def = {};
gaindef(snd_carcrash,.81);
gaindef(snd_unlock,.71);
gaindef(snd_takeoff,.71);
gaindef(snd_pickup,.8);
gaindef(snd_grounded,.52);
gaindef(snd_flight,.61);
gaindef(snd_explosion2,.69);
gaindef(snd_charge,.56);


function sound_set_gain(ind, g, frames = 0) {
    var sound_name = audio_get_name(ind);
    
    var base_gain = variable_struct_exists(global.gain_def, sound_name) 
        ? global.gain_def[$ sound_name] 
        : 1;
    
    var final_gain = base_gain * g;
    
    var transition_time = frames * (1000 / 30);
    
    audio_sound_gain(ind, final_gain, transition_time);
}
function gaindef(sound,gain) {
	global.gain_def[$ sound] = gain;
}
function adjust_volume(gain=global.mastergain) {
	
	global.mastergain = clamp(gain,0,1);
	
	audio_set_master_gain(0,global.mastergain);
	
	
	for(var i=0; audio_exists(i); i++) { //lol
		sound_set_gain(i,global.mastergain);
	}
	
}
adjust_volume();


function sfx_play(snd,pit=1,interrupt=true) {
	
	if interrupt || !audio_is_playing(snd) {
		var a = audio_play_sound(snd,0,false);
		audio_sound_pitch(a,pit);
	}
	
}

global.listener_speedmult = 4;
global.falloff_dist = 50
global.falloff_max = 100
global.falloff_factor = 1;
audio_falloff_set_model(audio_falloff_exponent_distance);

function sfx_play_3d(snd,xx,yy,zz,pit=1,interrupt=true) {
	
	if interrupt || !audio_is_playing(snd) {
		var a = audio_play_sound_at(snd,xx,yy,zz,global.falloff_dist,global.falloff_max,global.falloff_factor,false,0);
		audio_sound_pitch(a,pit);
	}
	
}
