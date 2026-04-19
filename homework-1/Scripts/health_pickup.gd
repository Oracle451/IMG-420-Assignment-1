extends Area2D

# Amount of health the picup will restore
@export var heal_amount: int = 25
# Float Height
@export var bob_height: float = 10.0
# Float Speed
@export var bob_speed: float = 2.0
# Seconds before pickup respawns
@export var respawn_time: float = 10.0

# Store variables for starting position and a time counter
var start_position: Vector2
var time_passed: float = 0.0

# Place the pickup in its starting location
func _ready():
	start_position = position

func _process(delta: float):
	# Only bob when visible
	if visible:
		time_passed += delta
		position.y = start_position.y + sin(time_passed * bob_speed) * bob_height

# Heal the player when they come into contact with the pickup
func _on_body_entered(body):
	if visible and body.has_method("heal"):
		$HealthPickupSound.play()
		print("Body Entered Pickup")
		body.heal(heal_amount)
		hide()  # Hide pickup
		set_deferred("monitoring", false)  # Disable collision detection
		respawn()  # Start respawn timer

# Function to have the pickup hide for 10 seconds then reappear
func respawn():
	await get_tree().create_timer(respawn_time).timeout
	# Reset position in case it moved during bobbing
	position = start_position
	time_passed = 0.0
	# Show pickup again
	show()
	$HealthRespawnSound.play()
	# Re-enable collision detection
	set_deferred("monitoring", true)
