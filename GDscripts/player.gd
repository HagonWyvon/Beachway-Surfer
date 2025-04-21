extends Area2D

signal hit

var jumpready = false

func start(pos):
	position = pos
	show()
	$Hitbox.disabled = false

func _ready():
	$Anim/BoosterFever.hide()
	$Anim/Jump.hide()

func _process(delta):
	if Input.is_action_just_pressed("jump") && $Timer/JumpCD.is_stopped():
		$Anim/Jump.offset.y = 0
		$Anim/Jump.animation = "start_up"
		$Anim/Jump.show()
		$Anim/Jump.play()
		
		$Timer/JumpTimer.start()
	
	if Input.is_action_just_released("jump") && !$Timer/JumpTimer.is_stopped():
		#Jump Low
		$Anim/Jump.offset.y = -36
		$Anim/Jump.animation = "lowjump"
		$Anim/Jump.play()
		
		$Timer/JumpCD.wait_time = 0.5
		$Timer/JumpCD.start()
		
		
	if Input.is_action_just_released("jump") && $Timer/JumpTimer.is_stopped():
		#Jump High
		$Anim/Jump.offset.y = -36
		$Anim/Jump.animation = "highjump"
		$Anim/Jump.play()
		
		$Timer/JumpCD.wait_time = 2.5
		$Timer/JumpCD.start()
