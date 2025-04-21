extends Area2D

var velocity = Vector2.ZERO
var airborne = false

@export var jumprotation = 25
@export var deacceleration = 215.0
@export var height = -1

func jump(jump_height):
	velocity.y = jump_height
	airborne = true
	height = -1

func dive(depth):
	height = depth

func _process(delta: float) -> void:
	if velocity.y > 0 && airborne:
		rotation_degrees = jumprotation
	if velocity.y < 0 && airborne:
		rotation_degrees = -jumprotation
	if airborne:
		velocity.y += deacceleration * delta
		position += velocity * delta
	if position.y >= height:
		airborne = false
		rotation_degrees = 0
