class_name Enemy;
extends Area2D;

const ARROW_OFFSET := 5;

@export var enemy_stats: EnemyStats: set = _set_enemy_stats;

@onready var sprite_2d = $Sprite2D;
@onready var arrow = $Arrow;
@onready var stats_ui = $StatsUI;

var enemy_action_picker: EnemyActionPicker;
var current_action: EnemyAction: set = _set_current_action;

func _set_current_action(value: EnemyAction):
	current_action = value;

func _set_enemy_stats(value: EnemyStats):
	enemy_stats = value.create_instance();
	
	if not enemy_stats.stats_changed.is_connected(update_stats):
		enemy_stats.stats_changed.connect(update_stats);
		enemy_stats.stats_changed.connect(update_action);
	
	update_enemy();

func setup_ai():
	if enemy_action_picker:
		enemy_action_picker.queue_free();
	
	var new_action_picker: EnemyActionPicker = enemy_stats.ai.instantiate();
	add_child(new_action_picker);
	enemy_action_picker = new_action_picker;
	enemy_action_picker.enemy = self;

func update_stats():
	stats_ui.update_stats(enemy_stats);

func update_action():
	if not enemy_action_picker:
		return ;
	
	if not current_action:
		current_action = enemy_action_picker.get_action();
		return ;
	
	var new_conditional_action := enemy_action_picker.get_first_conditional_action();
	if new_conditional_action and current_action != new_conditional_action:
		current_action = new_conditional_action;

func update_enemy():
	if not enemy_stats is EnemyStats:
		return ;
	
	if not is_inside_tree():
		await ready;
	
	sprite_2d.texture = enemy_stats.art;
	arrow.position = Vector2.RIGHT * (sprite_2d.get_rect().size.x / 2 + ARROW_OFFSET);
	
	setup_ai();
	update_stats();

func do_turn():
	enemy_stats.block = 0;
	
	if not current_action:
		return ;
	
	current_action.perform_action();

func take_damage(damage: int):
	if enemy_stats.health <= 0:
		return ;
	
	enemy_stats.take_damage(damage);
	
	if enemy_stats.health <= 0:
		queue_free();

func _on_area_entered(_area):
	arrow.visible = true;

func _on_area_exited(_area):
	arrow.visible = false;
