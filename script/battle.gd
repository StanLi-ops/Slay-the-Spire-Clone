extends Node2D

@export var char_stats: CharacterStats;

@onready var better_ui = $BetterUI
@onready var player = $Player
@onready var player_handler = $PlayerHandler

func _ready():
	var new_char_stats := char_stats.create_instance();
	better_ui.char_stats = new_char_stats;
	player.char_stats = new_char_stats;
	
	Events.player_turn_ended.connect(player_handler.ended_turn);
	Events.player_hand_discarded.connect(player_handler.start_turn);
	
	start_battle(new_char_stats);

func start_battle(character_stats: CharacterStats):
	player_handler.start_battle(character_stats);
