extends CharacterBody2D

signal water
signal oof

var airborne = false
var notdead = true

@export var jumprotation = 25
@export var deacceleration = 215.0
@export var height = -1

func _ready() -> void:
	add_to_group("player")

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bomb"):
		oof.emit()

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
