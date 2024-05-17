extends Node

func play(audio: AudioStream, signle: bool = false):
	if not audio:
		return ;
	
	if signle:
		stop();
	
	for player: AudioStreamPlayer in get_children():
		if not player.playing:
			player.stream = audio;
			player.play();
			break ;

func stop():
	for player: AudioStreamPlayer in get_children():
			player.stop();
