extends CardState


# 状态 进入时
func enter():
	# 修改 CardUI 参数
	card_ui.color.color = Color(0.3, 0.3, 1); 
	card_ui.state.text = "CLICKED";
	card_ui.drop_point_detector.monitoring = true;

# 状态 输入时
func on_input(event: InputEvent):
	if event is InputEventMouseMotion:
		transition_requested.emit(self, CardState.State.DRAGGING);
