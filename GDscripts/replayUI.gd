extends NinePatchRect



func _on_replay_pressed() -> void:
	Database.replay.emit()

func _on_back_to_menu_pressed() -> void:
	Database.backtomenuOndeath.emit()
