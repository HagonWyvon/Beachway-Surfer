extends Node

var coins: int = 0
var total_coins = 0

func save():
	var save_data = {
		"total_coins": total_coins
	}
	var file = FileAccess.open("user://save.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data))
	file.close()

func load():
	if FileAccess.file_exists("user://save.json"):
		var file = FileAccess.open("user://save.json", FileAccess.READ)
		var data = JSON.parse_string(file.get_as_text())
		total_coins = data.get("total_coins", 0)
		file.close()
