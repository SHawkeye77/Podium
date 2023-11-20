extends Node2D

"""
PHASE DESCRIPTION:
	- Orb 1: Comes down from the top of the screen and then goes in a circle around the player twice
	- Orb 2: Comes up from the bottom of the screen and then goes in a circle around the player twice
"""

@onready var orbScene = preload("res://enemies/orb.tscn")
@onready var phaseSpawner = get_tree().get_first_node_in_group("phaseSpawner")

@export var rotations = 2

var orb1 = null
var orb2 = null
var segment = 0
var orb1StartAngle = -1.0 * PI / 2
var orb2startAngle = PI / 2
var orb1Angle = -1
var orb2Angle = -1
var distanceToCenter = -1

func _ready():
	# Setting up the orbs
	orb1Angle = orb1StartAngle
	orb1 = orbScene.instantiate()
	orb1.position.x = get_viewport_rect().size.x / 2
	orb1.position.y = get_viewport_rect().size.y * -1 / 6
	orb1.velocity.y = Global.PHASE_9_ORB_SPEED_LINEAR
	orb1.timeBetweenBullets = 0.3
	add_child(orb1)
	# Setting up the orbs
	orb2Angle = orb2startAngle
	orb2 = orbScene.instantiate()
	orb2.position.x = get_viewport_rect().size.x / 2
	orb2.position.y = get_viewport_rect().size.y * 7 / 6
	orb2.velocity.y = Global.PHASE_9_ORB_SPEED_LINEAR * -1
	orb2.timeBetweenBullets = 0.3
	add_child(orb2)

func _process(delta):
	# Moving the orb in accordance with the segment we are on
	if segment == 0:
		if orb1.position.y >= get_viewport_rect().size.y / 6:
			distanceToCenter = orb1.position.distance_to(get_viewport_rect().size / 2)
			orb1.velocity.y = 0
			orb2.velocity.y = 0
			segment += 1
	elif segment == 1:
		# Orb 1
		var center = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
		var x1 = center.x + distanceToCenter * cos(orb1Angle)
		var y1 = center.y + distanceToCenter * sin(orb1Angle)
		orb1.set_position(Vector2(x1, y1))
		orb1Angle += Global.PHASE_9_ORB_SPEED_ANGULAR * delta
		# Orb 2
		var x2 = center.x + distanceToCenter * cos(orb2Angle)
		var y2 = center.y + distanceToCenter * sin(orb2Angle)
		orb2.set_position(Vector2(x2, y2))
		orb2Angle += Global.PHASE_9_ORB_SPEED_ANGULAR * delta
		if orb1Angle >= orb1StartAngle + (rotations * 2 * PI):
			orb1.velocity.x = 0
			orb1.velocity.y = Global.PHASE_9_ORB_SPEED_LINEAR * -1
			orb2.velocity.x = 0
			orb2.velocity.y = Global.PHASE_9_ORB_SPEED_LINEAR
			segment += 1
	elif segment == 2:
		if orb1.position.y <= get_viewport_rect().size.y * -1 / 6:
			segment += 1
	else:
		phaseSpawner.progressNextPhase()
		queue_free()
