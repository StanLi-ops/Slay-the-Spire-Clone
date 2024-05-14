class_name Enemy;
extends Area2D;

const ARROW_OFFSET := 5;

@export var stats: Stats: set = set_enemy_stats;

@onready var sprite_2d = $Sprite2D;
@onready var arrow = $Arrow;
@onready var stats_ui = $StatsUI;

# test
func _ready():
	await get_tree().create_timer(2.0).timeout;
	take_damage(5);
	stats.block += 5;

func set_enemy_stats(value: Stats):
	stats = value.create_instance();
	
	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats);
	
	update_enemy();

func update_stats():
	stats_ui.update_stats(stats);

func update_enemy():
	if not stats is Stats:
		return;
	
	if not is_inside_tree():
		await ready;
	
	sprite_2d.texture = stats.art;
	arrow.position = Vector2.RIGHT * (sprite_2d.get_rect().size.x / 2 + ARROW_OFFSET);
	update_stats();

func take_damage(damage: int):
	if stats.health <= 0:
		return;
	
	stats.take_damage(damage);
	
	if stats.health <= 0:
		queue_free();


func _on_area_entered(_area):
	arrow.visible = true;


func _on_area_exited(_area):
	arrow.visible = false; # Replace with function body.
