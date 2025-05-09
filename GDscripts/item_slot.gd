extends PanelContainer

@onready var ItemName: PanelContainer = $"."
@onready var img_container: TextureRect = $SHOP/VBoxContainer/Container/InfoContainer/HBoxContainer/IMGContainer

var SignalBus = Database.ItemClick
func _on_button_pressed() -> void:
	SignalBus.emit(ItemName)

			
		
