class_name CardUI;
extends Control;

# 复原 请求信号
signal reparent_requested(which_card_ui: CardUI);

@export var card: Card;

@onready var color = $Color;
@onready var state = $State;
@onready var drop_point_detector = $DropPointDetector;
@onready var card_state_machine = $CardStateMachine as CardStateMachine;
@onready var targets: Array[Node] = [];

var parent : Control;
var tween : Tween;

# 加载 Card 状态机初始化
func _ready():
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
