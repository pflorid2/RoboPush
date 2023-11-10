extends CharacterBody2D

@onready var ray = $RayCast2D

var grid_size = 320

var inputs = {
	'ui_up': Vector2.UP,
	'ui_down': Vector2.DOWN,
	'ui_left': Vector2.LEFT,
	'ui_right': Vector2.RIGHT
}

var ball2
var ball2_3
var ball_3

func _ready():
	ball2 = get_parent().get_node("MAIN_Scrap2").duplicate()
	ball_3 = get_parent().get_node("MAIN_Scrap3").duplicate()
	ball2_3 = get_parent().get_node("MAIN_Scrap2_3").duplicate()
	
func increase_size():
	get_parent().add_child(ball_3)
	ball_3.position = position 
	get_parent().remove_child(self)
	
func move(dir):
	# Calculate vector and do ray stuff
	var vector_pos = inputs[dir] * grid_size
	ray.target_position = vector_pos
	ray.force_raycast_update()
	
	# If scrap ball doesn't collide with anything, then it can be pushed
	if !ray.is_colliding():
		position += vector_pos
		return true
#	# If it does collide with something, make sure it's a bigger ball and you can put it on top
	else:
		var collider = ray.get_collider()

		if collider.is_in_group('three_balls'):
			get_parent().add_child(ball2_3)
			ball2_3.position = position + vector_pos
			get_parent().remove_child(collider)
			get_parent().remove_child(self)
			return true
	return false

	
