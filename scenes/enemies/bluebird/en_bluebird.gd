extends Node2D

@onready var player_detection_raycast: RayCast2D = $PlayerDetectionRayCast
@onready var death_timer: Timer = $DeathTimer
@onready var animated_sprite: AnimatedSprite2D = $Path2D/PathFollow2D/CharacterBody2D/AnimatedSprite2D

@export var move_speed: float = 65

var velocity: Vector2

var direction: int = -1

var player_is_detected: bool = false
var is_attacking: bool = false


func _process(delta):
	if player_detection_raycast.get_collider() != null:
		player_is_detected = true
	else:
		player_is_detected = false

	if player_is_detected:
		if !is_attacking:
			attack_player(player_detection_raycast.get_collision_point())


func _physics_process(delta):
	velocity = Vector2.ZERO
	
	if !is_attacking:
		velocity.x = direction * move_speed * delta
	
	position += velocity


func attack_player(collision_point: Vector2):
	print("attacking player")
	is_attacking = true


func take_damage():
	animated_sprite.play("hurt")
	death_timer.start()


func _on_death_timer_timeout():
	queue_free()
