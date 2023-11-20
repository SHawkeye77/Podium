extends Node2D

"""
PHASE DESCRIPTION:
	- Arm 1: Comes up from the bottom of the screen and then shifts left and right 4 times
"""

@onready var armScene = preload("res://enemies/arm.tscn")
@onready var phaseSpawner = get_tree().get_first_node_in_group("phaseSpawner")
var arm = null
var segment = 0

func _ready():
	# Setting up the arm
	arm = armScene.instantiate()
	arm.position.x = get_viewport_rect().size.x / 2
	arm.position.y = get_viewport_rect().size.y * 9 / 6
	arm.velocity.y = -1.0 * Global.PHASE_2_ARM_SPEED
	add_child(arm)

func _physics_process(delta):
	# Moving the arm in accordance with the segment we are on
	if segment == 0:
		if arm.position.y <= get_viewport_rect().size.y * 11 / 10:
			arm.velocity.y = 0
			arm.velocity.x = -1.0 * Global.PHASE_2_ARM_SPEED
			segment += 1
	elif segment == 1:
		if arm.position.x <= get_viewport_rect().size.x * 4 / 10:
			arm.velocity.x = Global.PHASE_2_ARM_SPEED
			segment += 1
	elif segment == 2:
		if arm.position.x >= get_viewport_rect().size.x * 6 / 10:
			arm.velocity.x = -1.0 * Global.PHASE_2_ARM_SPEED
			segment += 1
	elif segment == 3:
		if arm.position.x <= get_viewport_rect().size.x * 4 / 10:
			arm.velocity.x = Global.PHASE_2_ARM_SPEED
			segment += 1
	elif segment == 4:
		if arm.position.x >= get_viewport_rect().size.x * 6 / 10:
			arm.velocity.x = -1.0 * Global.PHASE_2_ARM_SPEED
			segment += 1
	elif segment == 5:
		if arm.position.x <= get_viewport_rect().size.x * 4 / 10:
			arm.velocity.x = Global.PHASE_2_ARM_SPEED
			segment += 1
	elif segment == 6:
		if arm.position.x >= get_viewport_rect().size.x * 6 / 10:
			arm.velocity.x = -1.0 * Global.PHASE_2_ARM_SPEED
			segment += 1
	elif segment == 7:
		if arm.position.x <= get_viewport_rect().size.x * 4 / 10:
			arm.velocity.x = Global.PHASE_2_ARM_SPEED
			segment += 1
	elif segment == 8:
		if arm.position.x >= get_viewport_rect().size.x * 6 / 10:
			arm.velocity.x = -1.0 * Global.PHASE_2_ARM_SPEED
			segment += 1
	elif segment == 9:
		if arm.position.x <= get_viewport_rect().size.x / 2:
			arm.velocity.x = 0
			arm.velocity.y = Global.PHASE_2_ARM_SPEED
			segment += 1
	elif segment == 10:
		if arm.position.y >= get_viewport_rect().size.y * 9 / 6:
			arm.velocity.x = 0
			arm.velocity.y = 0
			segment += 1
	else:
		phaseSpawner.progressNextPhase()
		queue_free()
