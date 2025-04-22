extends RigidBody2D

signal water

var velocity = Vector2.ZERO
var airborne = false

@export var jumprotation = 25
@export var deacceleration = 215.0
@export var height = -1

func jump(jump_height, sfx):
	velocity.y = jump_height
	airborne = true
	height = -1
	match sfx:
		"high":
			$HighJumpsfx.play()
		"low":
			$LowJumpsfx.play()

func dive(depth):
	height = depth

func _process(delta: float) -> void:
	if position.y < height:
		airborne = true
	if velocity.y > 0 && airborne:
		rotation_degrees = jumprotation
	if velocity.y < 0 && airborne:
		rotation_degrees = -jumprotation
	if airborne:
		velocity.y += deacceleration * delta
		position += velocity * delta
	if position.y >= height && velocity.y > 0:
		airborne = false
		rotation_degrees = 0
		water.emit()
