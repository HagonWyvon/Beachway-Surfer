extends CanvasLayer
@onready var transition_screen: CanvasLayer = $"."
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	transition_screen.visible = false

func PlayBGTrans():
	animation_player.play("fade_to_black_and_back")
	
