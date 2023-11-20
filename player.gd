extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var healthBar = get_node("%HealthBar")
@onready var takeDamageCooldown = get_node("%TakeDamageCooldown")
@onready var hurtAudio = get_node("HurtAudio")
@onready var phaseSpawner = get_tree().get_first_node_in_group("phaseSpawner")
const endScreen = "res://screens/end_screen.tscn"
var hp = Global.PLAYER_STARTING_HP
var canTakeDamage = true

func _ready():
	healthBar.value = Global.PLAYER_STARTING_HP
	healthBar.max_value = Global.PLAYER_STARTING_HP
	takeDamageCooldown.wait_time = Global.PLAYER_TAKE_DAMAGE_COOLDOWN

func _physics_process(delta):
	movement()

func movement():
	# Calculates movement based on user input
	var xMov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var yMov = Input.get_action_strength("down") - Input.get_action_strength("up")
	var mov = Vector2(xMov, yMov)
	
	# Flipping sprite based on left/right movement
	if mov.x > 0:
		sprite.flip_h = false
	elif mov.x < 0:
		sprite.flip_h = true
	
	# Moving the player
	velocity = mov.normalized() * Global.PLAYER_MOVEMENT_SPEED
	move_and_slide()

func playerHit(damage):
	if canTakeDamage:
		canTakeDamage = false
		takeDamageCooldown.start()
		hp -= damage
		healthBar.value = hp
		hurtAudio.play()
		if hp <= 0:
			death("Health bar got to zero")

func death(reason):
	print("You died. You died because \"", reason, "\"")
	Global.phasesSurvived = phaseSpawner.currentPhaseIndex - 1
	var _level = get_tree().change_scene_to_file(endScreen)

func win():
	Global.phasesSurvived = phaseSpawner.currentPhaseIndex - 1
	var _level = get_tree().change_scene_to_file(endScreen)

func _on_take_damage_cooldown_timeout():
	canTakeDamage = true
