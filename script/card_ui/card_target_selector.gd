extends Node2D;

const ARC_POINTS := 9;

@onready var area_2d = $Area2D;
@onready var card_arc = $CanvasLayer/CardArc;

var current_card_ui : CardUI;
var targeting := false;

func _ready():
	Events.card_aim_started.connect(_on_card_aim_started);
	Events.card_aim_ended.connect(_on_card_aim_ended);

func _process(_delta):
	# 如果不在 Selector 状态, 则直接退出
	if not targeting:
		return;
	
	# 更新 Area2D 位置
	# 绘制 Line2D 所需节点
	area_2d.position = get_local_mouse_position();
	card_arc.points = _get_points();

# 获取 Lin2D 所有点的位置
func _get_points() -> Array:
	var points := [];
	var start_point := current_card_ui.global_position;
	start_point.x += (current_card_ui.size.x / 2);
	var end_point := get_local_mouse_position();
	var distance := (end_point - start_point);
	
	for i in ARC_POINTS:
		var t := (1.0 / ARC_POINTS) * i;
		var x := start_point.x + (distance.x / ARC_POINTS) * i;
		var y := start_point.y + ease_out_cubic(t) * distance.y;
		
		points.append(Vector2(x, y));
	
	points.append(end_point);
	
	return points;

# 缓动函数
func ease_out_cubic(number: float) -> float:
	return 1.0 - pow(1.0 - number, 3.0);

func _on_card_aim_started(card_ui: CardUI):
	if not card_ui.card.is_single_targeted():
		return
	
	targeting = true;
	current_card_ui = card_ui;
	area_2d.monitoring = true;
	area_2d.monitorable = true;

func _on_card_aim_ended(_card_ui: CardUI):
	targeting = false;
	current_card_ui = null;
	area_2d.monitoring = false;
	area_2d.monitorable = false;
	area_2d.position = Vector2.ZERO;
	card_arc.clear_points();

func _on_area_2d_area_entered(area: Area2D):
	if not current_card_ui or not targeting:
		return
	
	if not current_card_ui.targets.has(area):
		current_card_ui.targets.append(area);

func _on_area_2d_area_exited(area: Area2D):
	if not current_card_ui or not targeting:
		return
	
	current_card_ui.targets.erase(area);

