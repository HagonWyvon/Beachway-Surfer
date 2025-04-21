extends Node

@export var BirdScene: PackedScene



var score

func _ready():
	pass
	#newGame()

func _process(delta: float) -> void:
	#get_last_exclusive_window().size = DisplayServer.screen_get_size();
	pass
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
	var velocity = Vector2(-randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity
	add_child(mob)

func _on_score_timer_timeout() -> void:
	score+=1

func _on_start_timer_timeout() -> void:
	$Timer/MobSpawnTimer.start()
	$Timer/ScoreTimer.start()


func _on_menu_newgame_sigal() -> void:
	newGame()
	#print("okkk")
