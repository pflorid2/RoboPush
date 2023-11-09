extends CharacterBody2D

@onready var ray = $RayCast2D

# Sprite size 320 x 320
var grid_size = 320

# Get input movements
var inputs = {
	'ui_up': Vector2.UP,
	'ui_down': Vector2.DOWN,
	'ui_left': Vector2.LEFT,
	'ui_right': Vector2.RIGHT
}

# Call move on the direction pressed
func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)


func move(dir):
	# Calculate vector of movement direction
	var vector_pos = inputs[dir] * grid_size
	
	# Set ray to that vector
	ray.target_position = vector_pos
	ray.force_raycast_update()
	
	# If that is nto colliding with anything, move the player
	if !ray.is_colliding():
		position += vector_pos
	# Otherwise, get the collider and if it's a scrap ball
	else:
		var collider = ray.get_collider()
		print(collider)
		print(collider.get_z_index())
		if collider.is_in_group('all_balls'):
			# Call move on the scrap ball passing in the direction we pressed... If the ball moved
			# also move us.
			if collider.move(dir):
				position += vector_pos
