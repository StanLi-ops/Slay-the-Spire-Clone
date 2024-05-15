class_name CharacterStats;
extends Stats;

@export var strting_deck: CardPile;
@export var cards_per_turn: int;
@export var max_mana: int;

var mana: int: set = _set_mana;
var deck: CardPile;
var discard: CardPile;
var draw_pile: CardPile;

func _set_mana(value: int):
	mana = value;
	stats_changed.emit();

func reset_mana():
	self.mana = max_mana;
	
func cna_play_check(card: Card) -> bool:
	return mana >= card.cost;

func create_instance() -> Resource:
	var instance :Stats = self.duplicate();
	instance.health = max_health;
	instance.block = 0;
	instance.reset_mana();
	instance.deck = instance.strting_deck.duplicate();
	instance.discard = CardPile.new();
	instance.draw_pile = CardPile.new();
	return instance;
