extends CardState

var played: bool;


# 状态 进入时
func enter():
	# 修改 CardUI 参数 
	card_ui.color.color = Color.PURPLE; 
	card_ui.state.text = "RELEASED";
	
	played = false;
	
	# 确认 CardUI 是否进入 CardDropArea
	if not card_ui.targets.is_empty():
		played = true;

# 状态 输入时
func on_input(_event: InputEvent):
	# 如果 CardUI 不在 CardDropArea 中, 则状态转换为 BASE.
	if played:
		return;
	else:
		transition_requested.emit(self, CardState.State.BASE);
