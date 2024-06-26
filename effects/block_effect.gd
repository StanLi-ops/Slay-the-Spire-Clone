class_name BlockEffect;
extends Effect;

var amount := 0;

func execute(_targets: Array[Node]):
	for target in _targets:
		if not target:
			continue ;
		
		if target is Enemy:
			target.enemy_stats.block += amount;
			SfxPlayer.play(sound);
		
		if target is Player:
			target.char_stats.block += amount;
			SfxPlayer.play(sound);
