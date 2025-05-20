extends Node

@export var birdfoodreward = 24
@export var BoatScene: PackedScene
@export var BirdScene: PackedScene
@export var base_score_increment = 1
@export var base_bite_reward = 10

var bossfight: bool = false
var time_score = 0
var bite_score = 0
var bonus_score = 0
var total_score = 0
var current_score_increment = 1
var current_bite_reward = 10
var current_level = 1
var time_for_next_level = 5
var max_level = 5
var level_loops = 0
var boatcap = 3
var ReplayReceive = Database.replay

func _ready():
	print("Game initialized")
	# newGame()  # Uncomment to start game automatically
	ReplayReceive.connect(_on_replay_pressed)

func _on_bird_shark_bitten():
	if bossfight:
		bite_score += current_bite_reward * 2
		$Player.eat(birdfoodreward * 2)
		print("Bird bitten during bossfight: bite_score +=", current_bite_reward * 2)
	else:
		bite_score += current_bite_reward
		$Player.eat(birdfoodreward)
		print("Bird bitten: bite_score +=", current_bite_reward)

func update_level():
	print("Checking level update: time_score=", time_score, " time_for_next_level=", time_for_next_level, " bossfight=", bossfight)
	if time_score >= time_for_next_level:
		print("Level advancing to ", current_level + 1)
		bossfight = true
		current_level += 1
		changeLevel()
		if current_level > max_level:
			current_level = 1
			level_loops += 1
		time_for_next_level += 10 * (current_level + (level_loops * max_level))
		print("New time_for_next_level: ", time_for_next_level)

func deepDive():
	pass

func changeLevel():
	var boat = BoatScene.instantiate()
	var boatSpawnLocation = $BoatSpawn
	boat.position = boatSpawnLocation.position
	boat.player = $Player
	boat.boatlevel = current_level if current_level < 3 else 3
	boat.bossleave.connect(_on_bossleave)
	add_child(boat)
	print("Boss spawned at level ", current_level)

func _on_bossleave():
	print("Boss left, ending bossfight")
	bossfight = false
	bonus_score += (current_level * 10) * (level_loops + 1)
	print("Bonus score added: ", bonus_score)

func _process(_delta: float) -> void:
	$Menu/Score.text = str(bite_score + time_score + bonus_score)
	# print("score: ", time_score)  # Commented out to reduce clutter

func newGame():
	print("Starting new game")
	total_score = 0
	bite_score = 0
	time_score = 0
	bonus_score = 0
	bossfight = false
	$Menu/Score.show()
	current_level = 1
	time_for_next_level = 5
	current_score_increment = base_score_increment
	current_bite_reward = base_bite_reward
	$Player.start($PlayerSpawn.position)
	$Timer/StartTimer.start()
	print("ScoreTimer wait_time: ", $Timer/ScoreTimer.wait_time)

func gameOver():
	$Timer/ScoreTimer.stop()
	$Timer/MobSpawnTimer.stop()
	print("Game over")

func _on_mob_spawn_timer_timeout() -> void:
	var mob = BirdScene.instantiate()
	var mobSpawnLocation = $BirdSpawn/BirdLocation
	mobSpawnLocation.progress_ratio = randf()
	mob.position = mobSpawnLocation.position
	mob.bitten.connect(_on_bird_shark_bitten)
	add_child(mob)
	print("Bird spawned")

func _on_score_timer_timeout() -> void:
	if !bossfight:
		time_score += current_score_increment
		print("Time score incremented: ", time_score, " | Next level at: ", time_for_next_level, " | Bossfight: ", bossfight)
		update_level()

func _on_start_timer_timeout() -> void:
	$Timer/MobSpawnTimer.start()
	$Timer/ScoreTimer.start()
	print("Timers started")

func _on_menu_newgame_sigal() -> void:
	newGame()

func _on_replay_pressed() -> void:
	newGame()
	print('ok')


func _on_player_dead() -> void:
	gameOver()
