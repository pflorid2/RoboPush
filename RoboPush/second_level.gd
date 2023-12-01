extends Node2D




func _on_accept_dialog_confirmed():
	global.levels_completed[2] = true
	if global.warping:
		global.warping = false
		get_tree().change_scene_to_file("res://level_select_screen.tscn")
	else:
		get_tree().change_scene_to_file("res://intro_screen.tscn")
