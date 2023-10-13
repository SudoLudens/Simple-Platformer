extends Node

@export_file("*.tscn") var first_level = "res://scenes/levels/lvl_demo.tscn"


func change_level(target_level):
	get_tree().change_scene_to_file(target_level)
