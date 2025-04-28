extends Button
#@export var Text:String
#@onready var label: Label = $Label

func _on_pressed() -> void:
	$AudioStreamPlayer2D.play()
#func _ready() -> void:
	#label.text = Text
