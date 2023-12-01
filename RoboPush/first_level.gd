extends Node2D





func _on_accept_dialog_confirmed():
	get_tree().change_scene_to_file("res://second_level.tscn")
