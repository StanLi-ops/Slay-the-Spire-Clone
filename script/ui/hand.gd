class_name Hand;
extends HBoxContainer;

@export var char_stats: CharacterStats;
@onready var card_ui = preload ("res://scenes/card_ui.tscn");

func add_card(card: Card):
	var new_card_ui = card_ui.instantiate();
	add_child(new_card_ui);
	
	new_card_ui.reparent_requested.connect(_on_card_ui_reparent_requested);
	new_card_ui.card = card;
	new_card_ui.parent = self;
	new_card_ui.char_stats = char_stats;

func discard_card(cardUi: CardUI):
	cardUi.queue_free();

func disable_hand():
	for cardUi: CardUI in get_children():
		cardUi.disable = true;

# 重定节点父级
func _on_card_ui_reparent_requested(child: CardUI):
	child.disable = true;
	
	child.reparent(self);
	
	var new_index := clampi(child.original_index, 0, get_child_count());
	move_child.call_deferred(child, new_index);
	
	child.set_deferred("disable", false);
