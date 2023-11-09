extends CharacterBody2D

@onready var ray = $RayCast2D

var grid_size = 320

var inputs = {
	'ui_up': Vector2.UP,
	'ui_down': Vector2.DOWN,
	'ui_left': Vector2.LEFT,
	'ui_right': Vector2.RIGHT
}

## "Level" of scrap
#var scrapCount = 1
#
## If rolled over the scrap on the ground, increase scrap if not reached 3
#func increase_size():
#	if scrapCount < 3:
#		scrapCount += 1
#		self.set_z_index(self.get_z_index() - 1) # Tried messing with this, didn't work how I wanted.
#		if scrapCount == 2:
#			$Sprite2D.texture = load("res://Assets/two.png")
#		elif scrapCount == 3:
#			$Sprite2D.texture = load("res://Assets/three.png")
var ball1_2
func _ready():
	ball1_2 = get_parent().get_node("scrapball_1_2")

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
			var new_ball1_2 = ball1_2.duplicate()
			get_parent().add_child(new_ball1_2)
			new_ball1_2.position = position + vector_pos
			get_parent().remove_child(collider)
			get_parent().remove_child(self)
			print("here")
			print(collider)
			
			return true
	return false

	
