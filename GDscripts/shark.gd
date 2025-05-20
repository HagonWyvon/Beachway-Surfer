extends CharacterBody2D

signal water

var airborne = false
var notdead = true

@export var jumprotation = 25
@export var deacceleration = 215.0
@export var height = -1

func dead():
	velocity.y = -250
	deacceleration = 250
	notdead = false
	airborne = true
	height = 500
	rotation_degrees = 0
	$SharkAnim.flip_v = true
	$SharkAnim.play("dead")

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
	if velocity.y > 0 && airborne && notdead:
		rotation_degrees = jumprotation
	if velocity.y < 0 && airborne && notdead:
		rotation_degrees = -jumprotation
	if airborne:
		velocity.y += deacceleration * delta
		position += velocity * delta
	if position.y >= height && velocity.y > 0 && notdead:
		airborne = false
		rotation_degrees = 0
		water.emit()
