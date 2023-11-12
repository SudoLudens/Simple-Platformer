extends CanvasLayer


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var color_rect: ColorRect = $ColorRect
@onready var window_size: Vector2 = Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"), ProjectSettings.get_setting("display/window/size/viewport_height"))


# Called when the node enters the scene tree for the first time.
func _ready():
	color_rect.size = window_size
	visible = true
	
	LevelManager.on_level_end.connect(play_outro_animation)
	
	play_intro_animation()


func _process(delta):
	pass


func play_intro_animation():
	animation_player.play("begin")


func play_outro_animation():
	animation_player.play("end")
