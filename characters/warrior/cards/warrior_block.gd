extends Card;

func apply_effect(_targets: Array[Node]):
	var block_effect := BlockEffect.new();
	block_effect.amount = 6;
	block_effect.sound = sound;
	block_effect.execute(_targets);
