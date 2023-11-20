extends Node2D

"""
PHASE DESCRIPTION:
	- Arm 1: Comes down from the top of the screen, waits, then goes back up off the top of the screen
	- Arm 2: Comes up from the bottom of the screen, rotates around the player twice, then goes back down off the bottom of the screen
"""

@onready var armScene = preload("res://enemies/arm.tscn")
@onready var phaseSpawner = get_tree().get_first_node_in_group("phaseSpawner")

@export var rotations = 2

var arm1 = null
var arm2 = null
var segment = 0
var angle = PI / 2
var distanceToCenter = -1

func _ready():
	# Setting up the arms
	arm1 = armScene.instantiate()
	arm1.position.x = get_viewport_rect().size.x / 2
	arm1.position.y = get_viewport_rect().size.y * 9 / 6
	arm1.velocity.y = -1.0 * Global.PHASE_6_ARM_SPEED_LINEAR
	arm2 = armScene.instantiate()
	arm2.position.x = get_viewport_rect().size.x / 2
	arm2.position.y = get_viewport_rect().size.y * -1.0 * 3 / 6
	arm2.velocity.y = Global.PHASE_6_ARM_SPEED_LINEAR
	arm2.rotation = PI
	# New arm attributes
	arm1.timeBetweenBullets = 1.0
	arm2.timeBetweenBullets = 1.0
	add_child(arm1)
	add_child(arm2)

func _process(delta):
	# Moving the orb in accordance with the segment we are on
	if segment == 0:
		if arm1.position.y <= get_viewport_rect().size.y * 11 / 10:
			arm2.velocity.y = 0
			arm1.velocity.y = 0
			segment += 1
	elif segment == 1:
		# Moving an arm around the circle
		distanceToCenter = arm1.position.distance_to(get_viewport_rect().size / 2)
		var center = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
		var x = center.x + distanceToCenter * cos(angle)
		var y = center.y + distanceToCenter * sin(angle)
		arm1.set_position(Vector2(x, y))
		# Facing the arm towards the center of the screen
		var rotation = (angle - PI / 2)
		arm1.rotation = rotation
		# Updating the angle for the next frame
		angle += Global.PHASE_6_ARM_SPEED_ANGULAR * delta
		# Stopping the rotation after the given number of rotations
		if angle >= (PI / 2) + (rotations * 2 * PI):
			arm1.velocity.x = 0
			arm1.velocity.y = Global.PHASE_6_ARM_SPEED_LINEAR
			arm2.velocity.y = -1.0 * Global.PHASE_6_ARM_SPEED_LINEAR
			segment += 1
	elif segment == 2:
		if arm1.position.y >= get_viewport_rect().size.y * 9 / 6:
			segment += 1
	else:
		phaseSpawner.progressNextPhase()
		queue_free()
