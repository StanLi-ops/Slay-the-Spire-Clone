extends Card;

func apply_effect(_targets: Array[Node]):
	var damage_effect := DamageEffect.new();
	damage_effect.amount = 6;
	damage_effect.sound = sound;
	damage_effect.execute(_targets);
