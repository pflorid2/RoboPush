extends CharacterBody2D

@onready var ray = $RayCast2D

var grid_size = 320

var inputs = {
	'ui_up': Vector2.UP,
	'ui_down': Vector2.DOWN,
	'ui_left': Vector2.LEFT,
	'ui_right': Vector2.RIGHT
}

var amount = 1

func increase_size():
	if amount < 3:
		amount += 1
		self.set_z_index(self.get_z_index() - 1)
		if amount == 2:
			$Sprite2D.texture = load("res://Assets/two.png")
		elif amount == 3:
			$Sprite2D.texture = load("res://Assets/three.png")
		
	
		

func move(dir):
	var vector_pos = inputs[dir] * grid_size
	ray.target_position = vector_pos
	ray.force_raycast_update()
	if !ray.is_colliding():
		position += vector_pos
		return true
	else:
		var collider = ray.get_collider()
		if collider.is_in_group('scrapball'):
			if (collider.amount > amount):
				position += vector_pos
				return true
	return false

	
