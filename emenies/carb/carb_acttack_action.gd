extends EnemyAction

@export var damage := 6;

func perform_action():
	if not enemy or not target:
		return;
	
	var tween = create_tween().set_trans(Tween.TRANS_QUINT);
	var start_position := enemy.global_position; 
	var end_position := target.global_position + Vector2.RIGHT * 32; 
	var damage_effect := DamageEffect.new();
	var target_array: Array[Node] = [target];
	
	damage_effect.amount = damage;
	
	tween.tween_property(enemy, "global_position", end_position, 0.4);
	tween.tween_callback(damage_effect.execute.bind(target_array));
	tween.tween_interval(0.25);
	tween.tween_property(enemy, "global_position", start_position, 0.4);
	
	tween.finished.connect(
		func (): Events.enemy_action_completed.emit(enemy);
	); 
