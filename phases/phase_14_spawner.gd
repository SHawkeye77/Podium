extends Node2D

"""
PHASE DESCRIPTION:
	- Orb 1: Comes down from the top of the screen, rotates in a half circle twice, then goes off the top of the screen
"""

@onready var orbScene = preload("res://enemies/orb.tscn")
@onready var phaseSpawner = get_tree().get_first_node_in_group("phaseSpawner")

@export var rotations = 2

var orb = null
var segment = 0
var angle = -1.0 * PI / 2
var distanceToCenter = -1

func _ready():
	# Setting up the orb
	orb = orbScene.instantiate()
	orb.position.x = get_viewport_rect().size.x / 2
	orb.position.y = -1.0 * get_viewport_rect().size.y / 6
	orb.velocity.y = Global.PHASE_14_ORB_SPEED_LINEAR
	add_child(orb)

func _process(delta):
	# Moving the orb in accordance with the segment we are on
	if segment == 0:
		if orb.position.y >= get_viewport_rect().size.y / 6:
			distanceToCenter = orb.position.distance_to(get_viewport_rect().size / 2)
			orb.velocity.y = 0
			orb.setUpTimeBetweenBullets(0.5)
			orb.setUpSpawnPoints(10)
			segment += 1
	elif segment == 1:
		var center = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
		var x = center.x + distanceToCenter * cos(angle)
		var y = center.y + distanceToCenter * sin(angle)
		orb.set_position(Vector2(x, y))
		angle -= Global.PHASE_14_ORB_SPEED_ROTATIONAL * delta
		if angle <= (-1.0 * PI / 2) - (PI / 2):
			segment += 1
	elif segment == 2:
		var center = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
		var x = center.x + distanceToCenter * cos(angle)
		var y = center.y + distanceToCenter * sin(angle)
		orb.set_position(Vector2(x, y))
		angle += Global.PHASE_14_ORB_SPEED_ROTATIONAL * delta
		if angle >= (-1.0 * PI / 2) + (PI / 2):
			orb.setUpTimeBetweenBullets(0.2)
			orb.setUpSpawnPoints(4)
			segment += 1
	elif segment == 3:
		var center = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
		var x = center.x + distanceToCenter * cos(angle)
		var y = center.y + distanceToCenter * sin(angle)
		orb.set_position(Vector2(x, y))
		angle -= Global.PHASE_14_ORB_SPEED_ROTATIONAL * delta
		if angle <= (-1.0 * PI / 2) - (PI / 2):
			orb.setUpTimeBetweenBullets(0.5)
			orb.setUpSpawnPoints(10)
			segment += 1
	elif segment == 4:
		var center = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
		var x = center.x + distanceToCenter * cos(angle)
		var y = center.y + distanceToCenter * sin(angle)
		orb.set_position(Vector2(x, y))
		angle += Global.PHASE_14_ORB_SPEED_ROTATIONAL * delta
		if angle >= (-1.0 * PI / 2) + (PI / 2):
			orb.setUpTimeBetweenBullets(0.2)
			orb.setUpSpawnPoints(4)
			segment += 1
	elif segment == 5:
		var center = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
		var x = center.x + distanceToCenter * cos(angle)
		var y = center.y + distanceToCenter * sin(angle)
		orb.set_position(Vector2(x, y))
		angle -= Global.PHASE_14_ORB_SPEED_ROTATIONAL * delta
		if angle <= (-1.0 * PI / 2):
			segment += 1
			orb.velocity.x = 0
			orb.velocity.y = Global.PHASE_14_ORB_SPEED_LINEAR * -1
	elif segment == 6:
		if orb.position.y <= -1.0 * get_viewport_rect().size.y / 6:
			segment += 1
	else:
		phaseSpawner.progressNextPhase()
		queue_free()
