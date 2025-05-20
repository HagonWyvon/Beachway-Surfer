extends CharacterBody2D

signal bossleave

var bomb1LowerCap = 5
var bomb2LowerCap = 3
var bomb3LowerCap = 2
var boatlevel = 1
var player: Node2D  # Store player node

@export var BombScene: PackedScene
@export var enterspeed = 200
@export var leavespeed = 100
@export var boat1leavetime = 25
@export var boat2leavetime = 36
@export var boat3leavetime = 40

func _ready():
	$BossMusic.play()
	match boatlevel:
		1:
			$BombLauncherTimer.wait_time = randi_range(bomb1LowerCap, 7)
			$LeaveTimer.wait_time = boat1leavetime
			enterspeed = -160
			leavespeed = 225
		2:
			$BombLauncherTimer.wait_time = randi_range(bomb2LowerCap, 5)
			$LeaveTimer.wait_time = boat2leavetime
			enterspeed = -180
			leavespeed = 235
		3:
			$BombLauncherTimer.wait_time = randi_range(bomb3LowerCap, 3)
			$LeaveTimer.wait_time = boat3leavetime
			enterspeed = -200
			leavespeed = 245
	velocity.x = enterspeed
	boatWater()

func _process(delta: float) -> void:
	if $LeaveTimer.is_stopped() && $EnterTimer.is_stopped():
		velocity.x = 0
		$LeaveTimer.start()
	position += velocity * delta

func boatWater():
	match $BoatSprite.animation:
		"boat1":
			$Water.offset.x = 12
			$Water.offset.y = 12
		"boat2":
			$Water.offset.x = 16
			$Water.offset.y = 16
		"boat3":
			$Water.offset.x = 9
			$Water.offset.y = 9

func _on_bomb_launcher_timer_timeout() -> void:
	var mob = BombScene.instantiate()
	var mobSpawnLocation = $BombSpawn
	mob.global_position = mobSpawnLocation.global_position
	if player:
		mob.launch_to_player(player.global_position)
		print("Bomb launched toward player at ", player.global_position)
	else:
		print("No player found for bomb launch")
	add_child(mob)

func _on_leave_timer_timeout() -> void:
	velocity.x = leavespeed

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	bossleave.emit()
	queue_free()
