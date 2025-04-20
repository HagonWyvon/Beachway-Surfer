extends Area2D

signal hit

func start(pos):
	position = pos
	show()
	$Hitbox.disabled = false

func _ready():
	pass

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("jump"):
		pass
