class_name PlayerHandler;
extends Node;

const HAND_DARW_INTERVAL := 0.25;
const HAND_DISCARD_INTERVAL := 0.25;

@export var hand := Hand.new();

var char_stats: CharacterStats;

func _ready():
	Events.card_played.connect(_on_card_played);

func start_battle(charactor_stats: CharacterStats):
	self.char_stats = charactor_stats;
	
	self.char_stats.discard = CardPile.new();
	self.char_stats.draw_pile = charactor_stats.deck.duplicate(true);
	self.char_stats.draw_pile.shuffle();
	start_turn();

func start_turn():
	char_stats.block = 0;
	char_stats.reset_mana();
	draw_cards(char_stats.cards_per_turn);

func ended_turn():
	hand.disable_hand();
	discard_cards();

func draw_card():
	reshuffle_deck_from_discard();
	hand.add_card(char_stats.draw_pile.draw_card());
	reshuffle_deck_from_discard();

func draw_cards(amount: int):
	var tween := create_tween();
	
	for idex in range(amount):
		tween.tween_callback(draw_card);
		tween.tween_interval(HAND_DARW_INTERVAL);
	
	tween.finished.connect(
		func (): Events.player_hand_darwn.emit();
	);
	
func discard_cards():
	var tween := create_tween();
	
	for card_ui in hand.get_children():
		tween.tween_callback(char_stats.discard.add_card.bind(card_ui.card));
		tween.tween_callback(hand.discard_card.bind(card_ui));
		tween.tween_interval(HAND_DARW_INTERVAL);
	
	tween.finished.connect(
		func (): Events.player_hand_discarded.emit();
	); 

func reshuffle_deck_from_discard():
	if not char_stats.draw_pile.empty():
		return;
	
	while not char_stats.discard.empty():
		char_stats.draw_pile.add_card(char_stats.discard.draw_card());
	
	char_stats.draw_pile.shuffle();

func _on_card_played(card: Card):
	char_stats.discard.add_card(card);
