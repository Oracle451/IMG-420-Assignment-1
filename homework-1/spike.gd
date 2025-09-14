extends Area2D

# Amount of health to subtract
@export var damage: int = 10
# Amount of blowback upon giving damage
@export var bounce_force: Vector2 = Vector2(200, -400) 

# When the player touches the spike, deal out damage and deliver knockback to the player node
func _on_body_entered(body):
	# Make sure only the player is damaged
	if body.is_in_group("player"):
		if body.has_method("apply_damage"):
			var direction = sign(global_position.x - body.global_position.x)
			# Flip horizontal knockback so we push away from spike
			body.velocity.x = bounce_force.x * direction * -1
			body.velocity.y = bounce_force.y
			
			body.apply_damage(damage)
