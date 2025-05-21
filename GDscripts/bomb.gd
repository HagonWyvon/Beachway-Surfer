extends Area2D

signal boom

var exploding = false
var velocity = Vector2.ZERO

var seaface

@export var grav = 300		# Increased for faster fall
@export var flight_time = 1.5	# Reduced for quicker bombs

func _ready():
	seaface = position.y
	$BombAnim.play("live")
	add_to_group("bomb")

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func explode():
	if !exploding:
		print("Ambatoblow")
		$Boom.play()
		$BombAnim.animation = "boom"
		$BombAnim.play()
		exploding = true
		velocity = Vector2.ZERO	# Stop movement during explosion
		await $BombAnim.animation_finished
		queue_free()

func launch_to_player(player_pos: Vector2, arc_height: float = 50.0, spread: float = 80.0):
	var start_pos = global_position
	var target_pos = player_pos + Vector2(randf_range(-spread, spread), 0)
	var distance = target_pos - start_pos
	var duration = flight_time
	# Calculate initial velocity for parabolic arc
	var velocity_x = distance.x / duration
	# Aim for player_pos with slight upward arc
	var velocity_y = (distance.y - 0.5 * grav * duration * duration) / duration - arc_height
	velocity = Vector2(velocity_x, velocity_y)
	print("Bomb launched: start=", start_pos, " target=", target_pos, " velocity=", velocity)

func _physics_process(delta: float):
	if !exploding:
		velocity.y += grav * delta
		position += velocity*delta
	if position.y > seaface:
		explode()

func _on_body_entered(body: Node2D) -> void:
	print("Hit")
	if body.is_in_group("player") and !exploding:
		explode()
		print("Bomb hit player")
