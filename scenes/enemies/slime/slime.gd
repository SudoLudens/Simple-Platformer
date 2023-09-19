extends CharacterBody2D

@onready var ground_check_raycast: RayCast2D = $GroundCheckRayCast
@onready var wall_check_raycast: RayCast2D = $WallCheckRayCast
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_timer: Timer = $DeathTimer

@export var move_speed: float = 30
@export var can_walk_off_ledges: bool = false


var direction: float = 1
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")


func _process(delta):
	handle_flip()


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	velocity.x = direction * move_speed
	
	move_and_slide()


func handle_flip():
	# Face character toward movement direction
	if direction < 0:
		# Face Left
		scale.x = abs(scale.x)
		scale.y = abs(scale.y)
		rotation_degrees = 0
	elif direction > 0:
		# Face right
		scale.x = abs(scale.x)
		scale.y = -abs(scale.y)
		rotation_degrees = 180
	
	# Handle whether character flips at ledge ends
	if !can_walk_off_ledges:
		if !ground_check_raycast.get_collider():
			flip()
	
	# Handle flipping when hitting wall
	if wall_check_raycast.get_collider():
		flip()


func flip():
	direction *= -1


func flip_at_ledge():
	if !can_walk_off_ledges:
		if !ground_check_raycast.get_collider():
			print("turnaround")


func _on_flip_timer_timeout():
	flip()


func take_damage():
	animated_sprite.play("hurt")
	death_timer.start()


func _on_death_timer_timeout():
	queue_free()
