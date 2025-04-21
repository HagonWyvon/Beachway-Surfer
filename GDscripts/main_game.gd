extends Node

@export var BirdScene: PackedScene
var score

func _ready():
	newGame()

func _process(delta: float) -> void:
	#get_last_exclusive_window().size = DisplayServer.screen_get_size();
	pass
func newGame():
	score = 0;
	$Player.start($PlayerSpawn.position)
	$StartTimer.start()
	
func gameOver():
	$ScoreTimer.stop()
	$MobSpawnTimer.stop()


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
	$MobSpawnTimer.start()
	$ScoreTimer.start()
