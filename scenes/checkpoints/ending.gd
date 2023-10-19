extends Area2D


func _on_body_entered(body):
	if body.is_in_group("player"):
		level_finished()


func level_finished():
	print("level finished")
	LevelManager.next_level()
