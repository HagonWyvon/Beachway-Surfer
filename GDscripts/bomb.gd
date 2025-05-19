extends CharacterBody2D

signal boom

var exploding = false

@export var grav = 250
@export var flight_time = 3 # in secs

func _ready():
	$BombAnim.play("live")


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func explode():
	$BombAnim.play("boom")
	exploding = true

func launch_to_player(player_pos: Vector2, arc_height: float = 100.0, spread: float = 40.0):
	var start_pos = global_position
	var target_pos = player_pos + Vector2(randf_range(-spread, spread), 0)

	var distance = target_pos - start_pos
	var duration = flight_time

	# Calculate initial velocity using kinematic equations
	var velocity_x = distance.x / duration
	var velocity_y = (distance.y - 0.5 * grav * duration * duration) / duration
	
	velocity = Vector2(velocity_x, velocity_y)


func _process(delta: float):
	if !exploding:
		velocity.y += grav * delta
		position += velocity * delta
	if $BombAnim.animation_finished && $BombAnim.animation == "boom":
		queue_free()
