extends HSlider

@export var Bus_name: String
@onready var h_slider: HSlider = $"."

var Bus_index: int

func _ready() -> void:
	h_slider.custom_minimum_size.y = 28
	Bus_index = AudioServer.get_bus_index(Bus_name)
	print(Bus_index)
	value_changed.connect(_on_value_changed)
	
	value = db_to_linear(
		AudioServer.get_bus_volume_db(Bus_index)
	)
	h_slider.value = 10 #property need to store
	
func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		Bus_index,
		linear_to_db(value)
	)
