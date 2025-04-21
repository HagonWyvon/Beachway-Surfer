extends Area2D

var velocity = Vector2.ZERO

func jump():
	velocity.y -= 1

func _process(delta: float) -> void:
	position += velocity * delta
