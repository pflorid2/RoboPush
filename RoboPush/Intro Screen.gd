extends Control



func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://first_level.tscn")



func _on_quit_pressed():
	get_tree().quit()



func _on_instructions_pressed():
	get_tree().change_scene_to_file("res://instruction_screen.tscn")
