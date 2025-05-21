extends Control

signal BURST_MODE

@onready var barsAnimation = $barsAnimation
var SignalHungerrecive = Database.HungerPt
var Signalburstptreceive = Database.BurstPt

func _on_menu_newgame_sigal() -> void:
	$".".show()
	barsAnimation.play("show_bar")
	#await barsAnimation.animation_finished

func _ready() -> void:
	SignalHungerrecive.connect(update_Bar)
	Signalburstptreceive.connect(update_burst)
func update_Bar(hungerpt):
	$HungerBar.value = hungerpt

func update_burst(burstpt):
	$BosterBar.value += burstpt
	print('burstpt receive')
	
	if $BosterBar.value == 100:
		$BosterBar.value = 0
		BURST_MODE.emit()
