extends Node2D

var deademit = Database.playerDeath
var Singalemit = Database.HungerPt
var death = false
var starthunger = false

var jumpable = false
var holding = false
var submerged = false
@export var highjumpheight = 350
@export var midjump = 80
@export var lowjumpheight = 200

@export var hungerbomb = 25

@export var maxhunger = 150
@export var hunger = 100
@export var hungerrate = 8.5

var burst = 0
@export var burstactivate = 3
@export var burstreward = 1

func _ready():
	$BoosterFever.hide()
	$Jump.hide()
	add_to_group("player")		# For bomb collision detection

func bursting():
	pass

func eat(food):
	hunger += food
	if hunger > maxhunger:
		hunger = maxhunger
		burst += burstreward

func deadShark():
	deademit.emit()
	$DeathSfx.play()
	death = true
	$Mask/Shark.dead()

func start(pos):
	$Mask/Shark.new()
	starthunger = true
	jumpable = true
	position = pos
	show()

func _process(delta):
	if hunger <= 0 && !death:
		deadShark()
	if !death && starthunger:
		hunger -= hungerrate * delta
		Singalemit.emit(hunger)

	if jumpable && !Input.is_action_pressed("jump") && $Mask/Shark.rotation_degrees == 0:
		$WaterSpread.show()
		submerged = true
	if Input.is_action_just_pressed("jump") && jumpable && !death:
		holding = true
		$WaterSpread.hide()
		$Jump.offset.y = 0
		$Jump.animation = "start_up1"
		$Jump.show()
		$Jump.play()
		$Mask/Shark.dive(10)
		$Timer/JumpTimer.start()
	if Input.is_action_just_released("jump") && holding && !death:
		$Jump.offset.y = -36
		jumpable = false
		$WaterSpread.hide()
		if !$Timer/JumpTimer.is_stopped():
			$Jump.animation = "lowjump"
			var addedjump = midjump * (1 - $Timer/JumpTimer.time_left)
			$Mask/Shark.jump(-lowjumpheight - addedjump, "low")
			$Timer/JumpTimer.stop()
		else:
			$Jump.animation = "highjump"
			$Mask/Shark.jump(-highjumpheight, "high")
		$Jump.play()
		holding = false
		submerged = false

func _on_jump_timer_timeout() -> void:
	$Jump.animation = "start_up2"
	$Jump.play()
	$JumpReadySfx.play()

func _on_shark_water() -> void:
	jumpable = true


func _on_shark_oof() -> void:
	if !death && !holding:
		if submerged:
			hunger -= hungerbomb/2
		else:
			hunger -= hungerbomb		# Reduce hunger on bomb hit
		print("Player hit by bomb, hunger=", hunger)
		if hunger <= 0:
			deadShark()
