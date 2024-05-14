class_name StatsUI;
extends HBoxContainer;

@onready var block = $Block;
@onready var block_label = %BlockLabel;

@onready var health = $Health;
@onready var health_label = %HealthLabel;

func update_stats(stats: Stats):
	block_label.text = str(stats.block);
	health_label.text = str(stats.health);
	
	block.visible = stats.block > 0;
	health.visible = stats.health > 0;
