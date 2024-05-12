extends CardState

const  DROP_MINIMUM_THRES_HOLD := 0.05;
var minimum_drop_time_elapsed : bool;

# 状态进入
func enter():
	var ui_layer := get_tree().get_first_node_in_group("ui_layer");
	if ui_layer:
		card_ui.reparent(ui_layer);
	
	card_ui.color.color = Color(0.7, 0.0, 0.6); 
	card_ui.state.text = "DRAGGING";
	
	minimum_drop_time_elapsed = false;
	var thers_hold_time := get_tree().create_timer(DROP_MINIMUM_THRES_HOLD,false);
	thers_hold_time.timeout.connect(func(): minimum_drop_time_elapsed = true);

# 状态 输入时
func on_input(event: InputEvent):
	var mouse_motion := event is InputEventMouseMotion;
	var cancel := event.is_action_pressed("right_mouse");
	var released := event.is_action_pressed("left_mouse") or event.is_action_released("left_mouse");
	
	# 更新 卡片 位置
	if mouse_motion:
		card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.pivot_offset;
	
	if cancel:
		transition_requested.emit(self, CardState.State.BASE);
	elif released and minimum_drop_time_elapsed:
		get_viewport().set_input_as_handled();
		transition_requested.emit(self, CardState.State.RELEASED);
		
