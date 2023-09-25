extends Node

@export var demo_scene: Node2D


func _process(delta):
	if Input.is_action_just_pressed("toggle_scene"):
		toggle_scene(demo_scene)


func toggle_scene(target_scene: Node2D):
	if target_scene.process_mode == Node.PROCESS_MODE_INHERIT:
		target_scene.process_mode = Node.PROCESS_MODE_DISABLED
		target_scene.visible = false
	elif target_scene.process_mode == Node.PROCESS_MODE_DISABLED:
		target_scene.process_mode = Node.PROCESS_MODE_INHERIT
		target_scene.visible = true
	
	
	pass
