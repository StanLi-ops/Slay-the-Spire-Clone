class_name BattleOverPanel;
extends Panel;

enum Type {WIN, LOSS};

@onready var label = %Label
@onready var continue_button = %ContinueButton
@onready var restart_button = %RestartButton

func _ready():
	hide();
	Events.battle_over_screen_requested.connect(show_screen);

func _on_continue_button_pressed():
	get_tree().quit();

func _on_restart_button_pressed():
	get_tree().reload_current_scene();

func show_screen(text: String, type: Type):
	label.text = text;
	continue_button.visible = type == Type.WIN;
	restart_button.visible = type == Type.LOSS;
	
	show();
	get_tree().paused = true;
