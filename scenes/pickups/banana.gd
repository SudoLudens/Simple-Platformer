extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var value: int = 1

var is_collected: bool = false





func _on_body_entered(body):
	if body.is_in_group("player"):
		if !is_collected:
			is_collected = true
			animated_sprite.play("grabbed")
			Global.player_score_value += value


func _on_animated_sprite_2d_animation_finished():
	queue_free()
