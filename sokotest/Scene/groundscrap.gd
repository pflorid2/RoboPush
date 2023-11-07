extends Area2D


var taken = false





func _on_body_entered(body):
	if body.is_in_group('scrapball') and !taken:
		taken = true
		body.increase_size()
		$Sprite2D.texture = load("res://Assets/snowgone.png")
		


func _on_body_exited(body):
	pass # Replace with function body.
