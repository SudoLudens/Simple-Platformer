extends Node

var player_score_value: int = 0
var player_score_text: String

func _ready():
	player_score_value = 0


func _process(delta):
	player_score_text = str(player_score_value)
