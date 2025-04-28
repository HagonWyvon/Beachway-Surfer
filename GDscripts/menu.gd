extends Control
signal NewgameSigal 
#signal ShopSingal
#signal SettingSignal
#signal QuitgameSignal
@onready var animationPlayer = $AnimationPlayer
@onready var SHOP = $SHOP
@onready var res_opt_btn: OptionButton = $SETTING/VBoxContainer/HBoxContainer/properties/res_opt_btn
var resolutions = {
	"3840x2160": Vector2i(3840,2160),
	"2560x1440": Vector2i(2560,1440),
	"1920x1080": Vector2i(1920,1080),
	"1600x900": Vector2i(1600,900),
	"1440x900": Vector2i(1440,900),
	"1366x768": Vector2i(1366,768),
	"1280x720": Vector2i(1280,720),
	"1024x600": Vector2i(1024,600),
	"800x600": Vector2i(800,600),
	"620x360": Vector2i(620,360)
}
var menuStat = true

func _ready() -> void:
	add_resolution()
	update_resoluion()
	
func add_resolution():
	for res in resolutions:
		res_opt_btn.add_item(res)
	
func update_resoluion():
	var get_window_size = str(get_window().size.x,"x",get_window().size.y)
	var resolution_index = resolutions.keys().find(get_window_size)
	res_opt_btn.selected = resolution_index


func center_window():
	var screen_center = DisplayServer.screen_get_position() + DisplayServer.screen_get_size()/2
	var window_size = get_window().get_size_with_decorations()
	get_window().set_position(screen_center - window_size/2)	

func _on_res_opt_btn_item_selected(index: int) -> void:
	var key = res_opt_btn.get_item_text(index)
	get_window().set_size(resolutions[key])
	center_window()









func show_and_hide(first: String,second: String):
	animationPlayer.play("hide_"+second)
	await animationPlayer.animation_finished
	animationPlayer.play("show_"+first)
	if first== "menu":
		menuStat = true
	if second == "menu":
		menuStat = null
	
func menuOn(menu):
	if menu:
		animationPlayer.play("hide_menu")
		menuStat = false
	else:
		animationPlayer.play("show_menu")
		menuStat = true
#
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if menuStat == true or menuStat == false:
			menuOn(menuStat)
		elif menuStat == null:
			if SHOP.visible == true:
				show_and_hide("menu","shop")
			else:
				show_and_hide("menu","setting")
			
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
