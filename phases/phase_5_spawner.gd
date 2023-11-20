extends Node2D

"""
PHASE DESCRIPTION:
	- Orb 1: Comes down from the top of the screen and then moves back and forth twice
	- Orb 2: Comes up from the bottom of the screen and then moves back and forth twice
"""

@onready var orbScene = preload("res://enemies/orb.tscn")
@onready var phaseSpawner = get_tree().get_first_node_in_group("phaseSpawner")
var orb1 = null
var orb2 = null
var segment = 0

func _ready():
	# Setting up orb 1
	orb1 = orbScene.instantiate()
	orb1.position.x = get_viewport_rect().size.x / 2
	orb1.position.y = -1.0 * get_viewport_rect().size.y / 6
	orb1.velocity.y = Global.PHASE_5_ORB_SPEED
	orb1.timeBetweenBullets = Global.PHASE_5_ORB_SHOT_FREQUENCY
	add_child(orb1)
	
	# Setting up orb 2
	orb2 = orbScene.instantiate()
	orb2.position.x = get_viewport_rect().size.x / 2
	orb2.position.y = get_viewport_rect().size.y * 7 / 6
	orb2.velocity.y = -1.0 * Global.PHASE_5_ORB_SPEED
	orb2.timeBetweenBullets = Global.PHASE_5_ORB_SHOT_FREQUENCY
	add_child(orb2)

func _physics_process(delta):
	# Moving the orbs in accordance with the segment we are on
	if segment == 0:
		if orb1.position.y >= get_viewport_rect().size.y / 6:
			orb1.velocity.y = 0
			orb1.velocity.x = -1.0 * Global.PHASE_5_ORB_SPEED
			orb2.velocity.y = 0
			orb2.velocity.x = Global.PHASE_5_ORB_SPEED
			segment += 1
	elif segment == 1:
		if orb1.position.x <= get_viewport_rect().size.x / 6:
			orb1.velocity.x = Global.PHASE_5_ORB_SPEED
			orb2.velocity.x = -1.0 * Global.PHASE_5_ORB_SPEED
			segment += 1
	elif segment == 2:
		if orb1.position.x >= get_viewport_rect().size.x / 6 * 5:
			orb1.velocity.x = -1.0 * Global.PHASE_1_ORB_SPEED
			orb2.velocity.x = Global.PHASE_1_ORB_SPEED
			segment += 1
	elif segment == 3:
		if orb1.position.x <= get_viewport_rect().size.x / 6:
			orb1.velocity.x = Global.PHASE_5_ORB_SPEED
			orb2.velocity.x = -1.0 * Global.PHASE_5_ORB_SPEED
			segment += 1
	elif segment == 4:
		if orb1.position.x >= get_viewport_rect().size.x / 6 * 5:
			orb1.velocity.x = -1.0 * Global.PHASE_5_ORB_SPEED
			orb2.velocity.x = Global.PHASE_5_ORB_SPEED
			segment += 1
	elif segment == 5:
		if orb1.position.x <= get_viewport_rect().size.x / 2:
			orb1.velocity.x = 0
			orb1.velocity.y = -1.0 * Global.PHASE_5_ORB_SPEED
			orb2.velocity.x = 0
			orb2.velocity.y = Global.PHASE_5_ORB_SPEED
			segment += 1
	elif segment == 6:
		if orb1.position.y <= -1.0 * get_viewport_rect().size.y / 6:
			orb1.velocity.x = 0
			orb1.velocity.y = 0
			orb2.velocity.x = 0
			orb2.velocity.y = 0
			segment += 1
	else:
		phaseSpawner.progressNextPhase()
		queue_free()
