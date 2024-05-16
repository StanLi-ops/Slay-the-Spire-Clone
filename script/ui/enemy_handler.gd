class_name EnemyHandler;
extends Node2D

func _ready():
	Events.enemy_action_completed.connect(_on_enemy_action_completed);

func reset_enemy_actions():
	var enemy : Enemy;
	
	for chile in get_children():
		enemy = chile as Enemy;
		enemy.current_action = null;
		enemy.update_action();

func start_turn():
	if get_child_count() == 0:
		return;
	
	var first_enemy := get_child(0) as Enemy;
	first_enemy.do_turn();
	
	#for enemy: Enemy in get_children():
		#acting_enemies.append(enemy)

func _on_enemy_action_completed(enemy: Enemy):
	if enemy.get_index() == get_child_count() - 1:
		Events.enemy_turn_ended.emit();
		return;
	
	var next_enmey := get_child(enemy.get_index() + 1) as Enemy;
	next_enmey.do_turn();
