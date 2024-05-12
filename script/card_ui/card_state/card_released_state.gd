extends CardState

var played: bool;

# 状态进入
func enter():
	card_ui.color.color = Color.PURPLE; 
	card_ui.state.text = "RELEASED";
	
	played = false;
	
	if not card_ui.targets.is_empty():
		played = true;
		print("play card for (s)",card_ui.targets);

func on_input(_event: InputEvent):
	if played:
		return;
	else:
		transition_requested.emit(self, CardState.State.BASE);
