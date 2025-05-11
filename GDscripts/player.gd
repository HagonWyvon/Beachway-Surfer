extends Node2D

var jumpable = false
var holding = false
@export var highjumpheight = 350
@export var lowjumpheight = 200

func start(pos):
	jumpable = true
	position = pos
	show()

func _ready():
	$BoosterFever.hide()
	$Jump.hide()

func _process(delta):
	if jumpable && !Input.is_action_pressed("jump") && $Mask/Shark.rotation_degrees == 0:
		$WaterSpread.show()


	if Input.is_action_just_pressed("jump") && jumpable:
		holding = true
		$WaterSpread.hide()
		
		$Jump.offset.y = 0
		$Jump.animation = "start_up1"
		$Jump.show()
		$Jump.play()

		$Mask/Shark.dive(10)

		$Timer/JumpTimer.start()

	if Input.is_action_just_released("jump") && holding:
		$Jump.offset.y = -36
		jumpable = false
		$WaterSpread.hide()
		
		if !$Timer/JumpTimer.is_stopped():
			$Jump.animation = "lowjump"
			var addedjump = 50 *  (1 - $Timer/JumpTimer.time_left)
			$Mask/Shark.jump(-lowjumpheight - addedjump,"low")
			$Timer/JumpTimer.stop()
		else:
			$Jump.animation = "highjump"
			$Mask/Shark.jump(-highjumpheight,"high")
			
		$Jump.play()
		holding = false

func _on_jump_timer_timeout() -> void:
	$Jump.animation = "start_up2"
	$Jump.play()
	$JumpReadySfx.play()


func _on_shark_water() -> void:
	jumpable = true
