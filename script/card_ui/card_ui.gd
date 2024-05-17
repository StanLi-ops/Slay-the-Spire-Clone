class_name CardUI;
extends Control;

# 复原 请求信号
signal reparent_requested(which_card_ui: CardUI);

const BASE_STYLEBOX := preload ("res://tres/card_base_stylebox.tres");
const DRAGGING_STYLEBOX := preload ("res://tres/card_dragging_stylebox.tres");
const HOVER_STYLEBOX := preload ("res://tres/card_hover_stylebox.tres");

@export var card: Card: set = _set_card;
@export var char_stats: CharacterStats: set = _set_char_stats;

@onready var panel = $Panel
@onready var cost = $Cost
@onready var icon = $Icon
@onready var drop_point_detector = $DropPointDetector;
@onready var card_state_machine = $CardStateMachine as CardStateMachine;
@onready var targets: Array[Node] = [];

var original_index := 0;
var parent: Control;
var tween: Tween;
var playable := true: set = _set_playable;
var disable := false;

# 加载 Card 状态机初始化
func _ready():
	Events.card_aim_started.connect(_on_card_drag_or_aiming_started);
	Events.card_aim_ended.connect(_on_card_drag_or_aiming_ended);
	Events.card_drag_started.connect(_on_card_drag_or_aiming_started);
	Events.card_drag_ended.connect(_on_card_drag_or_aiming_ended);
	
	card_state_machine.init(self);

func _input(event: InputEvent):
	card_state_machine.on_input(event);
	
func _on_gui_input(event):
	card_state_machine.on_gui_input(event);
	
func _on_mouse_entered():
	card_state_machine.on_muse_entered();

func _on_mouse_exited():
	card_state_machine.on_muse_exited();

func _on_drop_point_detector_area_entered(area):
	if not targets.has(area):
		targets.append(area);

func _on_drop_point_detector_area_exited(area):
	targets.erase(area);

func animate_to_position(new_position: Vector2, duration: float):
	tween = create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT);
	tween.tween_property(self, "global_position", new_position, duration);

func _set_card(value: Card):
	if not is_node_ready():
		await ready;
	
	card = value;
	cost.text = str(value.cost);
	icon.texture = value.icon;

func play():
	if not card:
		return ;
	
	card.play(targets, char_stats);
	
	queue_free();

func _set_char_stats(value: CharacterStats):
	char_stats = value;
	char_stats.stats_changed.connect(_on_char_stats_changed);

func _set_playable(value: bool):
	playable = value;
	if not playable:
		cost.add_theme_color_override("font_color", Color.RED);
		icon.modulate = Color(1, 1, 1, 0.5);
	else:
		cost.remove_theme_color_override("font_color");
		icon.modulate = Color(1, 1, 1, 2);

func _on_card_drag_or_aiming_started(user_card_ui: CardUI):
	if user_card_ui == self:
		return ;
	
	disable = true;

func _on_card_drag_or_aiming_ended(_user_card_ui: CardUI):
	disable = false;
	self.playable = char_stats.cna_play_check(card);

func _on_char_stats_changed():
	self.playable = char_stats.cna_play_check(card);
