extends Area2D

signal bitten

@export var lowspeed = 200
@export var highspeed = 325

var birdspeed = randf_range(lowspeed, highspeed)

func _ready():
	var bird_types = Array($birdskin.sprite_frames.get_animation_names())
	$birdskin.animation = bird_types.pick_random()
	$birdskin.play()

func _process(delta: float) -> void:
	position.x -= birdspeed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func speedincrease(scale_speed):
	lowspeed *= scale_speed
	highspeed *= scale_speed

func _on_body_entered(body: Node2D):
	emit_signal("bitten")
	hide()
	set_process(false)
	set_deferred("monitoring", false)
