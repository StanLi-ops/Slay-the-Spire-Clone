class_name Hand;
extends HBoxContainer;


func _ready():
	# 监控子节点，如果为CardUI，则重定CardUI的父级.
	for child in get_children():
		var card_ui := child as CardUI;
		card_ui.parent = self;
		card_ui.reparent_requested.connect(_on_card_ui_reparent_requested);

# 重定节点父级
func _on_card_ui_reparent_requested(child: CardUI):
	child.reparent(self);
