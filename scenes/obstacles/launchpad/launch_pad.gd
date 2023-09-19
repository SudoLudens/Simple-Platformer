extends Area2D

@export var launch_force = 500


func _on_body_entered(body):
	launch(body)


func launch(body: CharacterBody2D):
	body.velocity = Vector2.ZERO
	body.velocity = Vector2.UP * launch_force
	
	$AnimatedSprite2D.play("activated")
