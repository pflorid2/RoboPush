extends Area2D

# Did a scrap ball roll over this ground scrap
var scrapTaken = false


func _on_body_entered(body):
	# If scrap ball rolls over ground scrap and scrap hasn't been taken
	if (body.is_in_group('one_balls') or body.is_in_group('two_balls')) and !scrapTaken:
		# Set to taken, update texture (we could maybe also just delete it), and increase scrap ball size
		scrapTaken = true
		$Sprite2D.texture = load("res://Assets/scrapgone.png")
		body.increase_size()

func _on_body_exited(body):
	pass # Replace with function body.
