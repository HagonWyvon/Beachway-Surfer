extends CharacterBody2D

var bomb1LowerCap = 4
var bomb2LowerCap = 3
var bomb3LowerCap = 2


func _ready():
	boatWater()



func boatWater():
	match $BoatSprite.animation:
		"boat1":
			$Water.offset.x = 12
			$Water.offset.y = 12
		"boat2":
			$Water.offset.x = 16
			$Water.offset.y = 16
		"boat3":
			$Water.offset.x = 9
			$Water.offset.y = 9


func _on_bomb_launcher_timer_timeout() -> void:
	pass # Replace with function body.
