extends CharacterBody2D

@onready var player_detection_raycast: RayCast2D = $PlayerDetectionRayCast

@export var move_speed: float = 65

var direction: int = -1

var player_is_detected: bool = false


func _process(delta):
	if player_detection_raycast.get_collider() != null:
		player_is_detected = true
	else:
		player_is_detected = false
	
	if player_is_detected:
		attack_player()


func _physics_process(delta):
	velocity.x = direction * move_speed
	
	move_and_slide()


func attack_player():
	print("attacking player")
