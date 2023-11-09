extends CharacterBody2D

@onready var ray = $RayCast2D

var grid_size = 320

var inputs = {
	'ui_up': Vector2.UP,
	'ui_down': Vector2.DOWN,
	'ui_left': Vector2.LEFT,
	'ui_right': Vector2.RIGHT
}

var ball1;
var ball2;
var ball3;
var ball1_2;
var ball2_3;

func _ready():
	ball1 = get_parent().get_node("MAIN_Scrap1").duplicate()
	ball2 = get_parent().get_node("MAIN_Scrap2").duplicate()
	ball1_2 = get_parent().get_node("MAIN_Scrap1_2").duplicate()
	ball3 = get_parent().get_node("MAIN_Scrap3").duplicate()

func move(dir):
	# Calculate vector and do ray stuff
	var vector_pos = inputs[dir] * grid_size
	
	ray.target_position = vector_pos
	ray.force_raycast_update()
	
	# If scrap ball doesn't collide with anything, then it can be pushed
	if !ray.is_colliding():
		get_parent().add_child(ball1)
		get_parent().add_child(ball2)
		ball1.position = position + vector_pos
		ball2.position = position
		get_parent().remove_child(self)
		return false

	# If it does collide with something, make sure it's a smaller ball and you can put it on top
	else:
		var collider = ray.get_collider()
		if collider.is_in_group('two_balls'):
			get_parent().add_child(ball1_2)
			get_parent().add_child(ball2)
			ball1_2.position = position + vector_pos
			ball2.position = position
			get_parent().remove_child(collider)
			get_parent().remove_child(self)
			return false
		elif collider.is_in_group('two_three_balls'):
			get_parent().add_child(ball1_2)
			get_parent().add_child(ball2)
			ball1_2.position = position + vector_pos
			ball2.position = position
			get_parent().remove_child(collider)
			get_parent().remove_child(self)
			return false
			
	return false

	
