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
func _ready():
	ball1 = get_parent().get_node("scrapball")
	ball2 = get_parent().get_node("scrapball2")


# "Level" of scrap
var scrapCount = 1

# If rolled over the scrap on the ground, increase scrap if not reached 3
func increase_size():
	if scrapCount < 3:
		scrapCount += 1
		self.set_z_index(self.get_z_index() - 1) # Tried messing with this, didn't work how I wanted.
		if scrapCount == 2:
			$Sprite2D.texture = load("res://Assets/two.png")
		elif scrapCount == 3:
			$Sprite2D.texture = load("res://Assets/three.png")

func create_1_2():
	var new_ball1 = ball1.duplicate()
	var new_ball2 = ball2.duplicate()
	get_parent().add_child(new_ball1)
	get_parent().add_child(new_ball2)
	return [new_ball1, new_ball2]

	
	

func move(dir):
	# Calculate vector and do ray stuff
	var vector_pos = inputs[dir] * grid_size
	var new_balls = create_1_2()
	new_balls[0].position = position + vector_pos
	new_balls[1].position = position
	print(self)
	get_parent().remove_child(self)
	return false
	ray.target_position = vector_pos
	ray.force_raycast_update()
	
	# If scrap ball doesn't collide with anything, then it can be pushed
	if !ray.is_colliding():
		
		position += vector_pos
		return true
	# If it does collide with something, make sure it's a bigger ball and you can put it on top
	else:
		var collider = ray.get_collider()
		if collider.is_in_group('scrapball'):
			if (collider.scrapCount > scrapCount):
				position += vector_pos
				return true
	return false

	
