extends Area2D

var velocity = Vector2.ZERO
var deacceleration = 300.0
var is_jumping = false

func jump(jump_height):
	if !is_jumping:
		velocity.y = jump_height
		is_jumping = true

func _process(delta: float) -> void:
	if is_jumping:
		velocity.y += deacceleration * delta
		
		if velocity.y >= 0:
			velocity.y = 0
			is_jumping = false
	
	position += velocity * delta
