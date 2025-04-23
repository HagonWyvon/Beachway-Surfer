extends Node

@export var BirdScene: PackedScene
@export var score = 0

func _ready():
	pass
	#newGame()

func _on_shark_biten():
	print("Signal Main Received")
	score += 10


func _process(delta: float) -> void:
	#get_last_exclusive_window().size = DisplayServer.screen_get_size();
	print(score)


func newGame():
	score = 0;
	$Player.start($PlayerSpawn.position)
	$Timer/StartTimer.start()
	
func gameOver():
	$Timer/ScoreTimer.stop()
	$Timer/MobSpawnTimer.stop()


func _on_mob_spawn_timer_timeout() -> void:
	var mob = BirdScene.instantiate()
	var mobSpawnLocation = $BirdSpawn/BirdLocation
	mobSpawnLocation.progress_ratio = randf()
	mob.position = mobSpawnLocation.position

	mob.connect("biten", Callable(self, "_on_shark_biten"))
	
	add_child(mob)


func _on_score_timer_timeout() -> void:
	score+=1

func _on_start_timer_timeout() -> void:
	$Timer/MobSpawnTimer.start()
	$Timer/ScoreTimer.start()


func _on_menu_newgame_sigal() -> void:
	newGame()
	$Menu.hide()


func _on_menu_quitgame_signal() -> void:
	get_tree().quit()

func _on_menu_setting_signal() -> void:
	pass
	
func _on_menu_shop_singal() -> void:
	pass
