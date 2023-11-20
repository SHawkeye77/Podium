extends Node2D

@onready var scoreLabel = get_node("%ScoreLabel")
@onready var phaseLabel = get_node("%PhaseLabel")
var startScreen = "res://screens/main_menu.tscn"

func _ready():
	scoreLabel.text = "Time alive: " + Global.timeAlive
	# Victory
	if Global.phasesSurvived == Global.totalNumberPhases - 1:
		phaseLabel.text = "Congratulations! You survived all " + str(Global.phasesSurvived) + " phases!"
	# Loss
	else:
		phaseLabel.text = "You survived " + str(Global.phasesSurvived) + " phases!"

func _on_main_menu_button_pressed():
	var _level = get_tree().change_scene_to_file(startScreen)
