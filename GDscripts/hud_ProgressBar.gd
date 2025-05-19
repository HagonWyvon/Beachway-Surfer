extends Control
@onready var barsAnimation = $barsAnimation
var SignalHungerrecive = Database.HungerPt
func _on_menu_newgame_sigal() -> void:
	$".".show()
	barsAnimation.play("show_bar")
	#await barsAnimation.animation_finished

func _ready() -> void:
	SignalHungerrecive.connect(update_Bar)

func update_Bar(hungerpt):
	$HungerBar.value = hungerpt
