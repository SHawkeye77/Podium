extends Node2D

"""
PHASE DESCRIPTION:
	- Orb 1: Comes down from the top of the screen and then moves back and forth twice
	- Arm 2: Comes up from the bottom of the screen and then moves back and forth twice
"""

@onready var orbScene = preload("res://enemies/orb.tscn")
@onready var armScene = preload("res://enemies/arm.tscn")
@onready var phaseSpawner = get_tree().get_first_node_in_group("phaseSpawner")
var orb = null
var arm = null
var segment = 0

func _ready():
	# Setting up the orb
	orb = orbScene.instantiate()
	orb.position.x = get_viewport_rect().size.x / 2
	orb.position.y = -1.0 * get_viewport_rect().size.y / 6
	orb.velocity.y = Global.PHASE_7_ORB_SPEED
	add_child(orb)
	# Setting up the arm
	arm = armScene.instantiate()
	arm.position.x = get_viewport_rect().size.x / 2
	arm.position.y = get_viewport_rect().size.y * 17 / 12
	arm.velocity.y = Global.PHASE_7_ORB_SPEED * -1
	add_child(arm)

func _physics_process(delta):
	# Moving the orb and arm move in accordance with the segment we are on
	if segment == 0:
		if orb.position.y >= get_viewport_rect().size.y / 6:
			orb.velocity.y = 0
			orb.velocity.x = Global.PHASE_7_ORB_SPEED * -1
			arm.velocity.y = 0
			arm.velocity.x = Global.PHASE_7_ARM_SPEED
			segment += 1
	elif segment == 1:
		if orb.position.x <= get_viewport_rect().size.x / 6:
			orb.velocity.x = Global.PHASE_7_ORB_SPEED
			arm.velocity.x = Global.PHASE_7_ARM_SPEED * -1
			segment += 1
	elif segment == 2:
		if orb.position.x >= get_viewport_rect().size.x / 6 * 5:
			orb.velocity.x = Global.PHASE_7_ORB_SPEED * -1
			arm.velocity.x = Global.PHASE_7_ARM_SPEED
			segment += 1
	elif segment == 3:
		if orb.position.x <= get_viewport_rect().size.x / 6:
			orb.velocity.x = Global.PHASE_7_ORB_SPEED
			arm.velocity.x = Global.PHASE_7_ARM_SPEED * -1
			segment += 1
	elif segment == 4:
		if orb.position.x >= get_viewport_rect().size.x / 6 * 5:
			orb.velocity.x = Global.PHASE_7_ORB_SPEED * -1
			arm.velocity.x = Global.PHASE_7_ARM_SPEED
			segment += 1
	elif segment == 5:
		if orb.position.x <= get_viewport_rect().size.x / 2:
			orb.velocity.x = 0
			orb.velocity.y = Global.PHASE_7_ORB_SPEED * -1
			arm.velocity.x = 0
			arm.velocity.y = Global.PHASE_7_ARM_SPEED
			segment += 1
	elif segment == 6:
		if orb.position.y <= -1.0 * get_viewport_rect().size.y / 6:
			segment += 1
	else:
		phaseSpawner.progressNextPhase()
		queue_free()
