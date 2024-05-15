extends CardState

# 状态 进入时
func enter():
	# 确认 CardUI 加载完成
	if not card_ui.is_node_ready():
		await  card_ui.ready;
	
	# 检查 tween 是否存在或运行. 是, 则关闭 tween
	if card_ui.tween and card_ui.tween.is_running():
		card_ui.tween.kill();
	
	# 发送 复原状态 请求信号 / 重置 CardUI 参数
	card_ui.reparent_requested.emit(card_ui);
	card_ui.panel.set("theme_override_styles/panel", card_ui.BASE_STYLEBOX);
	card_ui.pivot_offset = Vector2.ZERO;

# 状态 GUI 输入时
func on_gui_input(event: InputEvent):
	# 如果 Card 禁用， 则跳过交互
	if not card_ui.playable or card_ui.disable:
		return;
	
	if event.is_action_pressed("left_mouse"):
		card_ui.pivot_offset = card_ui.get_global_mouse_position() - card_ui.global_position;
		transition_requested.emit(self, CardState.State.CLICKED);

func on_muse_entered():
	# 如果 Card 禁用， 则跳过交互
	if not card_ui.playable or card_ui.disable:
		return;
	
	card_ui.panel.set("theme_override_styles/panel", card_ui.HOVER_STYLEBOX);
	
func on_muse_exited():
	# 如果 Card 禁用， 则跳过交互
	if not card_ui.playable or card_ui.disable:
		return;
	
	card_ui.panel.set("theme_override_styles/panel", card_ui.BASE_STYLEBOX);
