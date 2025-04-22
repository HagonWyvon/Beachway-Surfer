extends RigidBody2D


func _ready():
	var bird_types = Array($birdskin.sprite_frames.get_animation_names())
	$birdskin.animation = bird_types.pick_random()



func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
