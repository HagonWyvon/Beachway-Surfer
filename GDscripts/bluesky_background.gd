extends Node
@export var backgroundNum: int = 1

func _process(_delta: float) -> void:
	pass
	#get_last_exclusive_window().size = DisplayServer.screen_get_size();
func changeBackground(WhichCloud): #Score/Time
	match WhichCloud:
		#pass
		1:
			$blueskyBackground/bluesky/Sprite2D.texture =load("res://assets/Background/Clouds/Clouds 1/1.png")
			$blueskyBackground/backcloud/Sprite2D.texture =load("res://assets/Background/Clouds/Clouds 1/2.png")
			$blueskyBackground/cloud/Sprite2D.texture =load("res://assets/Background/Clouds/Clouds 1/4.png")
			$blueskyBackground/cloud/Sprite2D2.texture = null
		2:
			$blueskyBackground/bluesky/Sprite2D.texture = load("res://assets/Background/Clouds/Clouds 2/1.png")
			$blueskyBackground/backcloud/Sprite2D.texture = load("res://assets/Background/Clouds/Clouds 2/3.png")
			$blueskyBackground/cloud/Sprite2D.texture = load("res://assets/Background/Clouds/Clouds 2/4.png")
			$blueskyBackground/cloud/Sprite2D2.texture = null
		3:
			$blueskyBackground/bluesky/Sprite2D.texture =load("res://assets/Background/Clouds/Clouds 3/1.png")
			$blueskyBackground/backcloud/Sprite2D.texture =load("res://assets/Background/Clouds/Clouds 3/3.png")
			$blueskyBackground/cloud/Sprite2D.texture =load("res://assets/Background/Clouds/Clouds 3/4.png")
			$blueskyBackground/cloud/Sprite2D2.texture = null
		4:
			$blueskyBackground/bluesky/Sprite2D.texture =load("res://assets/Background/Clouds/Clouds 4/1.png")
			$blueskyBackground/backcloud/Sprite2D.texture =load("res://assets/Background/Clouds/Clouds 4/3.png")
			$blueskyBackground/cloud/Sprite2D.texture =load("res://assets/Background/Clouds/Clouds 4/4.png")
			$blueskyBackground/cloud/Sprite2D2.texture = null
		5:
			$blueskyBackground/bluesky/Sprite2D.texture =load("res://assets/Background/Clouds/Clouds 5/1.png")
			$blueskyBackground/backcloud/Sprite2D.texture =load("res://assets/Background/Clouds/Clouds 5/4.png")
			$blueskyBackground/cloud/Sprite2D.texture =load("res://assets/Background/Clouds/Clouds 5/5.png")
			$blueskyBackground/cloud/Sprite2D2.texture = null
		6:
			$blueskyBackground/bluesky/Sprite2D.texture =load("res://assets/Background/Clouds/Clouds 6/1.png")
			$blueskyBackground/backcloud/Sprite2D.texture =load("res://assets/Background/Clouds/Clouds 6/3.png")
			$blueskyBackground/cloud/Sprite2D.texture =load("res://assets/Background/Clouds/Clouds 6/4.png")
			$blueskyBackground/cloud/Sprite2D2.texture =load("res://assets/Background/Clouds/Clouds 6/5.png")
		7:
			$blueskyBackground/bluesky/Sprite2D.texture =load("res://assets/Background/Clouds/Clouds 7/1.png")
			$blueskyBackground/backcloud/Sprite2D.texture =load("res://assets/Background/Clouds/Clouds 7/3.png")
			$blueskyBackground/cloud/Sprite2D.texture =load("res://assets/Background/Clouds/Clouds 7/4.png")
			$blueskyBackground/cloud/Sprite2D2.texture = null
		8:
			$blueskyBackground/bluesky/Sprite2D.texture =load("res://assets/Background/Clouds/Clouds 8/1.png")
			$blueskyBackground/backcloud/Sprite2D.texture =load("res://assets/Background/Clouds/Clouds 8/2.png")
			$blueskyBackground/cloud/Sprite2D.texture =load("res://assets/Background/Clouds/Clouds 8/3.png")
			$blueskyBackground/cloud/Sprite2D2.texture = load("res://assets/Background/Clouds/Clouds 8/4.png")


func _ready() -> void:
	$blueskyBackground/bluesky/Sprite2D.scale.y = 1.5
	print($blueskyBackground/bluesky/Sprite2D.scale.y)
	changeBackground(backgroundNum)
