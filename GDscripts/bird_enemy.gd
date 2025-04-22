extends Area2D

signal biten

@export var lowspeed = 100
@export var highspeed = 350

func _ready():
	var bird_types = Array($birdskin.sprite_frames.get_animation_names())
	$birdskin.animation = bird_types.pick_random()

func _process(delta: float) -> void:
	position.x -= randf_range(lowspeed, highspeed) * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(_body: Node2D) -> void:
	emit_signal("biten")
	hide()
	set_process(false)
	monitoring = false
