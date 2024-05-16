class_name Toolilp;
extends PanelContainer;

@export var fade_seconds := 0.2;

@onready var tooltip_icon = %TooltipIcon;
@onready var tooltip_text_lable = %TooltipText;

var tween: Tween;
var tooltip_is_visible: = false;

func _ready():
	Events.card_tooltip_requested.connect(show_tooltip);
	Events.tooltip_hide_requested.connect(hide_tooltip);
	
	modulate = Color.TRANSPARENT;	
	hide();

func show_tooltip(icon: Texture, text: String):
	if tween:
		tween.kill();
	
	tooltip_is_visible = true;
	
	tooltip_icon.texture = icon;
	tooltip_text_lable.text = text;
	
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC);
	tween.tween_callback(show);
	tween.tween_property(self, "modulate", Color.WHITE, fade_seconds);

func hide_tooltip():
	if tween:
		tween.kill();
	
	tooltip_is_visible = false;
	
	get_tree().create_timer(fade_seconds, false).timeout.connect(hide_animation);

func hide_animation():
	if not tooltip_is_visible:
		tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC);
		tween.tween_property(self, "modulate", Color.TRANSPARENT, fade_seconds);
		tween.tween_callback(hide);
