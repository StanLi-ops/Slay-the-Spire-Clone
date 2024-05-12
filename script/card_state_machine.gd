class_name CardStateMachine;
extends Node;

@export var initial_state: CardState;

var current_state: CardState;
var states := {};

func init(card: CardUI) -> void:
	for child in get_children():
		if child is CardState:
			states[child.state] = child;
			child.transition_requested.connect(_on_transition_requested);
			child.card_ui = card;
