extends Area2D

signal boom


func _ready():
	$BombAnim.play("live")


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func explode():
	$BombAnim.play("boom")
	
