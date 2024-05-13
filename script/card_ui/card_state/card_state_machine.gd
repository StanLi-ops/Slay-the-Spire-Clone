class_name CardStateMachine;
extends Node;

# 初始状态
@export var initial_state: CardState;

# 当前状态
var current_state: CardState;
# 状态集
var states := {};

func init(card_ui: CardUI):
	# 获取并便利所有子节点
	# 判断子节点是否为 CardState
	# 如果是，。。。。
	for child in get_children():
		if child is CardState:
			states[child.state] = child;
			child.transition_requested.connect(on_transition_requested);
			child.card_ui = card_ui;
	
	if initial_state:
		initial_state.enter();
		current_state = initial_state;

func on_input(event: InputEvent):
	if current_state:
		current_state.on_input(event);

func on_gui_input(event: InputEvent):
	if current_state:
		current_state.on_gui_input(event);

func on_muse_entered():
	if current_state:
		current_state.on_muse_entered();

func on_muse_exited():
	if current_state:
		current_state.on_muse_exited();

func on_transition_requested(from: CardState, to: CardState.State):
	if from != current_state:
		return;
	var new_state: CardState = states[to];
	
	if not new_state:
		return;
	if current_state:
		current_state.exit();
	
	new_state.enter();
	current_state = new_state;
