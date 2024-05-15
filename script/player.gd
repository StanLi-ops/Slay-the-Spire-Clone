class_name Player;
extends Node2D;

@export var stats: CharactorStats: set = _set_characotor_stats;

@onready var sprite_2d = $Sprite2D;
@onready var stats_ui = $StatsUI as StatsUI;

func _set_characotor_stats(value: CharactorStats):
	stats = value.create_instance();
	
	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats);
	
	update_player();

func update_player():
	if not stats is CharactorStats:
		return;
	
	if not is_inside_tree():
		await ready;
	
	sprite_2d.texture = stats.art;
	update_stats();

func update_stats():
	stats_ui.update_stats(stats);

func take_damage(damage: int):
	if stats.health <= 0:
		return;
	
	stats.take_damage(damage);
	
	if stats.health <= 0:
		queue_free();
