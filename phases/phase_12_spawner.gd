extends Node2D

"""
PHASE DESCRIPTION:
	- Orb 1: Comes down from the top of the screen and then moves back and forth twice, changing its rotation speed occasionally
"""

@onready var orbScene = preload("res://enemies/orb.tscn")
@onready var phaseSpawner = get_tree().get_first_node_in_group("phaseSpawner")
var orb = null
var segment = 0

func _ready():
	# Setting up the orb
	orb = orbScene.instantiate()
	orb.position.x = get_viewport_rect().size.x / 2
	orb.position.y = -1.0 * get_viewport_rect().size.y / 6
	orb.velocity.y = Global.PHASE_12_ORB_SPEED
	add_child(orb)

func _physics_process(delta):
	# Moving the orb in accordance with the segment we are on
	if segment == 0:
		if orb.position.y >= get_viewport_rect().size.y / 6:
			orb.velocity.y = 0
			orb.velocity.x = -1.0 * Global.PHASE_12_ORB_SPEED
			orb.rotationSpeed = 20
			segment += 1
	elif segment == 1:
		if orb.position.x <= get_viewport_rect().size.x / 6:
			orb.velocity.x = Global.PHASE_12_ORB_SPEED
			segment += 1
	elif segment == 2:
		if orb.position.x >= get_viewport_rect().size.x / 6 * 5:
			orb.velocity.x = -1.0 * Global.PHASE_12_ORB_SPEED
			segment += 1
	elif segment == 3:
		if orb.position.x <= get_viewport_rect().size.x / 6:
			orb.velocity.x = Global.PHASE_12_ORB_SPEED
			segment += 1
	elif segment == 4:
		if orb.position.x >= get_viewport_rect().size.x / 6 * 5:
			orb.velocity.x = -1.0 * Global.PHASE_12_ORB_SPEED
			segment += 1
	elif segment == 5:
		if orb.position.x <= get_viewport_rect().size.x / 2:
			orb.velocity.x = 0
			orb.velocity.y = -1.0 * Global.PHASE_12_ORB_SPEED
			orb.rotationSpeed = 100
			segment += 1
	elif segment == 6:
		if orb.position.y <= -1.0 * get_viewport_rect().size.y / 6:
			orb.velocity.x = 0
			orb.velocity.y = 0
			segment += 1
	else:
		phaseSpawner.progressNextPhase()
		queue_free()
