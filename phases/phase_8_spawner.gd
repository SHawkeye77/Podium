extends Node2D

"""
PHASE DESCRIPTION:
	- Orb 1: Comes down from the top of the screen and then goes in a circle around the player four times
	- Arm 1: 
"""

@onready var orbScene = preload("res://enemies/orb.tscn")
@onready var armScene = preload("res://enemies/arm.tscn")
@onready var phaseSpawner = get_tree().get_first_node_in_group("phaseSpawner")

@export var rotations = 4

var orb = null
var arm = null
var segment = 0
var startingSpot = -1.0 * PI / 2
var angle = -1
var distanceToCenter = -1

func _ready():
	angle = startingSpot
	# Setting up the orb
	orb = orbScene.instantiate()
	orb.position.x = get_viewport_rect().size.x / 2
	orb.position.y = get_viewport_rect().size.y * -1 / 6
	orb.velocity.y = Global.PHASE_8_ORB_SPEED_LINEAR
	add_child(orb)
	# Setting up the arm
	arm = armScene.instantiate()
	arm.position.x = get_viewport_rect().size.x * -5 / 12
	arm.position.y = get_viewport_rect().size.y / 2
	arm.velocity.x = Global.PHASE_8_ARM_SPEED
	arm.rotation = PI / 2
	add_child(arm)

func _process(delta):
	# Moving the orb in accordance with the segment we are on
	if segment == 0:
		if orb.position.y >= get_viewport_rect().size.y / 6:
			distanceToCenter = orb.position.distance_to(get_viewport_rect().size / 2)
			orb.velocity.y = 0
			arm.velocity.x = Global.PHASE_8_ARM_SPEED_2 * -1
			segment += 1
	elif segment == 1:
		# Rotating the orb
		var center = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
		var x = center.x + distanceToCenter * cos(angle)
		var y = center.y + distanceToCenter * sin(angle)
		orb.set_position(Vector2(x, y))
		angle += Global.PHASE_8_ORB_SPEED_ANGULAR * delta
		
		if angle >= startingSpot + (PI):
			arm.velocity.x = Global.PHASE_8_ARM_SPEED_2
			segment += 1
	elif segment == 2:
		# Rotating the orb
		var center = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
		var x = center.x + distanceToCenter * cos(angle)
		var y = center.y + distanceToCenter * sin(angle)
		orb.set_position(Vector2(x, y))
		angle += Global.PHASE_8_ORB_SPEED_ANGULAR * delta
		
		if angle >= startingSpot + (2 * PI):
			arm.velocity.x = Global.PHASE_8_ARM_SPEED_2 * -1
			segment += 1
	elif segment == 3:
		# Rotating the orb
		var center = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
		var x = center.x + distanceToCenter * cos(angle)
		var y = center.y + distanceToCenter * sin(angle)
		orb.set_position(Vector2(x, y))
		angle += Global.PHASE_8_ORB_SPEED_ANGULAR * delta
		
		if angle >= startingSpot + (3 * PI):
			arm.velocity.x = Global.PHASE_8_ARM_SPEED_2
			segment += 1
	elif segment == 4:
		# Rotating the orb
		var center = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
		var x = center.x + distanceToCenter * cos(angle)
		var y = center.y + distanceToCenter * sin(angle)
		orb.set_position(Vector2(x, y))
		angle += Global.PHASE_8_ORB_SPEED_ANGULAR * delta
		
		if angle >= startingSpot + (4 * PI):
			orb.velocity.x = 0
			orb.velocity.y = - 1.0 * Global.PHASE_8_ORB_SPEED_LINEAR
			arm.velocity.x = Global.PHASE_8_ARM_SPEED * -1
			segment += 1
	elif segment == 5:
		if orb.position.y <= -1.0 * get_viewport_rect().size.y / 6:
			segment += 1
	else:
		phaseSpawner.progressNextPhase()
		queue_free()
