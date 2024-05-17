extends Node;

func shake(thing: Node2D, strength: float, duration: float = 0.2):
	if not thing:
		return ;
	
	var orig_position := thing.position;
	var shake_count := 10;
	
	var tween = create_tween();
	
	for i in shake_count:
		var shake_offset := Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0));
		var target_position := orig_position + strength * shake_offset
		
		#if i % 2 == 0:
			#target_position = orig_position;
		
		tween.tween_property(thing, "position", target_position, duration / float(shake_count)); 
		
		strength *= 0.75;
	
	tween.finished.connect(
		func(): thing.position = orig_position;
	);
