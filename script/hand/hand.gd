class_name Hand;
extends HBoxContainer;

var cards_played_this_turn := 0;

func _ready():
	Events.card_played.connect(_on_card_played);
	
	# 监控子节点，如果为CardUI，则重定CardUI的父级.
	for child in get_children():
		var card_ui := child as CardUI;
		card_ui.parent = self;
		card_ui.reparent_requested.connect(_on_card_ui_reparent_requested);

# 重定节点父级
func _on_card_ui_reparent_requested(child: CardUI):
	child.reparent(self);
	
	var new_index := clampi(child.original_index - cards_played_this_turn, 0, get_child_count());
	move_child.call_deferred(child, new_index);

func _on_card_played(_card: Card):
	cards_played_this_turn += 1;

