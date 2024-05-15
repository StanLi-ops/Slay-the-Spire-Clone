class_name BattleUI;
extends CanvasLayer;

@export var char_stats: CharacterStats: set = _set_char_stats;

@onready var hand = $Hand
@onready var mana_ui = $ManaUI
@onready var end_turn_button = %EndTurnButton

func _ready():
	Events.player_hand_darwn.connect(_on_player_hand_darwn);
	end_turn_button.pressed.connect(_on_end_turn_button_pressed);

func _set_char_stats(value: CharacterStats):
	char_stats = value;
	hand.char_stats = value;
	mana_ui.char_stats = value;

func _on_player_hand_darwn():
	end_turn_button.disabled = false;

func _on_end_turn_button_pressed():
	end_turn_button.disabled = true;
	Events.player_turn_ended.emit();
