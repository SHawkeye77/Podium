extends Node2D

"""
PHASE DESCRIPTION:
	- Arm 1: Comes up from the bottom of the screen and then goes in a circle around the player twice
"""

@onready var armScene = preload("res://enemies/arm.tscn")
@onready var phaseSpawner = get_tree().get_first_node_in_group("phaseSpawner")

@export var rotations = 2

var arm = null
var segment = 0
var angle = PI / 2
var distanceToCenter = -1

func _ready():
	# Setting up the arm
	arm = armScene.instantiate()
	arm.position.x = get_viewport_rect().size.x / 2
	arm.position.y = get_viewport_rect().size.y * 9 / 6
	arm.velocity.y = -1.0 * Global.PHASE_4_ARM_SPEED
	# New arm attributes
	arm.timeBetweenBullets = 0.6
	add_child(arm)

func _process(delta):
	# Moving the orb in accordance with the segment we are on
	if segment == 0:
		if arm.position.y <= get_viewport_rect().size.y * 11 / 10:
			distanceToCenter = arm.position.distance_to(get_viewport_rect().size / 2)
			arm.velocity.y = 0
			segment += 1
	elif segment == 1:
		# Moving the arm around the circle
		var center = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
		var x = center.x + distanceToCenter * cos(angle)
		var y = center.y + distanceToCenter * sin(angle)
		arm.set_position(Vector2(x, y))
		# Facing the arm towards the center of the screen
		var rotation = (angle - PI / 2)
		arm.rotation = rotation
		# Updating the angle for the next frame
		angle += Global.PHASE_4_ROTATION_SPEED * delta
		# Stopping the rotation after the given number of rotations
		if angle >= (PI / 2) + (rotations * 2 * PI):
			arm.velocity.x = 0
			arm.velocity.y = Global.PHASE_4_ARM_SPEED
			segment += 1
	elif segment == 2:
		if arm.position.y >= get_viewport_rect().size.y * 9 / 6:
			segment += 1
	else:
		phaseSpawner.progressNextPhase()
		queue_free()
