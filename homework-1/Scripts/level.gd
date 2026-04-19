extends Node2D

# Make a variable for the pause and game over scene
var pause_scene = preload("res://PauseMenu.tscn")
var game_over_scene = preload("res://game_over.tscn")

# Make variables for the health gui and player node
@onready var HealthMonitor  = $Health
@onready var player = $Player

# Set the health monitor to contain the players health
func _ready():
	set_process_input(true)
	HealthMonitor.text = "Health: %s" % player.health

# Make an instance of the pause menu and call it when the pause button is pressed
func _input(event):
	if event.is_action_pressed("Pause") and not get_tree().paused and not get_tree().root.has_node("GameOver"):
		var pause_instance = pause_scene.instantiate()
		pause_instance.name = "PauseMenu"
		pause_instance.process_mode = Node.PROCESS_MODE_ALWAYS  # Ensure buttons work
		add_child(pause_instance)
		
# Constantly update the player health gui
func _process(_float):
	HealthMonitor.text = "Health: %s" % player.health
	if player.health <= 0:
		trigger_game_over()

# Call the game over function when the signal is recieved
func trigger_game_over():
	var game_over_instance = game_over_scene.instantiate()
	game_over_instance.name = "GameOver"
	game_over_instance.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(game_over_instance)
