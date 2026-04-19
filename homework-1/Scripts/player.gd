extends CharacterBody2D

# Set constants for the player speed, jump, gravity, and crouch height
const NORMAL_SPEED = 300.0
const SPRINT_SPEED = 600.0
const JUMP_VELOCITY = -1000.0
const GRAVITY = 1500.0
const CROUCH_SCALE = 0.5

# Create Variables for the players collision shape and animated sprite
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionBox

# Save the orginal player collision shape so it can be restored after crouching
var original_shape_extents: Vector2
# Booleans to tell if the player is in a crouching state or performing an important action
var is_crouching: bool = false
var is_actioning: bool = false
# Variable to record the players animation before they took an important action
var previous_animation: String = ""

# Set variables for the players health and max health potential
var max_health: float = 100.0
var health: float = 100.0:
	set(value):
		health = clamp(value, 0.0, max_health)

func _ready() -> void:
	# Store original collision shape extents
	if collision_shape.shape is RectangleShape2D:
		original_shape_extents = collision_shape.shape.extents
		
	# Disable looping for action animations
	animated_sprite.sprite_frames.set_animation_loop("Punch", false)
	animated_sprite.sprite_frames.set_animation_loop("Defense", false)
	animated_sprite.sprite_frames.set_animation_loop("CrouchAttack", false)
	animated_sprite.sprite_frames.set_animation_loop("Throw", false)
	animated_sprite.sprite_frames.set_animation_loop("Damage", false)

func _physics_process(delta: float) -> void:
	# Set the is crouching variable according to if the player is holding the crouch key
	is_crouching = Input.is_action_pressed("Crouch")
	
	# Update collision shape for crouching
	if collision_shape.shape is RectangleShape2D:
		if is_crouching and is_on_floor():
			collision_shape.shape.extents = Vector2(original_shape_extents.x, original_shape_extents.y * CROUCH_SCALE)
			collision_shape.position.y = original_shape_extents.y * (1.0 - CROUCH_SCALE)  # Adjust to keep feet grounded
		else:
			collision_shape.shape.extents = original_shape_extents
			collision_shape.position.y = 0.0  # Reset position
	
	# Apply gravity only if not on the floor
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Handle jump input
	if Input.is_action_just_pressed("Jump") and is_on_floor() and not is_crouching:
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction
	var direction = Input.get_axis("MoveLeft", "MoveRight")
	# Set the players speed according to if they are sprinting or not
	var speed = NORMAL_SPEED
	if Input.is_action_pressed("Sprint") and not is_crouching:
		speed = SPRINT_SPEED
	elif is_crouching:
		speed = 0
	
	# If the player is not in the middle of an important action then move
	if not is_actioning:
		if direction != 0:
			velocity.x = direction * speed
			animated_sprite.flip_h = direction < 0
		else:
			velocity.x = move_toward(velocity.x, 0, speed)

	# Apply movement and handle collisions
	move_and_slide()
	
	# Handle Important action inputs
	if not is_actioning and is_on_floor(): 
		if Input.is_action_just_pressed("Punch") and not is_crouching:
			previous_animation = animated_sprite.animation  # Store current
			animated_sprite.play("Punch")
			is_actioning = true
			var direction_sign = 1
			if animated_sprite.flip_h:
				direction_sign = -1
			velocity.x += direction_sign * 100
			
		elif Input.is_action_just_pressed("Punch") and is_crouching:
			previous_animation = animated_sprite.animation  # Store current
			animated_sprite.play("CrouchAttack")
			is_actioning = true
		elif Input.is_action_just_pressed("Throw") and is_crouching:
			previous_animation = animated_sprite.animation  # Store current
			animated_sprite.play("CrouchAttack")
			is_actioning = true
		elif Input.is_action_just_pressed("Defense") and not is_crouching:
			previous_animation = animated_sprite.animation
			animated_sprite.play("Defense")
			is_actioning = true
		elif Input.is_action_just_pressed("Fakeout") and not is_crouching:
			previous_animation = animated_sprite.animation
			animated_sprite.play("Damage")
			health-=10
			$DamageSound.play()
			is_actioning = true
		elif Input.is_action_just_pressed("Throw") :
			previous_animation = animated_sprite.animation
			animated_sprite.play("Throw")
			is_actioning = true
			
	# Handle standard player inputs
	if not is_actioning:
		# Update animations based on state
		if is_on_floor():
			if is_crouching:
				animated_sprite.play("Crouch")
				
			elif abs(velocity.x) > 10 and Input.is_action_pressed("Sprint"):
				animated_sprite.play("Run")
				
			elif abs(velocity.x) > 10:
				animated_sprite.play("Walk")
				
			else:
				animated_sprite.play("Idle")
				
		else:
			if velocity.y < 0:
				animated_sprite.play("Jump")
				
			else:
				animated_sprite.play("Fall")
			
# Callback when an important sprite animation finishes
func _on_sprite_animation_finished() -> void:
	if animated_sprite.animation in ["Punch", "Defense", "Damage", "Throw", "CrouchAttack"]:
		is_actioning = false
		# Resume previous animation or default to Idle
		if previous_animation.is_empty():
			previous_animation = "Idle"
		animated_sprite.play(previous_animation)
		previous_animation = ""
		
# Player function to heal when they contact the health pickup
func heal(amount: int):
	health = min(health + amount, max_health)
	print("Healed! Current health:", health)
	
# Player function to take damage when they encounter spikes
func apply_damage(amount: int):
	health -= amount
	previous_animation = animated_sprite.animation
	animated_sprite.play("Damage")
	$DamageSound.play()
	is_actioning = true
	print("Player took damage! Health:", health)
