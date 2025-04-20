extends Node

func _process(delta: float) -> void:
	#$".".scale = Vector2(get_last_exclusive_window().size) / Vector2(640,360)
	get_last_exclusive_window().size = DisplayServer.screen_get_size();
	$bluesky.position += Vector2(-50,0);
	
