extends CharacterBody2D

@onready var bulletScene = preload("res://enemies/bullet.tscn")
@onready var timeBetweenBulletsTimer = get_node("%TimeBetweenBulletsTimer")
@onready var spawnPoints = get_node("%SpawnPoints")
@onready var shotSound = get_node("%ShotSound")

# Adjustable bullet creation values
@export var timeBetweenBullets = 1.0

func _ready():
	setTimeBetweenBullets(timeBetweenBullets)
	
func _physics_process(delta):
	move_and_slide()

func _on_time_between_bullets_timer_timeout():
	shotSound.play()
	# Shoot one bullet from each spawn point
	for spawnPoint in spawnPoints.get_children():
		var bullet = bulletScene.instantiate()
		get_tree().root.add_child(bullet)
		bullet.position = spawnPoint.global_position
		bullet.rotation = spawnPoint.global_rotation

func setTimeBetweenBullets(tbb):
	timeBetweenBulletsTimer.wait_time = tbb
	timeBetweenBulletsTimer.start()
