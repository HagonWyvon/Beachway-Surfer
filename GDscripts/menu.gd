extends Control
#@export var StartgameMenu: NodePath
#@export var ShopMenu: NodePath
#@export var SettingMenu: NodePath
#@export var QuitMenu: NodePath
signal NewgameSigal 
signal ShopSingal
signal SettingSignal
signal QuitgameSignal

func _ready() -> void:
	pass
func _process(delta: float) -> void:
	pass
func _on_startgame_pressed() -> void:
	NewgameSigal.emit()


func _on_shop_pressed() -> void:
	ShopSingal.emit()

func _on_setting_pressed() -> void:
	SettingSignal.emit()

func _on_quit_pressed() -> void:
	QuitgameSignal.emit()
