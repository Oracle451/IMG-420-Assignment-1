extends CanvasLayer

# Launch the level when the user presses play
func playButtonPressed():
	get_tree().change_scene_to_file("res://level.tscn")

# Quit the game when the quit button is pressed
func ExitButtonPressed():
	get_tree().quit()
