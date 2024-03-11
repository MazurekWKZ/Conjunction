extends Node2D

@onready var begin_button = $Begin
@onready var level_button = $Level
@onready var fade_effect = $"../EffectLayer".get_child(0)

@export var next_level_path = "res://Levels/Level1.tscn"


var fade_speed = 0.018
var target_fade = 0.0
var fade = 1.0
var exit_offset = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_pressed():
		target_fade = 1.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target_fade >= 1.0:
		fade = clamp(fade + target_fade * fade_speed, 0.0, 2.0)
	else:
		fade = clamp(fade - fade_speed, 0.0, 2.0)
	fade_effect.material.set_shader_parameter("luma_threshold", fade)
	
	if fade > 1 + exit_offset:
		get_tree().change_scene_to_file(next_level_path)
	pass
