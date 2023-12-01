extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_accept_dialog_confirmed():
	global.levels_completed[2] = true
	if global.warping:
		global.warping = false
		get_tree().change_scene_to_file("res://level_select_screen.tscn")
	else:
		get_tree().change_scene_to_file("res://intro_screen.tscn")
