extends CardState

const MOUSE_Y_SNAPBACK_THERSHOLD := 138;

# 状态 进入时
func enter():
	# 修改 CardUI 参数
	card_ui.color.color = Color.WEB_PURPLE; 
	card_ui.state.text = "AIMING";
	card_ui.targets.clear();
	
	# 计算 Card 偏移量
	var offset := Vector2(card_ui.parent.size.x / 2, -card_ui.size.y / 2);
	offset.x -= card_ui.size.x / 2;
	
	# Card 位置移动至手牌中心
	card_ui.animate_to_position(card_ui.parent.global_position + offset, 0.5);
	
	# 关闭 Card 下落点检测器
	card_ui.drop_point_detector.monitoring = false;
	 
	# 通知 Events 事件总线出发 Selector
	Events.card_aim_started.emit(card_ui);

func exit():
	# 通知 Events 事件总线出发 Selector
	Events.card_aim_ended.emit(card_ui);

func on_input(event: InputEvent):
	var mouse_motion := event is InputEventMouseMotion;
	var mouse_at_bottom := card_ui.get_global_mouse_position().y > MOUSE_Y_SNAPBACK_THERSHOLD;
	
	# 如果 鼠标移动并且超出屏幕边界 或者 触发鼠标右键, 则 状态 转换为 BASE
	if (mouse_motion and mouse_at_bottom) or event.is_action_pressed("right_mouse"):
		transition_requested.emit(self, CardState.State.BASE);
	# 如果 触发鼠标左键 或者 松开鼠标左键, 则 状态 转换为 RELEASED
	elif event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse"):
		get_viewport().set_input_as_handled();
		transition_requested.emit(self, CardState.State.RELEASED);
		
