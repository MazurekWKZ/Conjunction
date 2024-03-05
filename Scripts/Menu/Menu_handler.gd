extends Node2D

@onready var begin_button = $Begin
@onready var level_button = $Level

@export var modulation_speed = 0.15
@export var inactive_alpha = 0.2

var next_level_path = "res://Levels/TestLevel.tscn"
var state = "main_menu"
var begin_button_state = true
var level_button_state = false
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
				get_tree().change_scene_to_file(next_level_path)
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
	pass
