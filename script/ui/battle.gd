extends Node2D

@export var char_stats: CharacterStats;
@export var music: AudioStream;

@onready var better_ui = $BetterUI
@onready var player = $Player
@onready var player_handler = $PlayerHandler
@onready var enemy_handler = $EnemyHandler

func _ready():
	var new_char_stats := char_stats.create_instance();
	better_ui.char_stats = new_char_stats;
	player.char_stats = new_char_stats;
	
	Events.enemy_turn_ended.connect(_on_enemy_turn_ended);
	
	Events.player_turn_ended.connect(player_handler.ended_turn);
	Events.player_hand_discarded.connect(enemy_handler.start_turn);
	Events.player_died.connect(_on_player_died);
	
	start_battle(new_char_stats);

func start_battle(character_stats: CharacterStats):
	get_tree().paused = false;
	MusicPlayer.play(music, true);
	enemy_handler.reset_enemy_actions();
	player_handler.start_battle(character_stats);

func _on_enemy_turn_ended():
	player_handler.start_turn()
	enemy_handler.reset_enemy_actions()

func _on_enemy_handler_child_order_changed():
	if enemy_handler.get_child_count() == 0:
		Events.battle_over_screen_requested.emit("Victorious", BattleOverPanel.Type.WIN);

func _on_player_died():
	Events.battle_over_screen_requested.emit("Game Over", BattleOverPanel.Type.LOSS);
