extends Node2D

@onready var begin_button = $Begin
@onready var level_button = $Level
@onready var fade_effect = $"../EffectLayer".get_child(0)

@export var modulation_speed = 0.15
@export var inactive_alpha = 0.2

var next_level_path = "res://Levels/Level1.tscn"
var state = "main_menu"
var begin_button_state = true
var level_button_state = false
var fade_speed = 0.018
var target_fade = 0.0
var fade = 1.0
var exit_offset = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if state == "main_menu":
		if event.is_action_pressed("ui_cancel"):
			get_tree().quit()
		if event.is_action_pressed("ui_up") || event.is_action_pressed("ui_down"):
			begin_button_state = !begin_button_state
			level_button_state = !level_button_state
		if event.is_action_pressed("ui_accept"):
			if begin_button_state:
				state = "locked"
				target_fade = 1.0
			elif level_button_state:
				pass
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var begin_button_alpha
	var level_button_alpha
	if begin_button_state:
		begin_button_alpha = 1.0
	else:
		begin_button_alpha = inactive_alpha
	if level_button_state:
		level_button_alpha = 1.0
	else:
		level_button_alpha = inactive_alpha
	level_button.modulate.a = lerp(level_button.modulate.a, level_button_alpha, modulation_speed)
	begin_button.modulate.a = lerp(begin_button.modulate.a, begin_button_alpha, modulation_speed)
	
	if target_fade >= 1.0:
		fade = clamp(fade + target_fade * fade_speed, 0.0, 2.0)
	else:
		fade = clamp(fade - fade_speed, 0.0, 2.0)
	fade_effect.material.set_shader_parameter("luma_threshold", fade)
	
	if fade > 1 + exit_offset:
		get_tree().change_scene_to_file(next_level_path)
	pass
