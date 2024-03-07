extends Node2D

@onready var main_menu_path = "res://Levels/MainMenu.tscn"
@onready var audio_stream = $"../Background_music"

var retry_timeout = 1.0
var retry_timer = 0.0
var timer_enabled = false
var target_volume_db = 0.0
var volume_decrease_speed = 0.02

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer_enabled:
		retry_timer += delta
		if retry_timer > retry_timeout:
			print("time exceeded")
			var current_scene_path = get_tree().current_scene.scene_file_path
			get_tree().change_scene_to_file(current_scene_path)
	else:
		retry_timer = 0
		
	if audio_stream != null:
		audio_stream.volume_db = lerp(audio_stream.volume_db, target_volume_db, volume_decrease_speed)

func _input(event):
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_R:
			timer_enabled = true
			target_volume_db = -30.0
	if event is InputEventKey and event.is_released():
		if event.keycode == KEY_R:
			timer_enabled = false
			target_volume_db = 0.0
			
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file(main_menu_path)
