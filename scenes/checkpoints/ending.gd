extends Area2D

@export var is_active: bool = true


func _on_body_entered(body):
	if body.is_in_group("player") and is_active:
		level_finished()


func level_finished():
	print("level finished")
	LevelManager.end_level()
