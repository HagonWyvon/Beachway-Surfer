extends Control
#@export var StartgameMenu: NodePath
#@export var ShopMenu: NodePath
#@export var SettingMenu: NodePath
#@export var QuitMenu: NodePath
signal NewgameSigal 
func _ready() -> void:
	pass
func _process(delta: float) -> void:
	pass
func _on_startgame_pressed() -> void:
	NewgameSigal.emit()
