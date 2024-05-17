class_name Player;
extends Node2D;

const WHITE_SPRITE_MATERIAL = preload("res://art/white_sprite_material.tres")

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
		return ;
	
	if not is_inside_tree():
		await ready;
	
	sprite_2d.texture = char_stats.art;
	update_stats();

func update_stats():
	stats_ui.update_stats(char_stats);

func take_damage(damage: int):
	if char_stats.health <= 0:
		return ;
	
	sprite_2d.material = WHITE_SPRITE_MATERIAL;
	
	var tween := create_tween();
	tween.tween_callback(Shaker.shake.bind(self, 16, 0.15));
	tween.tween_callback(char_stats.take_damage.bind(damage));
	tween.tween_interval(0.17);
	
	tween.finished.connect(
		func():
			sprite_2d.material = null;
			
			if char_stats.health <= 0:
				Events.player_died.emit();
				queue_free();
	);
