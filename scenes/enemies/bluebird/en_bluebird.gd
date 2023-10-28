extends CharacterBody2D

@onready var player_detection_raycast: RayCast2D = $PlayerDetectionRayCast
@onready var death_timer: Timer = $DeathTimer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var move_speed: float = 65
@export var attack_rotation: float = -32

var target: Node2D

var direction: Vector2 = Vector2(-1, 0)
var collision_location: Vector2 = Vector2.ZERO

var player_is_detected: bool = false
var can_move: bool = true
var can_detect: bool = true


func _process(delta):
	if player_detection_raycast.get_collider() != null:
		player_is_detected = true
	else:
		player_is_detected = false

	if player_is_detected && can_detect:
		can_detect = false
		queue_attack(player_detection_raycast.get_collision_point(), player_detection_raycast.get_collider())


func _physics_process(delta):
	if can_move:
		velocity = direction.normalized() * move_speed
	
		move_and_slide()


func queue_attack(collision_point: Vector2, colliding_object: Node2D):
	can_move = false
	collision_location = collision_point
	animated_sprite.play("flap")
	target = colliding_object


func _on_animated_sprite_2d_animation_finished():
	launch_attack()


func launch_attack():
	animated_sprite.play("attack")
	rotation = attack_rotation
	direction = target.position - position
	direction = direction.normalized()
	move_speed = 500
	
	can_move = true


func take_damage():
	animated_sprite.play("hurt")
	death_timer.start()


func _on_death_timer_timeout():
	queue_free()
