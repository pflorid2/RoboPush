extends CharacterBody2D

@onready var ray = $RayCast2D

var grid_size = 320

var inputs = {
	'ui_up': Vector2.UP,
	'ui_down': Vector2.DOWN,
	'ui_left': Vector2.LEFT,
	'ui_right': Vector2.RIGHT
}

func move(dir):
	# Calculate vector and do ray stuff
	var vector_pos = inputs[dir] * grid_size
	ray.target_position = vector_pos
	ray.force_raycast_update()
	
	# If scrap ball doesn't collide with anything, then it can be pushed
	if !ray.is_colliding():
		position += vector_pos
		return true
	# If it does collide with something, make sure it's a bigger ball and you can put it on top
#	else:
#		var collider = ray.get_collider()
#		if collider.is_in_group('scrapball'):
#			if (collider.scrapCount > scrapCount):
#				position += vector_pos
#				return true
	return false

	
