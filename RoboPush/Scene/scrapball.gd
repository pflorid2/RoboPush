extends CharacterBody2D

@onready var ray = $RayCast2D

var grid_size = 320

var inputs = {
	'ui_up': Vector2.UP,
	'ui_down': Vector2.DOWN,
	'ui_left': Vector2.LEFT,
	'ui_right': Vector2.RIGHT
}

var ball1_2
var ball1_3
var ball1_2_3
var ball_2
func _ready():
	ball_2 = get_parent().get_node("MAIN_Scrap2").duplicate()
	ball1_2 = get_parent().get_node("MAIN_Scrap1_2").duplicate()
	ball1_3 = get_parent().get_node("MAIN_Scrap1_3").duplicate()
	ball1_2_3 = get_parent().get_node("MAIN_Scrap1_2_3").duplicate()
	
func increase_size():
	get_parent().add_child(ball_2)
	ball_2.position = position
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

		if collider.is_in_group('two_balls'):
			get_parent().add_child(ball1_2)
			ball1_2.position = position + vector_pos
			get_parent().remove_child(collider)
			get_parent().remove_child(self)
		elif collider.is_in_group('three_balls'):
			get_parent().add_child(ball1_3)
			ball1_3.position = position + vector_pos
			get_parent().remove_child(collider)
			get_parent().remove_child(self)
		elif collider.is_in_group('two_three_balls'):
			get_parent().add_child(ball1_2_3)
			ball1_2_3.position = position + vector_pos
			get_parent().remove_child(collider)
			var root = self.get_parent() 

			var dialog = root.get_node("AcceptDialog")
			#dialog.dialog_text = "sdas"
			dialog.visible = true
			
			get_parent().remove_child(self)
			return true
	return false

	
