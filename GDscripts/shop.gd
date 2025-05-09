extends NinePatchRect
@onready var shop: NinePatchRect = $"."
@onready var item_container: GridContainer = $VBoxContainer/Container/ItemContainer

var ItemSlot = load("res://UI/itemSlot.tscn")

var ListItem = {
	"BG1":{
		"BackgroundNum": "1",
		"BlueSky": "res://assets/Background/Clouds/Clouds 1/1.png",
		"BackCloud": "res://assets/Background/Clouds/Clouds 1/2.png",
		"Cloud": "res://assets/Background/Clouds/Clouds 1/4.png",
		
		"Decription": ""
	},
	
	"BG2":{
		"BackgroundNum": "2",
		"BlueSky": "res://assets/Background/Clouds/Clouds 2/1.png",
		"BackCloud": "res://assets/Background/Clouds/Clouds 2/3.png",
		"Cloud": "res://assets/Background/Clouds/Clouds 2/4.png",
		
		"Decription": ""
	},

	"BG3":{
		"BackgroundNum": "3",
		"BlueSky": "res://assets/Background/Clouds/Clouds 3/1.png",
		"BackCloud": "res://assets/Background/Clouds/Clouds 3/3.png",
		"Cloud": "res://assets/Background/Clouds/Clouds 3/4.png",
		
		"Decription": ""
	},
}

func _ready() -> void:
	LoadItem(ListItem)
	#pass
	
func LoadItem(_ListItem):
	for item in _ListItem:
		var child_node = ItemSlot.instantiate()
		item_container.add_child(child_node)
	
	
		
