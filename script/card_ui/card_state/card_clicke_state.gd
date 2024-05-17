extends CardState

# 状态 进入时
func enter():
	# 修改 CardUI 参数
	card_ui.drop_point_detector.monitoring = true;
	card_ui.original_index = card_ui.get_index();

# 状态 输入时
func on_input(event: InputEvent):
	if event is InputEventMouseMotion:
		transition_requested.emit(self, CardState.State.DRAGGING);
