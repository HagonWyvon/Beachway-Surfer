extends NinePatchRect
@onready var shop: NinePatchRect = $"."
@onready var item_container: GridContainer = $VBoxContainer/Container/ItemContainer
@onready var img_container: TextureRect = $VBoxContainer/Container/InfoContainer/HBoxContainer/IMGContainer


var ItemSlot = load("res://UI/itemSlot.tscn")
var ListItem = Database.ListItem
var SignalBusRecive = Database.ItemClick
var database = Database.ListItem

func _ready() -> void:
	LoadItem(ListItem)
	SignalBusRecive.connect(_on_item_click)
	#print(item_container.get_children()[2].name) got the fucking name haha
	
func LoadItem(_ListItem):
	for item in _ListItem:
		var child_node = ItemSlot.instantiate()
		child_node.name = item
		item_container.add_child(child_node)
		
func _on_item_click(this):
	#print("damn this is working")
	var choosenItem = this.name
	for key in database:
		if choosenItem == key:
			print(database.get(choosenItem).DecriptionIMG)
			img_container.texture = load(str(database.get(choosenItem).DecriptionIMG))
