extends Node2D

@onready var phaseSpawner = get_tree().get_first_node_in_group("phaseSpawner")
@onready var player = get_tree().get_first_node_in_group("player")
@onready var timerLabel = get_node("%TimerLabel")
@onready var phaseLabel = get_node("%PhaseLabel")
var time = 0  # Time in seconds
var timeFormatted = "00:00"

func _ready():
	# Resetting global data
	Global.timeAlive = ""
	Global.phasesSurvived = -1
	Global.totalNumberPhases = len(phaseSpawner.phases)
	# Centering the player
	player.position.x = get_viewport_rect().size.x / 2
	player.position.y = get_viewport_rect().size.y / 2
	
	updateGUI()

func _on_boundary_body_exited(body):
	if body.is_in_group("player"):
		body.death("Fell off the podium")

func _on_clock_timer_timeout():
	# Updating the time
	time += 1
	var mins = int(time/60.0)
	var secs = time % 60
	# Ensuring there's always leading zeros
	if mins < 10:
		mins = str(0,mins)
	if secs < 10:
		secs = str(0,secs)
	timeFormatted = str(mins, ":", secs)
	updateGUI()

func updateGUI():
	phaseLabel.text = "Phase " + str(phaseSpawner.currentPhaseIndex)
	timerLabel.text = timeFormatted
	Global.timeAlive = timeFormatted
