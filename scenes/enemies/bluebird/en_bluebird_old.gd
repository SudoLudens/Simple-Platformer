extends CharacterBody2D

@onready var player_detection_raycast: RayCast2D = $PlayerDetectionRayCast

@export var move_speed: float = 65

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
	if !is_attacking:
		velocity.x = direction * move_speed
	
		move_and_slide()


func attack_player(collision_point: Vector2):
	print("attacking player")
	is_attacking = true
	var swoop_tween = create_tween()

