extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var timer = $Timer

func _ready():
	Events.player_hit.connect(_on_player_hit);
	
func _on_player_hit():
	color_rect.color.a = 0.25;
	timer.start();

func _on_timer_timeout():
	color_rect.color.a = 0.0;
