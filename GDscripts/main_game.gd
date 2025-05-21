extends Node

@export var birdfoodreward = 24
@export var BoatScene: PackedScene
@export var BirdScene: PackedScene
@export var base_score_increment = 1
@export var base_bite_reward = 10

var bossfight: bool = false
var burst_score = 15
var time_score = 0
var bite_score = 0
var bonus_score = 0
var total_score = 0
var current_score_increment = 1
var current_bite_reward = 10
var current_level = 1
var time_for_next_level = 25
var max_level = 5
var level_loops = 0
var boatcap = 3
var ReplayReceive = Database.replay

func _ready():
	print("Game initialized")
	if ReplayReceive:
		ReplayReceive.connect(_on_replay_pressed)
		print("ReplayReceive signal connected")
	else:
		print("Warning: ReplayReceive signal not found")
	# newGame()  # Uncomment to start game automatically

func _on_bird_shark_bitten():
	if bossfight or _on_bar_burst_mode():
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
		changeLevel()
		bossfight = true
		current_level += 1
		if current_level > max_level:
			current_level = 1
			level_loops += 1
		time_for_next_level += 20 * (current_level + (level_loops * max_level))
		print("New time_for_next_level: ", time_for_next_level)

func deepDive():
	pass

func changeLevel():
	if $Timer/MobSpawnTimer.wait_time > 1:
		$Timer/MobSpawnTimer.wait_time -= 0.5
	$Player.hungerrate += 1
	current_score_increment += base_score_increment
	current_bite_reward += base_bite_reward/2
	var boat = BoatScene.instantiate()
	var boatSpawnLocation = $BoatSpawn
	boat.position = boatSpawnLocation.position
	boat.player = $Player
	boat.boatlevel = current_level if current_level < 3 else 3
	boat.bonusbomb = level_loops
	boat.bossleave.connect(_on_bossleave)
	add_child(boat)
	boat.add_to_group("boat")
	print("Boss spawned at level ", current_level)

func _on_bossleave():
	print("Boss left, ending bossfight")
	bossfight = false
	bonus_score += (current_level * 10) * (level_loops + 1)
	print("Bonus score added: ", bonus_score)

func _process(_delta: float) -> void:
	$Menu/Score.text = str(bite_score + time_score + bonus_score)
	# print("score: ", time_score)  # Commented out to reduce clutter

func restart_game():
	print("Restarting game")
	# Stop all timers
	$Timer/StartTimer.stop()
	$Timer/ScoreTimer.stop()
	$Timer/MobSpawnTimer.stop()
	# Remove all dynamic objects
	for boat in get_tree().get_nodes_in_group("boat"):
		boat.queue_free()
		print("Removed boat: ", boat.name)
	for bird in get_tree().get_nodes_in_group("bird"):
		bird.queue_free()
		print("Removed bird: ", bird.name)
	for bomb in get_tree().get_nodes_in_group("bomb"):
		bomb.queue_free()
		print("Removed bomb: ", bomb.name)
	# Reset game state
	total_score = 0
	bite_score = 0
	time_score = 0
	bonus_score = 0
	bossfight = false
	current_level = 1
	time_for_next_level = 25
	current_score_increment = base_score_increment
	current_bite_reward = base_bite_reward
	
	#Reset hunger bar
	$Player.hunger = 100
	Database.HungerPt.emit($Player.hunger)
	
	# Reset player
	$Player.start($PlayerSpawn.position)
	$Player.hunger = $Player.maxhunger
	$Player.death = false
	$Player.jumpable = true
	$Player.starthunger = true
	$Player.submerged = false
	if $Player.has_node("Mask/Shark"):
		var shark = $Player.get_node("Mask/Shark")
		shark.notdead = true
		shark.airborne = false
		shark.velocity = Vector2.ZERO
		shark.rotation_degrees = 0
		shark.get_node("SharkAnim").flip_v = false
		shark.get_node("SharkAnim").play("swimmin")
		print("Shark reset: notdead=", shark.notdead, " airborne=", shark.airborne)
	# Reset UI
	$Menu/Score.show()
	$Menu/Score.text = "0"
	if $Menu.has_node("GameOver"):
		$Menu/GameOver.hide()
		print("Game over screen hidden")
	# Restart music
	if has_node("Audio/MainMenuTheme"):
		$Audio/MainMenuTheme.play()
		print("MainMenuTheme restarted")
	# Start timers
	$Timer/StartTimer.start()
	print("Game restarted: ScoreTimer wait_time=", $Timer/ScoreTimer.wait_time)

func newGame():
	print("Starting new game")
	total_score = 0
	bite_score = 0
	time_score = 0
	bonus_score = 0
	bossfight = false
	$Menu/Score.show()
	current_level = 1
	time_for_next_level = 25
	current_score_increment = base_score_increment
	current_bite_reward = base_bite_reward
	$Player.start($PlayerSpawn.position)
	$Timer/StartTimer.start()
	print("ScoreTimer wait_time: ", $Timer/ScoreTimer.wait_time)

func gameOver():
	$Timer/ScoreTimer.stop()
	$Timer/MobSpawnTimer.stop()
	if $Menu.has_node("GameOver"):
		$Menu/GameOver.show()
		print("Game over screen shown")
	print("Game over")

func _on_mob_spawn_timer_timeout() -> void:
	var mob = BirdScene.instantiate()
	var mobSpawnLocation = $BirdSpawn/BirdLocation
	mobSpawnLocation.progress_ratio = randf()
	mob.position = mobSpawnLocation.position
	mob.bitten.connect(_on_bird_shark_bitten)
	add_child(mob)
	mob.add_to_group("bird")
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
	restart_game()
	print("Replay triggered")

func _on_player_dead() -> void:
	gameOver()


func _on_bar_burst_mode() -> bool:
	return true
