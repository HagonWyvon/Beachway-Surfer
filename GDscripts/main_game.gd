extends Node

@export var birdfoodreward = 24

@export var BoatScene: PackedScene
@export var BirdScene: PackedScene
@export var base_speed: float = 1.0
@export var difficulty_curve: float = 0.15
@export var base_score_increment = 1
@export var base_bite_reward = 10

var score = 0
var current_scale: float = 1.0
var current_score_increment = 1
var current_bite_reward = 10
var game_time = 0
var current_level = 1
var time_for_next_level = 60
var max_level = 5
var level_loops = 0

var boatcap = 3

func _ready():
	pass
	#newGame()

func _on_bird_shark_bitten():
	score += current_bite_reward
	update_scaling()
	$Player.eat(birdfoodreward)

func update_level():
	var previous_level = current_level
	
	if game_time >= time_for_next_level:
		current_level += 1
		changeLevel()
		
		
		if current_level > max_level:
			current_level = 1
			level_loops += 1
		
		
		time_for_next_level += 30 * (current_level + (level_loops * max_level))
		
		
		var level_factor = current_level * 0.2
		
		
		var loop_factor = level_loops * 0.5
		
		
		current_scale = base_speed * (1 + level_factor + loop_factor)
		
		
		current_score_increment = ceil(base_score_increment * (1 + (current_level * 0.3) + (level_loops * 0.5)))
		current_bite_reward = ceil(base_bite_reward * (1 + (current_level * 0.5) + (level_loops * 0.7)))
		


func update_scaling():
	pass
	#if score >= initial_scale_threshold:
		#@warning_ignore("integer_division")
		#current_scale = base_speed * (1 + difficulty_curve * log(score / initial_scale_threshold))
		#
		#current_score_increment = ceil(base_score_increment * current_scale)
		#current_bite_reward = ceil(base_bite_reward * current_scale)
		#
		#if score >= scale_threshold:
			#scale_threshold += threshold_increment
			#current_scale += 0.05
			#threshold_increment = max(50, threshold_increment * 0.95)
	## Additional scaling based on score (optional - can work alongside level system)
	#if score >= 100:
		## Small additional boost based on score
		#var score_boost = difficulty_curve * log(score / 100)
		#current_scale += score_boost * 0.1  # Smaller impact than level changes

func deepDive():
	pass

func changeLevel():
	pass

func _process(_delta: float) -> void:
	
	$Menu/Score.text = str(score)
	
	# Update time display
	var minutes = floor(game_time / 60)
	var seconds = int(game_time) % 60

func newGame():
	score = 0;$Menu/Score.show()
	current_scale = 1.0
	game_time = 0
	current_level = 1
	time_for_next_level = 60
	current_score_increment = base_score_increment
	current_bite_reward = base_bite_reward
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
	mob.bitten.connect(_on_bird_shark_bitten)
	mob.speedincrease(current_scale) 
	add_child(mob)

func _on_score_timer_timeout() -> void:
	game_time += 1
	score += current_score_increment
	update_level()
	update_scaling()

func _on_start_timer_timeout() -> void:
	$Timer/MobSpawnTimer.start()
	$Timer/ScoreTimer.start()


func _on_menu_newgame_sigal() -> void:
	newGame()


func _on_player_dead() -> void:
	gameOver()
