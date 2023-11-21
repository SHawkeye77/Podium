extends Node2D

@onready var world = get_tree().get_first_node_in_group("world")
@onready var player = get_tree().get_first_node_in_group("player")

@onready var phases = [
	preload("res://phases/phase_1_spawner.tscn"),   # Phase 1
	preload("res://phases/phase_2_spawner.tscn"),   # Phase 2
	preload("res://phases/phase_3_spawner.tscn"),   # Phase 3
	preload("res://phases/phase_4_spawner.tscn"),   # Phase 4
	preload("res://phases/phase_5_spawner.tscn"),   # Phase 5
	preload("res://phases/phase_6_spawner.tscn"),   # Phase 6
	preload("res://phases/phase_7_spawner.tscn"),   # Phase 7
	preload("res://phases/phase_8_spawner.tscn"),   # Phase 8
	preload("res://phases/phase_9_spawner.tscn"),   # Phase 9
	preload("res://phases/phase_10_spawner.tscn"),  # Phase 10
	preload("res://phases/phase_11_spawner.tscn"),  # Phase 11
	preload("res://phases/phase_12_spawner.tscn"),  # Phase 12
	preload("res://phases/phase_13_spawner.tscn"),  # Phase 13
	preload("res://phases/phase_14_spawner.tscn"),  # Phase 14
	preload("res://phases/phase_15_spawner.tscn"),  # Phase 15
]

#@onready var phases = [preload("res://phases/phase_15_spawner.tscn")]  # FOR DEBUGGING, UNCOMMENT THIS AND COMMENT OUT THE PREVIOUS "phases" VARIABLE
@export var randomMode = true
var currentPhaseIndex = -1

func _ready():
	# Either going through the phases randomly or in the order specified above
	if randomMode:
		phases.shuffle()

	phases.insert(0, null)
	currentPhaseIndex = 0
	progressNextPhase()

func progressNextPhase():
	currentPhaseIndex += 1
	# Don't run this on the first stage
	if currentPhaseIndex != 1:
		world.updateGUI()
	# Went through all the phases
	if currentPhaseIndex == len(phases):
		player.win()
		return
	# Play the next phase
	else:
		var currentPhase = phases[currentPhaseIndex].instantiate()
		add_child(currentPhase)
