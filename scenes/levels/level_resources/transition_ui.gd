extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var color_rect: ColorRect = $ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	color_rect.size = Vector2(1152, 648)
	
	LevelManager.on_level_end.connect(play_outro_animation)
	
	play_intro_animation()


func play_intro_animation():
	animation_player.play("begin")


func play_outro_animation():
	animation_player.play("end")
