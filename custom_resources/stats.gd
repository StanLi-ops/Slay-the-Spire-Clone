class_name Stats;
extends Resource;

signal stats_changed();

@export var max_health := 1;
@export var art: Texture;

var health: int : set = set_health;
var block: int : set = set_block;

func set_health(value: int) -> int:
	health = clampi(value, 0, max_health);
	
	stats_changed.emit();
	
	return health

func set_block(value: int) -> int:
	block = clampi(value, 0, 999);
	
	stats_changed.emit();
	
	return block

func take_damage(damage: int):
	if damage < 0:
		return;
	
	var initalt_damage := damage;
	damage = clampi(damage - block, 0 ,damage);
	print(damage);
	self.block = clampi(block - initalt_damage, 0, block);
	self.health -= damage;

func heal(amount: int):
	self.health += amount;

func create_instance() -> Resource:
	var instance :Stats = self.duplicate();
	instance.health = max_health;
	instance.block = 0;
	return instance;
