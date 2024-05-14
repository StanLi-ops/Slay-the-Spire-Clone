class_name CardPile;
extends Resource;

signal card_pile_size_changed(cards_amount);

@export var cards :Array[Card] = [];

func empty() -> bool:
	return cards.is_empty();

func draw_card() -> Card:
	var card = cards.pop_front();
	card_pile_size_changed.emit(cards.size());
	return card;

func size() -> int:
	return cards.size();

func add_card(card: Card):
	cards.append(card);
	card_pile_size_changed.emit(cards.size());

func clear_card_pile():
	cards.clear();
	card_pile_size_changed.emit(cards.size());

func shuffle():
	cards.shuffle();

func _to_string() -> String:
	var _cards_string : PackedStringArray = [];
	for i in range(cards.size()):
		_cards_string.append("%s: %s" % [i+1, cards[i].id]);
	return "\n".join(_cards_string);
