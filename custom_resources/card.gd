class_name Card;
extends Resource;

enum Type {ATTACK, DEFEND, POWER};
enum Target {SELF, SINGLE_ENEMY, ALL_ENEMIES, EVERYONE};

@export_group("Card Attributes")
@export var id: String;
@export var type: Type;
@export var target: Target;
@export var cost: int;

@export_group("Card Visuals")
@export var icon: Texture;
@export_multiline var tooltip_text: String;

func is_single_targeted() -> bool:
	return target == Target.SINGLE_ENEMY;

func _get_targets(targets: Array[Node]) -> Array[Node]:
	if not targets:
		return [];
	
	var tree := targets[0].get_tree();
	
	match target:
		Target.SELF:
			return tree.get_nodes_in_group("player");
		Target.ALL_ENEMIES:
			return tree.get_nodes_in_group("emenies");
		Target.EVERYONE:
			return tree.get_nodes_in_group("player") + tree.get_nodes_in_group("emenies");
		_:
			return [];

func play(targets: Array[Node], char_stats: CharacterStats):
	Events.card_played.emit(self);
	
	char_stats.mana -= cost;
	
	if is_single_targeted():
		apply_effect(targets);
	else:
		apply_effect(_get_targets(targets));

#虚函数
func apply_effect(_targets: Array[Node]):
	pass ;
