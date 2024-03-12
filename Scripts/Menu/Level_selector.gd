extends Node2D

@onready var fade_effect = $"../EffectLayer".get_child(0)
@onready var items = $"../Items".get_children()
@export var modulation_speed = 0.15
@export var inactive_alpha = 0.2

var next_level_path = "res://Levels/Level1.tscn"
var state = "main_menu"
var fade_speed = 0.018
var target_fade = 0.0
var fade = 1.0
var exit_offset = 0.1
var selected_item = 0
var row = 0
var column = 0
var rows = 2
var columns = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if state == "main_menu":
		if event.is_action_pressed("ui_up"):
			if !row == 0:
				row -= 1
			else:
				row = rows -1
		if event.is_action_pressed("ui_down"):
			if row != rows - 1:
				row += 1
			else:
				row = 0
		if event.is_action_pressed("ui_left"):
			if column != 0:
				column -= 1
			else:
				column = columns -1
				if row != 0:
					row -= 1
				else:
					row = rows - 1
		if event.is_action_pressed("ui_right"):
			if column != columns - 1:
				column += 1
			else:
				column = 0
				if row != rows -1:
					row += 1
				else:
					row = 0
		selected_item = row * columns + column
		print(selected_item)
		if event.is_action_pressed("ui_accept"):
			if state != "locked":
				state = "locked"
				target_fade = 1.0
				next_level_path = "res://Levels/Level" + str(selected_item + 1) + ".tscn"
		if event.is_action_pressed("ui_cancel"):
			state = "locked"
			target_fade = 1.0
			next_level_path = "res://Levels/MainMenu.tscn"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var i = 0
	for N in items:
		if i == selected_item:
			N.modulate.a = lerp(N.modulate.a, 1.0, modulation_speed)
		else:
			N.modulate.a = lerp(N.modulate.a, inactive_alpha, modulation_speed)
		i += 1
	if target_fade >= 1.0:
		fade = clamp(fade + target_fade * fade_speed, 0.0, 2.0)
	else:
		fade = clamp(fade - fade_speed, 0.0, 2.0)
	fade_effect.material.set_shader_parameter("luma_threshold", fade)
	
	if fade > 1 + exit_offset:
		get_tree().change_scene_to_file(next_level_path)
	pass
