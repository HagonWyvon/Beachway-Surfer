extends Control
@onready var barsAnimation = $barsAnimation

func _on_menu_newgame_sigal() -> void:
	$".".show()
	barsAnimation.play("show_bar")
	#await barsAnimation.animation_finished
