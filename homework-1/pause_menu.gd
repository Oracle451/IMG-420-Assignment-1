extends CanvasLayer

# 
func _ready():
	print("Pause Menu: Pause menu loaded")
	# Pause game when menu appears
	get_tree().paused = true

func ResumeButtonPressed():
	print("Pause Menu: Resume button pressed")
	# Unpause
	get_tree().paused = false
	# Remove self
	queue_free()

func ExitButtonPressed():
	print("Pause Menu: Exit button pressed")
	# Unpause
	get_tree().paused = false
	get_tree().change_scene_to_file("res://MainMenu.tscn")
