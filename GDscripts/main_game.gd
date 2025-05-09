extends Node

@export var BirdScene: PackedScene
@export var base_speed: float = 1.0
@export var initial_scale_threshold = 100
@export var threshold_increment = 125
@export var difficulty_curve: float = 0.15
@export var base_score_increment = 1
@export var base_bite_reward = 10

var score = 0
var current_scale: float = 1.0
var scale_threshold = initial_scale_threshold
var current_score_increment = 1
var current_bite_reward = 10

func _ready():
	pass
	#newGame()

func _on_shark_bitten():
	score += current_bite_reward
	update_scaling()

func update_scaling():
	if score >= initial_scale_threshold:
		@warning_ignore("integer_division")
		current_scale = base_speed * (1 + difficulty_curve * log(score / initial_scale_threshold))
		
		current_score_increment = ceil(base_score_increment * current_scale)
		current_bite_reward = ceil(base_bite_reward * current_scale)
		
		if score >= scale_threshold:
			scale_threshold += threshold_increment
			current_scale += 0.05
			threshold_increment = max(50, threshold_increment * 0.95)

func _process(_delta: float) -> void:
	# Update timer based on current scale
	$Timer/MobSpawnTimer.wait_time = 1/current_scale
	$Menu/Score.text = str(score)
	changeBGbyScore(score)

func newGame():
	score = 0;$Menu/Score.show()
	current_scale = 1.0
	scale_threshold = initial_scale_threshold
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
	mob.bitten.connect(_on_shark_bitten)
	mob.speedincrease(current_scale) 
	add_child(mob)

func _on_score_timer_timeout() -> void:
	score += current_score_increment
	update_scaling()

func _on_start_timer_timeout() -> void:
	$Timer/MobSpawnTimer.start()
	$Timer/ScoreTimer.start()

#
func changeBGbyScore(Score):
	pass
	#tạm thời bỏ 
	#if Score > -1:
		#$parallaxBackground.changeBackground(1)
	#if  Score >= 200:
		#$parallaxBackground.changeBackground(2)
	#if Score >= 300:
		#$parallaxBackground.changeBackground(3)
	#if Score >= 500:
		#$parallaxBackground.changeBackground(4)
		
func _on_menu_newgame_sigal() -> void:
	newGame()
