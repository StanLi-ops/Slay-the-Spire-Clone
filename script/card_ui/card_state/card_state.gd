class_name CardState;
extends Node;

# 卡片 状态 集
enum State {BASE, CLICKED, DRAGGING, AIMING, RELEASED};

# 转化状态 请求信号 
signal transition_requested(from: CardState, to: State);

# 声明 卡片 状态 类型
@export var state: State;

var card_ui: CardUI;

func enter():
	pass;

func exit():
	pass;

func on_input(_event: InputEvent):
	pass;

func on_gui_input(_event: InputEvent):
	pass;

func on_muse_entered():
	pass;

func on_muse_exited():
	pass;
