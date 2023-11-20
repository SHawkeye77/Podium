extends CharacterBody2D

@onready var bulletScene = preload("res://enemies/bullet.tscn")
@onready var timeBetweenBulletsTimer = get_node("%TimeBetweenBulletsTimer")
@onready var rotater = get_node("%Rotater")
@onready var shotSound = get_node("%ShotSound")

# Adjustable bullet creation values
@export var rotationSpeed = 100
@export var timeBetweenBullets = 0.2
@export var spawnPoints = 4

var radius = 20

func _ready():
	setUpSpawnPoints(spawnPoints)
	setUpTimeBetweenBullets(timeBetweenBullets)

func _physics_process(delta):
	# Rotating the bullet spawn points
	var newRotation = rotater.rotation_degrees + rotationSpeed * delta
	rotater.rotation_degrees = fmod(newRotation, 360)
	move_and_slide()

func _on_time_between_bullets_timer_timeout():
	shotSound.play()
	# Shoot one bullet from each spawn point on the rotater
	for spawnPoint in rotater.get_children():
		var bullet = bulletScene.instantiate()
		get_tree().root.add_child(bullet)
		bullet.position = spawnPoint.global_position
		bullet.rotation = spawnPoint.global_rotation

func setUpSpawnPoints(sp):
	# Remove any existing spawn points
	var nChildren = rotater.get_child_count()
	for i in range(nChildren):
		var spawnPoint = rotater.get_child(i)
		spawnPoint.queue_free()
	
	# Setting up the bullet spawn points around the enemy
	var step = 2 * PI / sp
	for i in range(sp):
		var spawnPoint = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawnPoint.position = pos
		spawnPoint.rotation = pos.angle()
		rotater.add_child(spawnPoint)

func setUpTimeBetweenBullets(tbb):
	timeBetweenBulletsTimer.wait_time = tbb
	timeBetweenBulletsTimer.start()
