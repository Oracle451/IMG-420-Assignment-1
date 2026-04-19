extends Area2D

# Create a signal indicating that the player won
signal player_won

# When the player enters the flag area emit the winning signal
func _on_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("player_won")
