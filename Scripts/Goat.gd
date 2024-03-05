extends Node2D

@onready var head_node = $Head_node

@export var target_node: Node2D
@export var rotation_speed = 0.05
@export var rotation_range = PI/6
@export var scaling_factor = 0.001
@export var scaling_speed = 0.1
@export var scaling_minimum = 0.1

var target_rotation = PI/2
var target_scale = 1.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target_node.global_position.y > (head_node.global_position.y + 32.0):
		var delta_position = target_node.global_position - head_node.global_position
		target_rotation = delta_position.angle()
		target_scale = 1.0 - clamp((abs(delta_position.x) * scaling_factor), 0.0, scaling_minimum)
	else:
		target_rotation = PI/2
		target_scale = 1.0
	
func _physics_process(delta):
		var clamped_rotation = clamp(target_rotation, PI/2 - rotation_range, PI/2 + rotation_range)
		head_node.rotation = lerp(head_node.rotation, clamped_rotation, rotation_speed)
		head_node.scale = lerp(head_node.scale, Vector2(1.0, target_scale), scaling_speed)
		
