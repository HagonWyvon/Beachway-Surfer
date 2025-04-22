extends Node2D

var jumpable = false
var holding = false
@export var highjumpheight = 375
@export var lowjumpheight = 250

func start(pos):
	jumpable = true
	position = pos
	show()

func _ready():
	$BoosterFever.hide()
	$Jump.hide()

func _process(delta):
	if Input.is_action_just_pressed("jump") && jumpable:
		holding = true
		
		$Jump.offset.y = 0
		$Jump.animation = "start_up1"
		$Jump.show()
		$Jump.play()
		
		$Mask/Shark.dive(10)
		
		$Timer/JumpTimer.start()
	
	if Input.is_action_just_released("jump") && holding:
		$Jump.offset.y = -36
		jumpable = false
		
		if !$Timer/JumpTimer.is_stopped():
			$Jump.animation = "lowjump"
			$Mask/Shark.jump(-lowjumpheight,"low")
			$Timer/JumpTimer.stop()
		else:
			$Jump.animation = "highjump"
			$Mask/Shark.jump(-highjumpheight,"high")
			
		$Jump.play()
		holding = false

func _on_jump_timer_timeout() -> void:
	$Jump.animation = "start_up2"
	$Jump.play()
	$JumpReady.play()


func _on_shark_water() -> void:
	jumpable = true
