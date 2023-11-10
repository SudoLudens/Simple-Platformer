extends Node

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var animation_end_time: float

var user_skipped_intro: bool = false
var intro_has_been_skipped: bool = false


func _ready():
	user_skipped_intro = false
	animation_end_time = animation_player.get_animation("title_animation").length


func _process(delta):
	if user_skipped_intro:
		skip_intro()
	
	if Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("action"):
		user_skipped_intro = true


func _unhandled_input(event):
	if event is InputEventMouseButton:
		user_skipped_intro = true


func on_start_button_pressed():
	LevelManager.end_level()


func on_quit_button_pressed():
	get_tree().quit()


func skip_intro():
	if !intro_has_been_skipped:
		animation_player.advance(animation_end_time)
		intro_has_been_skipped = true
