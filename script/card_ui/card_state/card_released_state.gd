extends CardState

var played: bool;

# 状态 进入时
func enter():
	played = false;
	
	# 确认 CardUI 是否进入 CardDropArea
	if not card_ui.targets.is_empty():
		played = true;
		card_ui.play();

# 状态 输入时
func on_input(_event: InputEvent):
	# 如果 CardUI 不在 CardDropArea 中, 则状态转换为 BASE.
	if played:
		return;
	else:
		transition_requested.emit(self, CardState.State.BASE);
