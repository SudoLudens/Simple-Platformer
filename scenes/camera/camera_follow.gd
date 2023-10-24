extends Camera2D

@export var sync_limit_top: bool = false
@export var sync_limit_bottom: bool = false
@export var sync_limit_left: bool = false
@export var sync_limit_right: bool = false

@onready var limit_marker_top: Marker2D = $MarkerContainer/LimitTop
@onready var limit_marker_bottom: Marker2D = $MarkerContainer/LimitBottom
@onready var limit_marker_left: Marker2D = $MarkerContainer/LimitLeft
@onready var limit_marker_right: Marker2D = $MarkerContainer/LimitRight

var follow_target: Node2D


func _ready():
	follow_target = get_tree().get_first_node_in_group("player")
	
	# Move limits to marker positions
	# Set Markers in level editor
	if sync_limit_top:
		limit_top = limit_marker_top.position.y
	
	if sync_limit_bottom:
		limit_bottom = limit_marker_bottom.position.y
	
	if sync_limit_left:
		limit_left = limit_marker_left.position.x
	
	if sync_limit_right:
		limit_right = limit_marker_right.position.x


func _process(delta):
	if follow_target != null:
		position.x = follow_target.global_position.x
