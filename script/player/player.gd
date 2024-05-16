class_name Player;
extends Node2D;

@export var char_stats: CharacterStats: set = _set_char_stats;

@onready var sprite_2d = $Sprite2D;
@onready var stats_ui = $StatsUI as StatsUI;

func _set_char_stats(value: CharacterStats):
	char_stats = value;
	
	if not char_stats.stats_changed.is_connected(update_stats):
		char_stats.stats_changed.connect(update_stats);
	
	update_player();

func update_player():
	if not char_stats is CharacterStats:
		return;
	
	if not is_inside_tree():
		await ready;
	
	sprite_2d.texture = char_stats.art;
	update_stats();

func update_stats():
	stats_ui.update_stats(char_stats);

func take_damage(damage: int):
	if char_stats.health <= 0:
		return;
	
	char_stats.take_damage(damage);
	
	if char_stats.health <= 0:
		Events.player_died.emit();
		queue_free();
