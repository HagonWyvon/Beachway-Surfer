extends Node2D

var holding = false
@export var highjumpheight = 300
@export var lowjumpheight = 100

func start(pos):
	position = pos
	show()

func _ready():
	$BoosterFever.hide()
	$Jump.hide()

func _process(delta):
	if Input.is_action_just_pressed("jump") && $Timer/JumpCD.is_stopped():
		holding = true
		
		$Jump.offset.y = 0
		$Jump.animation = "start_up1"
		$Jump.show()
		$Jump.play()
		
		
		$Timer/JumpTimer.start()
	
	if Input.is_action_just_released("jump") && holding:
		$Jump.offset.y = -36
		if !$Timer/JumpTimer.is_stopped():
			$Jump.animation = "lowjump"
			$Mask/Shark.jump(-lowjumpheight)
			$Timer/JumpTimer.stop()
		else:
			$Jump.animation = "highjump"
			$Mask/Shark.jump(-highjumpheight)
		$Jump.play()
		
		holding = false
		
		$Timer/JumpCD.start()


func _on_jump_timer_timeout() -> void:
	$Jump.animation = "start_up2"
	$Jump.play()
