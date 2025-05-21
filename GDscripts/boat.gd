extends CharacterBody2D

signal bossleave


var bomb1LowerCap = 5
var bomb2LowerCap = 3
var bomb3LowerCap = 2
var boatlevel = 1
var bombburst = 1
var bonusbomb = 0
var player: Node2D

@export var BombScene: PackedScene
@export var enterspeed = 200
@export var leavespeed = 100
@export var boat1leavetime = 25
@export var boat2leavetime = 36
@export var boat3leavetime = 40

func _ready():
	$BossMusic.play()
	$TextureProgressBar.visible = false
	match boatlevel:
		1:
			print("Boatlevel: ", boatlevel)
			$BoatSprite.animation = "boat1"
			$BombLauncherTimer.wait_time = randi_range(bomb1LowerCap, 7)
			$LeaveTimer.wait_time = boat1leavetime
			enterspeed = -160
			leavespeed = 225
		2:
			print("Boatlevel: ", boatlevel)
			$BoatSprite.animation = "boat2"
			$BombLauncherTimer.wait_time = randi_range(bomb2LowerCap, 5)
			$LeaveTimer.wait_time = boat2leavetime
			enterspeed = -180
			leavespeed = 235
		3:
			print("Boatlevel: ", boatlevel)
			$BoatSprite.animation = "boat3"
			$BombLauncherTimer.wait_time = randi_range(bomb3LowerCap, 3)
			$LeaveTimer.wait_time = boat3leavetime
			enterspeed = -200
			leavespeed = 245
	velocity.x = enterspeed
	boatWater()

func _process(delta: float) -> void:
	
	#print("BossTime", $LeaveTimer.time_left)
	position += velocity * delta
	if $BombLauncherTimer.time_left <= 1:
		$TextureProgressBar.visible = true
		var bombprogress = (1 - $BombLauncherTimer.time_left)*100
		$TextureProgressBar.value = bombprogress
		
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
	$TextureProgressBar.visible = false
	bombburst = boatlevel + bonusbomb
	while bombburst:
		var smoke_types = Array($Smoke.sprite_frames.get_animation_names())
		$Smoke.animation = smoke_types.pick_random()
		$Smoke.play()
		bombburst -= 1
		var mob = BombScene.instantiate()
		mob.global_position = $BombSpawn.global_position
		if player:
			if player.rotation_degrees != 0:
				mob.launch_to_player(player.global_position, randf_range(85,175))
			else:
				mob.launch_to_player(player.global_position)
			print("Bomb launched toward player at ", player.global_position)
		else:
			print("No player found for bomb launch")
		get_tree().current_scene.add_child(mob)  # Add to root node
		$CannonSfx.play()
		await get_tree().create_timer(0.1).timeout

func _on_leave_timer_timeout() -> void:
	velocity.x = leavespeed

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	bossleave.emit()
	queue_free()


func _on_enter_timer_timeout() -> void:
	velocity.x = 0
	$LeaveTimer.start()


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	pass # Replace with function body.
