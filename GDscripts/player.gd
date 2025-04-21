extends Area2D

signal hit

func start(pos):
	position = pos
	show()
	$Hitbox.disabled = false

func _ready():
	$BoosterFever.hide()
	$Spike.hide()

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("jump") && $JumpCD.is_stopped():
		$JumpCD.start()
		$Spike.offset.y += 36
		$Spike.animation = "spike_start_up"
		$Spike.show()
		$Spike.play()
		$JumpTimer.start()


func _on_jump_timer_timeout() -> void:
	$Spike.animation = "spike"
	$Spike.offset.y -= 36
	$Spike.play()
