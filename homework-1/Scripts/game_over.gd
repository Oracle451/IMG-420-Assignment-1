extends CanvasLayer

# Get the player nodepath as a variable
@export var PlayerNode:NodePath = "Player"

func _ready():
	var player = get_tree().current_scene.get_node("Player")
	print("Game over screen loaded")
	# Use the players health as an indicator of if they won or not
	if player.health <= 0:
		$GameOverLabel.text = "You Died!"
	else:
		$GameOverLabel.text = "You Won!"
	# Pause game when game over screen appears
	get_tree().paused = true

# Reload the level scene when the restart button is pressed
func _on_restart_pressed():
	print("Restart button pressed")
	get_tree().paused = false
	# Reload Level.tscn
	get_tree().reload_current_scene()

# Return to the main menu scene when the main menu button is pressed
func _on_main_menu_pressed():
	print("Main Menu button pressed")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://MainMenu.tscn")
