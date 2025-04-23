extends Control
signal NewgameSigal 
#signal ShopSingal
#signal SettingSignal
#signal QuitgameSignal
@onready var animationPlayer = $AnimationPlayer
var menuStat:bool = true

func show_and_hide(first: String,second: String):
	animationPlayer.play("hide_"+second)
	await animationPlayer.animation_finished
	animationPlayer.play("show_"+first)

func menuOn(menu):
	if menu:
		animationPlayer.play("hide_menu")
		menuStat = false
	else:
		animationPlayer.play("show_menu")
		menuStat = true
#
func _ready() -> void:
	pass
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		menuOn(menuStat)
	
#
func _on_playgame_pressed() -> void:
	NewgameSigal.emit()
	animationPlayer.play("hide_menu")
	menuStat = false
func _on_shop_pressed() -> void:
	show_and_hide("shop","menu")
func _on_setting_pressed() -> void:
	show_and_hide("setting","menu")

#backbtn
func _on_setting_back_btn_pressed() -> void:
	show_and_hide("menu","setting")
func _on_shop_back_btn_pressed() -> void:
	show_and_hide("menu","shop")

func _on_quit_pressed() -> void:
	get_tree().quit()
