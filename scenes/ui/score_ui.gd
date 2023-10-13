extends CanvasLayer

@onready var score_label: Label = $ScoreLabel


func _process(delta):
	score_label.text = Global.player_score_text
