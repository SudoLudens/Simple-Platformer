extends Node

@export_file("*.tscn") var main_menu = "res://scenes/levels/menu_main.tscn"
@export_file("*.tscn") var first_level = "res://scenes/levels/lvl_demo.tscn"
@export_file("*.tscn") var second_level = "res://scenes/levels/lvl_demo.tscn"
@export_file("*.tscn") var third_level = "res://scenes/levels/lvl_demo.tscn"
@export_file("*.tscn") var fourth_level = "res://scenes/levels/lvl_demo.tscn"
@export_file("*.tscn") var fifth_level = "res://scenes/levels/lvl_demo.tscn"

var level_list = [
	main_menu,
	first_level,
	second_level,
	third_level,
	fourth_level,
	fifth_level,
]

var current_level_index: int = 0


func change_level_to_target(target_level):
	get_tree().change_scene_to_file(target_level)
	print("Switching to " + target_level)


func next_level():
	current_level_index = (current_level_index + 1) % level_list.size()
	get_tree().change_scene_to_file(level_list[current_level_index])
