extends Node



func _process(delta: float) -> void:
	get_last_exclusive_window().size = DisplayServer.screen_get_size();

func changeBackgroundByScore(Score):
	pass
