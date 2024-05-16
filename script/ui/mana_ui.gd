class_name ManaUI;
extends Panel;

@export var char_stats: CharacterStats: set = _set_char_stats;

@onready var mana_label = $ManaLabel

#test
#func _ready():
	#await get_tree().create_timer(1).timeout;
	#char_stats.mana = 3;

func _set_char_stats(value: CharacterStats):
	char_stats = value;
	
	if not char_stats.stats_changed.is_connected(_on_stats_changed):
		char_stats.stats_changed.connect(_on_stats_changed);
	
	if not is_node_ready():
		await ready;
	
	_on_stats_changed();

func _on_stats_changed():
	mana_label.text = "%s/%s" % [char_stats.mana, char_stats.max_mana];
