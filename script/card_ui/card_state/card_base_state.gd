extends CardState


# 状态 进入时
func enter():
	# 确认 CardUI 加载完成
	if not card_ui.is_node_ready():
		await  card_ui.ready;
	
	# 发送 复原状态 请求信号 / 重置 CardUI 参数
	card_ui.reparent_requested.emit(card_ui);
	card_ui.color.color = Color(0.0, 0.5, 0.5); 
	card_ui.state.text = "BASE";
	card_ui.pivot_offset = Vector2.ZERO;

# 状态 GUI 输入时
func on_gui_input(event: InputEvent):
	if event.is_action_pressed("left_mouse"):
		card_ui.pivot_offset = card_ui.get_global_mouse_position() - card_ui.global_position;
		transition_requested.emit(self, CardState.State.CLICKED);

