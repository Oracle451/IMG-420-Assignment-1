extends Area2D

# Array of objects that the button can hide and show
@export var platforms: Array[NodePath] = ["../Platform1", "../Platform2", "../Spike6","../Spike7"] 

# Boolean to keep track of if the player is close
var player_nearby: bool = false

# 
func _ready():
	# Connect body entered and exited signals to their functions
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _process(_delta):
	# If the player is nearby and they punch then toggle the platforms
	if player_nearby and Input.is_action_just_pressed("Punch"):
		toggle_platforms()

func _on_body_entered(body):
	# If the player body entered the button collision area then set player nearby to true
	if body.is_in_group("player"):
		player_nearby = true

func _on_body_exited(body):
	# If the player body exited the button collision area then set player nearby to false
	if body.is_in_group("player"):
		player_nearby = false

func toggle_platforms():
	# Change the buttons sprite from on to off by swapping frames
	if $AnimatedSprite2D.frame == 1:
		$AnimatedSprite2D.frame = 0
	else:
		$AnimatedSprite2D.frame = 1
		
	# Play the button press sound effect
	$ButtonPressSound.play()
		
	# Go through each node in the platforms array
	for path in platforms:
		var platform = get_node(path)

		# Toggle visibility
		platform.visible = !platform.visible

		# Toggle all Collision objects in the nodes children
		for child in platform.get_children():
			if child is CollisionShape2D or child is CollisionPolygon2D:
				child.disabled = not platform.visible
