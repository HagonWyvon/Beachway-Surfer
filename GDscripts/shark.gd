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

func new():
	height = -1
	position.y = height-20
	airborne = true

func dead():
	velocity.y = -250
	deacceleration = 250
	notdead = false
	airborne = true
	height = 20
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
	if position.y >= height && velocity.y > 0:
		airborne = false
		rotation_degrees = 0
		water.emit()


func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("bomb"):
		oof.emit()
