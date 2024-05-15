class_name ManaUI;
extends Panel;

@export var stats: CharactorStats: set = _set_characotor_stats;

@onready var mana_label = $ManaLabel

func _ready():
	await get_tree().create_timer(2).timeout;
	stats.mana = 3;

func _set_characotor_stats(value: CharactorStats):
	stats = value;
	
	if not stats.stats_changed.is_connected(_on_stats_changed):
		stats.stats_changed.connect(_on_stats_changed);
	
	if not is_node_ready():
		await ready;
	
	_on_stats_changed();

func _on_stats_changed():
	mana_label.text = "%s/%s" % [stats.mana, stats.max_mana];
