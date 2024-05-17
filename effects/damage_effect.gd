class_name DamageEffect;
extends Effect;

var amount := 0;

func execute(_targets: Array[Node]):
	for target in _targets:
		if not target:
			continue ;
		
		if target is Enemy or target is Player:
			target.take_damage(amount);
			SfxPlayer.play(sound);
