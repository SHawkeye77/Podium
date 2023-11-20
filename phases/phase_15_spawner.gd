extends Node2D

"""
PHASE DESCRIPTION:
	- Arm 1: Comes up from the bottom of the screen, rotates in a half-circle twice, then exits via the bottom of the screen
	- Orb 1: Comes down from the top of the screen, sits still, then exits via the top of the screen
"""

@onready var orbScene = preload("res://enemies/orb.tscn")
@onready var armScene = preload("res://enemies/arm.tscn")
@onready var phaseSpawner = get_tree().get_first_node_in_group("phaseSpawner")

@export var rotations = 2

var orb = null
var arm = null
var segment = 0
var angle = PI / 2
var distanceToCenter = -1

func _ready():
	# Setting up the arm
	arm = armScene.instantiate()
	arm.position.x = get_viewport_rect().size.x / 2
	arm.position.y = get_viewport_rect().size.y * 9 / 6
	arm.velocity.y = -1.0 * Global.PHASE_15_ARM_SPEED_LINEAR
	# New arm attributes
	arm.timeBetweenBullets = 1
	add_child(arm)
	# Setting up the orb
	orb = orbScene.instantiate()
	orb.position.x = get_viewport_rect().size.x / 2
	orb.position.y = get_viewport_rect().size.y * -1 / 6
	orb.velocity.y = Global.PHASE_15_ORB_SPEED
	orb.timeBetweenBullets = 0.6
	add_child(orb)

func _process(delta):
	# Moving the arm in accordance with the segment we are on
	if segment == 0:
		if arm.position.y <= get_viewport_rect().size.y * 11 / 10:
			distanceToCenter = arm.position.distance_to(get_viewport_rect().size / 2)
			arm.velocity.y = 0
			orb.velocity.y = 0
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
		angle -= Global.PHASE_15_ARM_SPEED_ROTATIONAL * delta
		if angle <= 0:
			segment += 1
	elif segment == 2:
		# Moving the arm around the circle
		var center = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
		var x = center.x + distanceToCenter * cos(angle)
		var y = center.y + distanceToCenter * sin(angle)
		arm.set_position(Vector2(x, y))
		# Facing the arm towards the center of the screen
		var rotation = (angle - PI / 2)
		arm.rotation = rotation
		# Updating the angle for the next frame
		angle += Global.PHASE_15_ARM_SPEED_ROTATIONAL * delta
		if angle >= PI:
			segment += 1
	elif segment == 3:
		# Moving the arm around the circle
		var center = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
		var x = center.x + distanceToCenter * cos(angle)
		var y = center.y + distanceToCenter * sin(angle)
		arm.set_position(Vector2(x, y))
		# Facing the arm towards the center of the screen
		var rotation = (angle - PI / 2)
		arm.rotation = rotation
		# Updating the angle for the next frame
		angle -= Global.PHASE_15_ARM_SPEED_ROTATIONAL * delta
		if angle <= 0:
			segment += 1
	elif segment == 4:
		# Moving the arm around the circle
		var center = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
		var x = center.x + distanceToCenter * cos(angle)
		var y = center.y + distanceToCenter * sin(angle)
		arm.set_position(Vector2(x, y))
		# Facing the arm towards the center of the screen
		var rotation = (angle - PI / 2)
		arm.rotation = rotation
		# Updating the angle for the next frame
		angle += Global.PHASE_15_ARM_SPEED_ROTATIONAL * delta
		if angle >= PI/2:
			arm.velocity.x = 0
			arm.velocity.y = Global.PHASE_15_ARM_SPEED_LINEAR
			orb.velocity.y = Global.PHASE_15_ORB_SPEED * -1
			segment += 1
	elif segment == 5:
		if arm.position.y >= get_viewport_rect().size.y * 9 / 6:
			segment += 1
	else:
		phaseSpawner.progressNextPhase()
		queue_free()
