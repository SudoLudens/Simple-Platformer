extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var recover_timer: Timer = $RecoverTimer

@export var move_speed: float = 120
@export var jump_force: float = -325.0
@export var hurt_launch_force: float = 50

var direction: float

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

var can_update_anim: bool = true
var can_move: bool = true


func _process(delta):
	input_intake()
	handle_animation()
	sprite_direction()


func _physics_process(delta):
	handle_movement(delta)

	move_and_slide()


func handle_movement(passed_delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * passed_delta
	
	
	if !can_move:
		return
	
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force

	# Get the input direction and handle the movement/deceleration.
	if direction:
		velocity.x = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)


func input_intake():
	direction = Input.get_axis("move_left", "move_right")


func handle_animation():
	if !can_update_anim:
		return
	
	# Idle
	if !direction:
		animated_sprite.play("idle")
	
	# Running
	if direction and is_on_floor():
		animated_sprite.play("run")
	
	# Jumping
	if velocity.y < 0 and !is_on_floor():
		animated_sprite.play("jump")
	
	# Falling
	if velocity.y > 0 and !is_on_floor():
		animated_sprite.play("fall")


func sprite_direction():
	if !can_move:
		return
	
	if direction:
		var facing_right = direction > 0
		
		if facing_right:
			animated_sprite.flip_h = false
			
		if !facing_right:
			animated_sprite.flip_h = true


func hurt(body):
	can_update_anim = false
	can_move = false
	animated_sprite.play("hurt")
	recover_timer.start()
	
	var hurt_direction_factor = global_position.x - body.global_position.x
	var hurt_direction = hurt_direction_factor / abs(hurt_direction_factor)
	velocity = Vector2(hurt_direction * 100, -150)


func _on_hurtbox_body_entered(body):
	if body.is_in_group("enemies"):
		hurt(body)


func _on_recover_timer_timeout():
	can_update_anim = true
	can_move = true


# Handle Attack
func _on_jump_hit_box_body_entered(body):
	if body.is_in_group("enemies"):
		if body.has_method("take_damage"):
			body.call("take_damage")
		
		if Input.is_action_pressed("jump"):
			velocity.y = jump_force * 1.25
		else:
			velocity.y = jump_force


func _on_tree_exited():
	print("Player died")
