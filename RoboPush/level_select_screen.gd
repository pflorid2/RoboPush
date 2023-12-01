extends Control


func _on_level_1_button_pressed():
	global.warping = true
	get_tree().change_scene_to_file("res://first_level.tscn")
	


func _on_level_2_button_pressed():
	global.warping = true
	get_tree().change_scene_to_file("res://second_level.tscn")
