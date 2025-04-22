extends Control
#@export var StartgameMenu: NodePath
#@export var ShopMenu: NodePath
#@export var SettingMenu: NodePath
#@export var QuitMenu: NodePath
signal NewgameSigal 
signal ShopSingal
signal SettingSignal
signal QuitgameSignal

@onready var menuClicked = $ClickSFX

func _ready() -> void:
	pass
func _process(delta: float) -> void:
	pass
func _on_startgame_pressed() -> void:
	NewgameSigal.emit()
	menuClicked.play()

func _on_shop_pressed() -> void:
	ShopSingal.emit()
	menuClicked.play()

func _on_setting_pressed() -> void:
	SettingSignal.emit()
	menuClicked.play()

func _on_quit_pressed() -> void:
	QuitgameSignal.emit()
	menuClicked.play()
